#include <stddef.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <zlib.h>

#include <linux/pkt_cls.h>
#include <linux/swab.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>
#include <linux/in.h>

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>


#include "common_kern_user.h"
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"

#define bpf_printk(fmt, ...)                                    \
({                                                              \
        char ____fmt[] = fmt;                                   \
        bpf_trace_printk(____fmt, sizeof(____fmt),              \
                         ##__VA_ARGS__);                        \
})

#ifndef lock_xadd
#define lock_xadd(ptr, val)((void) __sync_fetch_and_add(ptr, val))
#endif


struct auth_hdr {
  uint8_t msgType;
  uint32_t challenge1;
  uint32_t challenge2;
  uint64_t randomnumber1;
  uint64_t randomnumber2;
  uint32_t hash;
  uint32_t identifier;
  uint64_t prTime;
}
__attribute__((packed));


struct bpf_map_def SEC("maps") cr_db_map = {
  .type = BPF_MAP_TYPE_ARRAY,
  .key_size = sizeof(__u32),
  .value_size = sizeof(struct crPair),
  .max_entries = total_no_of_crps,
};

struct bpf_map_def SEC("maps") hashValues = {
  .type = BPF_MAP_TYPE_ARRAY,
  .key_size = sizeof(__u32),
  .value_size = sizeof(__u32),
  .max_entries = no_of_IOT,
};



struct bpf_map_def SEC("maps") crc32_table = {
  .type = BPF_MAP_TYPE_ARRAY,
  .key_size = sizeof(__u32),
  .value_size = sizeof(__u32),
  .max_entries = hashcrc32size,
};


static __u32 computeHash(__u64 input_ints[],__u32 num_ints)
{
    /*__u64 sum = r1 + r2 + rn;
    __u32 hash = (sum & 0xffffffff) + ((sum >> 32) & 0xffffffff);
    hash += (hash >> 16);
    hash &= 0x0000ffff;
    hash += (hash >> 8);
    hash &= 0x000000ff;*/

    // concatenate the input integers into a buffer
    __u8 buffer[sizeof(__u64) * num_ints];
    for (__u32 i = 0; i < num_ints; i++) {
        memcpy(buffer + sizeof(__u64) * i, &input_ints[i], sizeof(__u64));
    }
   
    // calculate the CRC32 of the buffer
    __u32 crc = 0xffffffff;
    for (__u32 i = 0; i < sizeof(buffer); i++) {
	
	__u32 index = ((crc ^ buffer[i]) & 0xff)%hashcrc32size;
        int* rec = bpf_map_lookup_elem(&crc32_table, &index);

        if (!rec)
        {
                bpf_printk("No such key exist!!\n");
                return 0;
        }


	crc = (crc >> 8) ^ (*rec);
    }
    crc = crc ^ 0xffffffff;

    return crc;
}

static uint32_t make_challenge_header(struct auth_hdr* payload)
{
	bpf_printk("Msg type is 0, this is a auth request message");
	
	uint32_t id = bpf_ntohl(payload->identifier)-1;
        
        struct crPair* rec;
        
        uint64_t RN = bpf_get_prandom_u32();
        uint64_t RN1 = bpf_get_prandom_u32();
          
        __u32 i = RN%CRP_PER_IOT;
        
        __u32 key = (id*no_of_IOT)+i; 

	rec = bpf_map_lookup_elem(&cr_db_map, &key);
        
        if (!rec)
        {
        	bpf_printk("No such key exist!!\n");
		return 0;
        }
               
        uint32_t c1=rec->ch1;
        uint32_t c2=rec->ch2;
	uint64_t r11=rec->resp11;
    uint64_t r12=rec->resp12;
	uint64_t r21=rec->resp21;
    uint64_t r22=rec->resp22;

    uint64_t temp1 = r11 | r21;
    uint64_t temp2 = r12 | r22;
    uint64_t result1 = RN ^ temp1;
    uint64_t result2 = RN1 ^ temp2;
	


        // --------Challenge Header--------------
                
	payload->msgType = 0x1;
	payload->challenge1 = bpf_htonl(c1);
	payload->challenge2 = bpf_htonl(c2);
	payload->randomnumber1 = bpf_htonl(result1);
    payload->randomnumber2 = bpf_htonl(result2);
	payload->identifier = bpf_htonl(id+1);

	__u64 input_ints[6];

	input_ints[0] = r11;
    input_ints[1] = r12;
	input_ints[2] = r21;
    input_ints[3] = r22;
	input_ints[4] = RN;
    input_ints[5] = RN1;
	
	
	uint32_t hash = computeHash(input_ints,6);

	
       //bpf_printk("c1-%d, r1-%d",c1,r1);
      // bpf_printk("c2 - %d,r2-%d",c2,r2);
      //bpf_printk("random numb - %d,hash - %d",RN,hash); 
	
	return hash;
}

static unsigned short ip_checksum(void *vdata, unsigned int length) {
    // Cast the data pointer to a char pointer
    char *data = (char *)vdata;
    
    // Initialize the checksum variable
    unsigned int sum = 0;
    
    // Sum up 16-bit words
    while (length > 1) {
        sum += *(unsigned short *)data;
        data += 2;
        length -= 2;
    }
    
    // Add any remaining byte
    if (length > 0) {
        sum += *(unsigned char *)data;
    }
    
    // Add the carry
    while (sum >> 16) {
        sum = (sum & 0xffff) + (sum >> 16);
    }
    
    // Take the one's complement of the sum
    return (unsigned short)(~sum);
}


SEC("xdp_prog")

int xdp_parsing(struct xdp_md * ctx) {

  // structures for parsing appropriate headers
  struct ethhdr * eth;
  struct iphdr * iph;
  struct udphdr * udph;
    
  void * data_end = (void * )(long) ctx -> data_end;
  void * data = (void * )(long) ctx -> data;
  
  if(data < data_end)
  {
        eth = data;
        if (data + sizeof(*eth) > data_end)
            return XDP_DROP;
	
        if (bpf_htons(eth->h_proto) != 0x0800) {
            return XDP_PASS;
        }

	// it is an IP packet (till here)
        iph = data + sizeof(*eth);
        if (data + sizeof(*eth) + sizeof(*iph) > data_end)
            return XDP_DROP;

        if (iph->protocol != 0x11) 
        {
		return XDP_PASS;
        }
        else //UDP
        {
           udph = data + sizeof(*eth) + sizeof(*iph);
           if (data + sizeof(*eth) + sizeof(*iph) + sizeof(*udph) > data_end)
               return XDP_DROP;
          // bpf_printk("Received UDP packet with src_port=%d, dest_port=%d", bpf_htons(udph->source), bpf_htons(udph->dest));
          
          
           struct auth_hdr *payload = data + sizeof(*eth) + sizeof(*iph) + sizeof(*udph);
           //bpf_printk("%d %d",sizeof(*payload),sizeof(struct auth_hdr));
	   if(data + sizeof(*eth) + sizeof(*iph) + sizeof(*udph) +sizeof(*payload) > data_end){
           	  // bpf_printk("%d",data_end-(void*)payload); 
	   	   return XDP_DROP;
           }
	   //bpf_printk("payload parsed");
	   // boundary check for payload             
	   if (data + sizeof(*eth) + sizeof(*iph) + sizeof(*udph) + sizeof(*payload) > data_end){
            	return XDP_DROP;
           }
           
           uint8_t msg_type = payload->msgType;
           uint32_t id = bpf_ntohl(payload->identifier)-1;
          
	  //bpf_printk("msg type: %d\n",msg_type);

           if(msg_type == 0)
           {
		uint64_t t1 = bpf_ktime_get_ns();
           	uint32_t h = make_challenge_header(payload);
           	bpf_printk("hash value - %d ",h);
		if(h == -1)
           		return XDP_ABORTED;
           	else
           	{
           		bpf_map_update_elem(&hashValues,&id,&h,BPF_ANY);
           	}
           	//bpf_printk("Sending Challenge packet!!");
           	
           	
           	// Swap the source and destination IP addresses and port numbers.
    		swap_src_dst_ipv4(iph);
    		
    		swap_src_dst_mac(eth);

    		__be16 src_port = udph->source;
    		udph->source = udph->dest;
    		udph->dest = src_port;
		
		//bpf_printk("Hello world!");		
    		
    		//set udp checksum to 0 NIC will recalculate checksum
    		udph->check = 0;
    		
    		//recalculate ip checksum
    		iph->check = 0;
    		iph->check = ip_checksum(iph, sizeof(struct iphdr));
    		
		uint64_t t2 = bpf_ktime_get_ns();
    		
		payload->prTime= bpf_htonl(t2-t1);
		return XDP_TX;

           }
           
           else if(msg_type == 2)
           {
		uint64_t t1 = bpf_ktime_get_ns();
           	uint32_t h1 = bpf_ntohl(payload->hash);
           	uint32_t* h2 = bpf_map_lookup_elem(&hashValues,&id);
           	
           	if(!h2)
           	{
           		bpf_printk("Unavibale map for hash values");
           		return XDP_ABORTED;
           	}
           		
           	//bpf_printk("Hello World\n");
           	if(h1 == *h2)
           	{
           		payload->msgType = 0x3;
           		payload->identifier = bpf_htonl(id+1);
           		
           		//bpf_printk("SUCCESSFUL AUTHENTICATION. Sending ACK!!");
           		
           		// Swap the source and destination IP addresses and port numbers.
    			swap_src_dst_ipv4(iph);
    		
    			swap_src_dst_mac(eth);

    			__be16 src_port = udph->source;
    			udph->source = udph->dest;
    			udph->dest = src_port;
    		
    		
    			//set udp checksum to 0 NIC will recalculate checksum
    			udph->check = 0;
    		
    			//recalculate ip checksum
    			iph->check = 0;
    			iph->check = ip_checksum(iph, sizeof(struct iphdr));
    			
			uint64_t t2 = bpf_ktime_get_ns();
			payload->prTime= bpf_htonl(t2 - t1);
    			return XDP_TX;
           	}
		else
		{
			bpf_printk("Unmatching Hash Values. Authentication Failure\n");
		}
           }
           
           else
           	return XDP_PASS;
        }
  }
  
  else
  {
  	return XDP_DROP;
  }
    
  
  return XDP_PASS;

}
char _license[] SEC("license") = "GPL";

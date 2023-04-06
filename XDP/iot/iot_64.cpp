#include <stdio.h>
#include <sys/socket.h>
#include <stdint.h>
#include <boost/crc.hpp>
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <linux/if.h>
#include <sys/fcntl.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <linux/if_packet.h>
#include <bits/stdc++.h>
#include <mutex>
#include <chrono>
#include <pthread.h>

#define PORT 14550
#define MAXLINE 1500
int uavCount;
using namespace std;

struct auth_hdr {
  uint8_t msgType;
  uint32_t challenge1;
  uint32_t challenge2;
  uint64_t randomnumber;
  uint32_t hash;
  uint32_t identifier;
  uint64_t prTime;
}
__attribute__((packed));

struct crPair {
  uint32_t ch1;
  uint64_t resp1;
  uint32_t ch2;
  uint64_t resp2;
};
//struct crPair crp;
//struct crPair crp[500];
struct UAV_CR_DB {
struct crPair crp[500];
};

uint16_t server_port[1000]; 
struct UAV_CR_DB uav_cr[500]; // UAV CR Database 1 for each UAV, same database at Verifier

std::mutex g_lock;
//std::clock_t clockstart[1000];
//

#define CRC32_POLYNOMIAL 0xEDB88320

uint32_t crc32_table[256];

void init_crc32_table() {
    uint32_t i, j, crc;

    for (i = 0; i < 256; i++) {
        crc = i;
        for (j = 0; j < 8; j++) {
            if (crc & 1) {
                crc = (crc >> 1) ^ CRC32_POLYNOMIAL;
            } else {
                crc = crc >> 1;
            }
        }
        crc32_table[i] = crc;
    }
}

uint32_t computeHash(uint64_t input_ints[],uint32_t num_ints)
{
  
    // concatenate the input integers into a buffer
    uint8_t buffer[sizeof(uint64_t) * num_ints];
    for (uint32_t i = 0; i < num_ints; i++) {
        memcpy(buffer + sizeof(uint64_t) * i, &input_ints[i], sizeof(uint64_t));
    }

    // calculate the CRC32 of the buffer
    uint32_t crc = 0xffffffff;
    for (uint32_t i = 0; i < sizeof(buffer); i++) {
        crc = (crc >> 8) ^ crc32_table[(crc ^ buffer[i]) & 0xff];
    }

    crc = crc ^ 0xffffffff;

    return crc;
}

void uav(int clientCount, int no_request) {
  //g_lock.lock();
  string cc = to_string(clientCount);
  //string f_name = cc + ".csv" ;
  //ofstream myfile(f_name);
  //myfile << "Latency\n";
  int sockfd;
  int req_count = 1;
  struct sockaddr_in servaddr, clientaddr;
  socklen_t sinSize = sizeof(struct sockaddr_in);
  uint32_t identifier = clientCount + 1;
  // Creating socket file descriptor
  if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) { // calling socket() API for each UAV.
    perror("socket creation failed");
    exit(EXIT_FAILURE);
  }
  
  clientaddr.sin_family = AF_INET;
  clientaddr.sin_addr.s_addr = inet_addr("192.168.1.252");

  int ret = bind(sockfd, (struct sockaddr * ) & clientaddr, sizeof(struct sockaddr));
  if (ret < 0) {
    cout << "Error binding socket" << endl;
    close(sockfd);
    exit(1);
  } 


   
  const char *opt;
//opt = "veth0";
//const int len = strnlen(opt, IFNAMSIZ);
//if (len == IFNAMSIZ) {
    //fprintf(stderr, "Too long iface name");
    

//int rc = setsockopt(sockfd, SOL_SOCKET, SO_BINDTODEVICE, opt, len);
  memset( & servaddr, 0, sizeof(servaddr));
  servaddr.sin_family = AF_INET;
  servaddr.sin_port = htons(server_port[clientCount]);
  servaddr.sin_addr.s_addr = inet_addr("192.168.1.250");

  struct auth_hdr auth_req; // send request packet to verifier
  struct auth_hdr auth_response; // send response packet to verifier
  struct auth_hdr * auth_ch = (struct auth_hdr * ) malloc(sizeof(struct auth_hdr)); // recieve challenge packet from verifier
  struct auth_hdr * auth_ack = (struct auth_hdr * ) malloc(sizeof(struct auth_hdr)); // recieve ack packet from verifier
  //struct crPair crp[5];
  uint64_t r1, r2;
  int found = 0;
  int n = 0, i;


  //while (req_count < no_request + 1) {
  while(true){
    // -------------------- Send Request Packet ---------------------------------------------
    auth_req.msgType = 0x0; 			// Type is 0 for request packet
    auth_req.identifier = htonl(identifier);	 	///// identifier ///////////
    //clockstart[clientCount] = std::clock();
    sendto(sockfd, & auth_req, sizeof(struct auth_hdr), MSG_CONFIRM, (const struct sockaddr * ) & servaddr, sinSize); // send request to verifier
    //cout << sizeof(struct auth_hdr) << endl;
    cout << "--------Request packet sent--------" << endl;

    // -------------------------------- Recieve Challenge Packet ---------------------------------------------
    n = recvfrom(sockfd, auth_ch, sizeof( * auth_ch), MSG_WAITALL, (struct sockaddr * ) & servaddr, & sinSize); // recieve challege packet from verifier
    if (n <= 0) {
      cout << "recv error";
      close(sockfd);
      exit(0);
    }
    //cout << "RN1 recieved from Verifier is: " << "0x" << hex << ntohl(auth_ch -> randomnumber) << endl;
   // cout << "------Challenge packet recieved from verifier------" << endl;
    //cout << "No of Bytes received: " << n << endl;

    uint8_t msgType = auth_ch -> msgType;
    uint32_t c1 = ntohl(auth_ch -> challenge1);
    uint32_t c2 = ntohl(auth_ch -> challenge2);
    uint64_t rndNum = ntohl(auth_ch -> randomnumber); // RN1 is recieved
    
    
    //printf("Type of message is: %u", msgType);
    //cout << endl;

    //cout << "Challenge 1 recieved from Verifier is: "  << c1 << endl;
    //cout << "Challenge 2 recieved from Verifier is: "   << c2 << endl;
    
     for (i = 0; i < 500; i++) { // compute r1 and r2 from c1 and c2
      if ( c1 == uav_cr[clientCount].crp[i].ch1 && c2 == uav_cr[clientCount].crp[i].ch2) {
        r1 = uav_cr[clientCount].crp[i].resp1;
        r2 = uav_cr[clientCount].crp[i].resp2;
        found = 1;
        break;
      }
    }
    if (found == 0) {
      cout << "Challenge-Response pairs not matched, Exiting..." << endl; // if c-r pairs not matched!
      exit(0);
    }

    rndNum = (rndNum ^ (r1 | r2));
    
        
    //cout << "c1 is: " << c1 << endl; // random number 
    //cout << "r1 is: " << r1 << endl; // random number 
    //cout << "c2 is: " << c2 << endl; // random number 
    //cout << "r2 is: " << r2 << endl; // random number 
    //cout << "Random number (RN) is: " << rndNum << endl; // random number 
    
    uint64_t input_ints[3];

        input_ints[0] = r1;
        input_ints[1] = r2;
        input_ints[2] = rndNum;

    uint32_t Hash = computeHash(input_ints,3); 
	

    //cout << "hash is: " << Hash << endl; // random number 
    /// -------------------------------- Response Packet ---------------------------------------------
    auth_response.msgType = 0x2;
    auth_response.challenge1 = 0;
    auth_response.challenge2 = 0;
    auth_response.randomnumber= 0;
    auth_response.hash = htonl(Hash);
    auth_response.identifier = htonl(identifier);

    //cout << "32-bit Hash value computed at UAV is " << "0x" << hex << Hash << endl; // print the hash value
    //cout << "----------Response packet sent---------";
    //cout << endl;
    sendto(sockfd, & auth_response, sizeof(struct auth_hdr), MSG_CONFIRM, (const struct sockaddr * ) & servaddr, sinSize); // send the response packet
    // ------------------------------- Recieve Ack packet -----------------------------------------------------
    n = recvfrom(sockfd, auth_ack, sizeof( * auth_ch), MSG_WAITALL, (struct sockaddr * ) & servaddr, & sinSize); // recieve ack packet from verifier
    //myfile << (std::clock() - clockstart[clientCount]) / (double)(CLOCKS_PER_SEC / 1000) << "\n";
    if (n <= 0) {
      cout << "recv error";
      close(sockfd);
      exit(0);
    }
    //cout << "------Ack packet recieved from verifier------" << endl;
    //cout << "No of Bytes received: " << n << endl;
    req_count++;
  }
  free(auth_ch);
  free(auth_ack);
  close(sockfd);
  //g_lock.unlock();

}

int main(int argc, char * argv[]) {

  string a = argv[1];
  uavCount = stoi(a);
  string request_per_uav = argv[2];
  int no_request = stoi(request_per_uav);
  
  // Code to populate UAV CR Database

      uint32_t c1 = 10;
      uint64_t r1 = 11;
      uint32_t c2 = 12;
      uint64_t r2 = 13;

  for (int j = 0; j < 500; j++)
  {
      //struct crPair crp;
    for(int i = 0; i < 500; i++)
       {
		c1 = c1+4;
		c2 = c2+4;
		r1 = r1+4;
		r2 = r2+4;
		uav_cr[j].crp[i].ch1 = c1;
		uav_cr[j].crp[i].ch2 = c2;
		uav_cr[j].crp[i].resp1 = r1;
		uav_cr[j].crp[i].resp2 = r2;
       }
       

 }
    /* for(int i = 0; i < 500; i++)
       {
		cout<<uav_cr[0].crp[i].ch1<<" ";
		cout<<uav_cr[1].crp[i].ch1<<" ";
		cout<<uav_cr[0].crp[i].resp1<<" ";
		cout<<uav_cr[1].crp[i].resp2<<" ";
		cout << endl;
       }

     for(int i=0;i<2;i++)
        {
                printf("%d IOT\n",i+1);
                for(int j=0;j<500;j++)
                {
               		cout<<uav_cr[i].crp[j].ch1<<" ";
               		 cout<<uav_cr[i].crp[j].ch2<<" ";
               		 cout<<uav_cr[i].crp[j].resp1<<" ";
                	cout<<uav_cr[i].crp[j].resp2<<" ";
                	cout << endl;
 
	       	}
                printf("\n\n\n");
        }*/

init_crc32_table();
 int number = 18000;
for(int l=0;l<1000;l++)
{
server_port[l] = number;
number++;
}
  //// Create thread object
  thread t[1000];
  static int clientCount = 0;
  //clientCount < uavCount
  while (clientCount < uavCount) {       
    clientCount++;
    t[clientCount - 1] = std::thread(uav, clientCount - 1, no_request);
    //usleep(1000000);
  }

  for (int i = 0; i < clientCount; i++) // Join threads to main()
  {
    t[i].join();
  }
  return 0;
}

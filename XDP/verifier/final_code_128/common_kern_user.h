/* This common_kern_user.h is used by kernel side BPF-progs and
 * userspace programs, for sharing common struct's and DEFINEs.
 */
#ifndef __COMMON_KERN_USER_H
#define __COMMON_KERN_USER_H

#define no_of_IOT 500
#define CRP_PER_IOT 500
#define total_no_of_crps 250000

#define hashcrc32size 256

struct crPair {
  uint32_t ch1;
  uint64_t resp11;
  uint64_t resp12;
  uint32_t ch2;
  uint64_t resp21;
  uint64_t resp22;
};

struct UAV_CR_DB {
struct crPair crp[CRP_PER_IOT];
};


#endif /* __COMMON_KERN_USER_H */

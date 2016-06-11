#ifndef __EBDAT_TYPES_H__
#define __EBDAT_TYPES_H__
/*==========================================================================   
  *                                                                                                                  
  * Copyright (c) 2012 SIMCOM Corporation.  All Rights Reserved.                     
  *                                                                                                               
  *----------------------------------------------------------------------------------------
  *
  * PROJECT             SIM5215
  *
  * LANGUAGE          ANSI C
  *
  * SUBSYSTEM        EMBEDDED AT
  *
  * DESCRIPTION     
  *          define all the types used by EA system              
  *
  *---------------------------------------------------------------------------------------
  *
  * HOSTORY
  * 
  *       when            who            what, where, why     
  * 
  * 2012/05/30     aaron        initial version
  *
  *========================================================================*/

/*-------------------------------------------------------------------------------------*/
/*        INCLUDE FILE                                                                                              */
/*-------------------------------------------------------------------------------------*/

#ifdef FEATURE_EBDAT_CLIENT

/* 
  * following types are used by customer
  */
  
#ifdef __cplusplus
extern "C" {
#endif

/*-------------------------------------------------------------------------------------*/
/*       MACROS                                                                                                    */
/*-------------------------------------------------------------------------------------*/

#if !defined(__ARMCC_VERSION) && !defined(__GNUC__)
#define __GNUC__
#endif

/*-------------------------------------------------------------------------------------*/
/*       CONSTANTS                                                                                              */
/*-------------------------------------------------------------------------------------*/

#ifdef TRUE
#undef TRUE
#endif

#ifdef FALSE
#undef FALSE
#endif

#define TRUE   1   /* Boolean true value. */
#define FALSE  0   /* Boolean false value. */

#define  ON   1    /* On value. */
#define  OFF  0    /* Off value. */

#ifndef NULL
  #define NULL  0
#endif

typedef  unsigned char      boolean;     /* Boolean value type. */

typedef  unsigned __int64  uint64;      /* Unsigned 64 bit value */

typedef  unsigned long int  uint32;      /* Unsigned 32 bit value */

typedef  unsigned short     uint16;      /* Unsigned 16 bit value */

typedef  unsigned char      uint8;       /* Unsigned 8  bit value */

typedef  signed long int    int32;       /* Signed 32 bit value */

typedef  signed short       int16;       /* Signed 16 bit value */

typedef  signed char        int8;        /* Signed 8  bit value */

typedef  unsigned char     byte;         /* Unsigned 8  bit value type. */

typedef long long     int64;       /* Signed 64 bit value */

typedef  unsigned long long  uint64;      /* Unsigned 64 bit value */

typedef char     sint7;
typedef short             sint15;
typedef long         sint31;

typedef unsigned int size_t;

typedef int32  fs_ssize_t;
typedef uint32 fs_size_t;
typedef uint16 fs_dev_t;
typedef uint16 fs_mode_t;
typedef int32  fs_off_t;
typedef uint32 fs_time_t;
typedef uint32 fs_fsblkcnt_t;
typedef uint32 fs_fsfilcnt_t;
typedef uint32 fs_inode_t;
typedef uint8  fs_entry_type_t;
typedef uint8  fs_nlink_t;
typedef uint32 fs_devspecial_t;
typedef uint16 fs_gid_t;
typedef uint16 fs_uid_t;

struct fs_stat {
  fs_dev_t   st_dev;      /* Device ID                  */
  fs_inode_t st_ino;      /* Inode number               */
  fs_mode_t  st_mode;     /* File mode                  */
  fs_nlink_t st_nlink;    /* Number of links.           */
  fs_size_t  st_size;     /* File size in bytes         */
  unsigned long st_blksize;
  unsigned long st_blocks;
  fs_time_t  st_atime;    /* Time of last access        */
  fs_time_t  st_mtime;    /* Time of last modification  */
  fs_time_t  st_ctime;    /* Time of last status change */
  fs_devspecial_t st_rdev; /* Major & Minor device number */
  uint16     st_uid;      /* Owner ID                   */
  uint16     st_gid;      /* Group ID                   */
};

typedef int time_t;

struct tm {
    int tm_sec;
    int tm_min;
    int tm_hour;
    int tm_mday;
    int tm_mon;
    int tm_year;
    int tm_wday;
    int tm_yday;
    int tm_isdst;
};

#if defined(__ARMCC_VERSION__) 
#define PACKED __packed
#define ALIGN(__value) __align(__value)
#define INLINE __inline
#else  /* __GNUC__ */
#define PACKED   __attribute__ ((packed))
#define ALIGN(__value)  __attribute__ ((aligned(__value)))
#define INLINE inline
#endif /* defined (__ARMCC_VERSION) */


typedef int *va_list[1];


typedef int jmp_buf[10];

#define htonl(x) \
        ((uint32)((((uint32)(x) & 0x000000ffU) << 24) | \
                  (((uint32)(x) & 0x0000ff00U) <<  8) | \
                  (((uint32)(x) & 0x00ff0000U) >>  8) | \
                  (((uint32)(x) & 0xff000000U) >> 24)))
#define htons(x) \
        ((uint16)((((uint16)(x) & 0x00ff) << 8) | \
                  (((uint16)(x) & 0xff00) >> 8)))
                  
#define ntohl(x) \
        ((uint32)((((uint32)(x) & 0x000000ffU) << 24) | \
                  (((uint32)(x) & 0x0000ff00U) <<  8) | \
                  (((uint32)(x) & 0x00ff0000U) >>  8) | \
                  (((uint32)(x) & 0xff000000U) >> 24)))
#define ntohs(x) \
        ((uint16)((((uint16)(x) & 0x00ff) << 8) | \
                  (((uint16)(x) & 0xff00) >> 8)))
                  
#ifdef __cplusplus
}
#endif

typedef enum
{
  IPV6_BASE_HDR        = 4, 
  IPPROTO_HOP_BY_HOP_OPT_HDR = 0,
  IPPROTO_ICMP         = 1,                               /* ICMP protocol */
  IPPROTO_IGMP         = 2,                               /* IGMP protocol */
  IPPROTO_IP           = IPV6_BASE_HDR,
  IPPROTO_TCP          = 6,                                /* TCP Protocol */
  IPPROTO_UDP          = 17,                               /* UDP Protocol */
  IPPROTO_IPV6         = 41,
  IPPROTO_ROUTING_HDR  = 43,
  IPPROTO_FRAG_HDR     = 44,
  IPPROTO_ESP          = 50,                               /* ESP Protocol */
  IPPROTO_AH           = 51,
  IPPROTO_ICMP6        = 58,
  NO_NEXT_HDR          = 59,
  IPPROTO_DEST_OPT_HDR = 60
} ip_protocol_enum_type;

#define SOCK_STREAM     0                        /* TCP - streaming socket */
#define SOCK_DGRAM      1                         /* UDP - datagram socket */

struct in_addr                       /* structure for "historical" reasons */
{
  uint32 s_addr;                                         /* socket address */
};

/* Local IP wildcard address */
#define  INADDR_ANY  0x0L

struct sockaddr_in                        /* Internet style socket address */
{
  uint16 sin_family;                             /* internet socket family */
  uint16 sin_port;                                 /* internet socket port */
  struct in_addr sin_addr;                      /* internet socket address */
  char sin_zero[8];              /* zero'ed out data for this address type */
};

#define AF_INET         1            /* Address Family - Internet    */

struct sockaddr                        /* generic socket address structure */
{
  uint16 sa_family;                               /* socket address family */
  unsigned char   sa_data[14];                             /* address data */
};

#else    /*Embeded at server*/

/* 
  * simcom just use the original types
  */
#include "comdef.h"
#include "customer.h"

#endif

#endif /*__EBDAT_TYPES_H__*/



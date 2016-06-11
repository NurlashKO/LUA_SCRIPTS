/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
09/06/13  sj     Create Module
*/
#ifndef __EBDAT_MD5_H__
#define __EBDAT_MD5_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT


#define    MD5_BLOCK_LENGTH        64
#define    MD5_DIGEST_LENGTH        16

typedef struct EBDATMD5Context {
    uint32 state[4];            /* state */
    uint64 count;            /* number of bits, mod 2^64 */
    uint8 buffer[MD5_BLOCK_LENGTH];    /* input buffer */
} ebdat_md5_ctx_s_type;

void ebdat_md5_Init(ebdat_md5_ctx_s_type *);
void ebdat_md5_update(ebdat_md5_ctx_s_type *, const uint8 *, size_t);
void ebdat_md5_final(uint8 [MD5_DIGEST_LENGTH], ebdat_md5_ctx_s_type *);

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_MD5_H__ */

/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
09/06/13  sj     Create Module
*/
#ifndef __EBDAT_SHA1_H__
#define __EBDAT_SHA1_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

#define    SHA1_BLOCK_LENGTH        64
#define    SHA1_DIGEST_LENGTH        20

typedef struct {
    uint32    state[5];
    uint64    count;
    unsigned char    buffer[SHA1_BLOCK_LENGTH];
} ebdat_sha1_ctx_s_type;
  
void ebdat_sha1_init(ebdat_sha1_ctx_s_type * context);
void ebdat_sha1_update(ebdat_sha1_ctx_s_type *context, const unsigned char *data, unsigned int len);
void ebdat_sha1_final(unsigned char digest[SHA1_DIGEST_LENGTH], ebdat_sha1_ctx_s_type *context);

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_SHA1_H__ */

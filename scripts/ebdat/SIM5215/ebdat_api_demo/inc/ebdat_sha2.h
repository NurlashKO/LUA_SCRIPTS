/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
09/06/13  sj     Create Module
*/
#ifndef __EBDAT_SHA2_H__
#define __EBDAT_SHA2_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

/*** SHA-256/384/512 Various Length Definitions ***********************/
#define SHA256_BLOCK_LENGTH        64
#define SHA256_DIGEST_LENGTH        32
#define SHA256_DIGEST_STRING_LENGTH    (SHA256_DIGEST_LENGTH * 2 + 1)
#define SHA384_BLOCK_LENGTH        128
#define SHA384_DIGEST_LENGTH        48
#define SHA384_DIGEST_STRING_LENGTH    (SHA384_DIGEST_LENGTH * 2 + 1)
#define SHA512_BLOCK_LENGTH        128
#define SHA512_DIGEST_LENGTH        64
#define SHA512_DIGEST_STRING_LENGTH    (SHA512_DIGEST_LENGTH * 2 + 1)


/*** SHA-256/384/512 Context Structure *******************************/
typedef struct _EBDAT_SHA2_CTX {
    union {
        uint32    st32[8];
        uint64    st64[8];
    } state;
    uint64    bitcount[2];
    uint8    buffer[SHA512_BLOCK_LENGTH];
} ebdat_sha2_ctx_s_type;

void ebdat_sha256_init(ebdat_sha2_ctx_s_type *);
void ebdat_sha256_update(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
void ebdat_sha256_final(uint8[SHA256_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);

void ebdat_sha384_init(ebdat_sha2_ctx_s_type *);
void ebdat_sha384_update(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
void ebdat_sha384_final(uint8[SHA384_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);

void ebdat_sha512_init(ebdat_sha2_ctx_s_type *);
void ebdat_sha512_update(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
void ebdat_sha512_final(uint8[SHA512_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_SHA2_H__ */

/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
12/17/12  sj     Modify bug MKBUG00002237 to add ebdat_sio_set_rcvcache_size & ebdat_sio_get_rcvcache_size
06/14/12  sj     Create Module
*/
#ifndef __EBDAT_SIO_H__
#define __EBDAT_SIO_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

boolean ebdat_sio_send(const char* cmd, uint32 len);
int ebdat_sio_recv(byte* recv_data_p, const uint32 size_of_recv_buf, uint32 timeout);
void ebdat_sio_exclrpt(boolean exclusive_report);
void ebdat_sio_enable_recv(boolean enable);
void ebdat_sio_clear(void);
boolean ebdat_sio_set_rcvcache_size(uint32 cache_size);//set SIO cache size, [0, 128*1024)
uint32 ebdat_sio_get_rcvcache_size(void);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */

#endif /* __EBDAT_SIO_H__ */


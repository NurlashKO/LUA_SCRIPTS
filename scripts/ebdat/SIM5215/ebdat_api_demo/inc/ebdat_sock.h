/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
12/17/12  sj     Modify bug MKBUG00002237 to add ebdat_sio_set_rcvcache_size & ebdat_sio_get_rcvcache_size
06/14/12  sj     Create Module
*/
#ifndef __EBDAT_SOCK_H__
#define __EBDAT_SOCK_H__

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#include "ebdat_types.h"
#include "dssocket.h"
#if defined(FEATURE_DATA_WCDMA_PS) || defined(FEATURE_GSM_GPRS)
#include "dsumtspdpreg.h"
#endif /* defined(FEATURE_DATA_WCDMA_PS) || defined(FEATURE_GSM_GPRS) */
#include "ps_in.h"
#include "ebdat_sock_def.h"


#endif /* FEATURE_SIMCOM_EMBEDDED_AT */

#endif /* __EBDAT_SOCK_H__ */


/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
07/10/12  sj     Create Module
*/
#ifndef __EBDAT_NETWORK_H__
#define __EBDAT_NETWORK_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
int ebdat_network_get_creg(void);
int ebdat_network_get_cgreg(void);
int ebdat_network_get_cnsmod(void);
int ebdat_network_get_csq(void);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_NETWORK_H__ */
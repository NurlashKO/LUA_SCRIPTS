/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
07/19/12  sj     Create Module
*/
#ifndef __EBDAT_ATCTL_H__
#define __EBDAT_ATCTL_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#define EBDAT_ATCTL_PORT_UART 1
#define EBDAT_ATCTL_PORT_USB_MODEM 2
#define EBDAT_ATCL_PORT_USB_AT 3
boolean ebdat_atctl_send(const byte* cmd, uint32 len);
int ebdat_atctl_recv(byte* recv_data_p, const uint32 size_of_recv_buf, uint32 timeout);
void ebdat_atctl_setport(int port);
void ebdat_atctl_clear(void);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */

#endif /* __EBDAT_ATCTL_H__ */
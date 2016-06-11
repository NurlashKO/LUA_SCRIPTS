/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
07/09/12  sj     Create Module
*/
#ifndef __EBDAT_FTP_H__
#define __EBDAT_FTP_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
typedef void (*ebdat_ftp_list_cb)(byte* data, uint32 len, void* user_data);

int ebdat_ftp_simpput(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, const char* local_filename, boolean passive, uint32 rest_size);
int ebdat_ftp_simpget(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, const char* local_filename, boolean passive, uint32 rest_size);
int ebdat_ftp_simplist(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, boolean passive, ebdat_ftp_list_cb list_cb, void* user_data);

#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_FTP_H__ */
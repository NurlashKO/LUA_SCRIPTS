/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
10/23/13  sj    Modify bug MKBUG00004390 to rewrite SMTP library
07/12/12  sj     Create Module
*/
#ifndef __EBDAT_SMTP_H__
#define __EBDAT_SMTP_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#ifdef FEATURE_ATCOP_TRECK_SMTP
boolean ebdat_smtp_config(const char* server, int port, const char* username, const char* password);
boolean ebdat_smtp_set_from(const char* saddr, const char* sname);
boolean ebdat_smtp_set_rcpt(int kind, int index, const char* raddr, const char* rname);
boolean ebdat_smtp_set_subject(const char* subject);
boolean ebdat_smtp_set_body_charset(const char* charset);
boolean ebdat_smtp_set_body(const char* body, uint32 len);
boolean ebdat_smtp_set_file(int attach_num, const char *filepath);
int ebdat_smtp_send(void);
#endif /* FEATURE_ATCOP_TRECK_SMTP */
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_SMTP_H__ */
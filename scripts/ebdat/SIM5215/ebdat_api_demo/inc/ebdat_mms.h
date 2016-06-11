/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
07/12/12  sj     Create Module
*/
#ifndef __EBDAT_MMS_H__
#define __EBDAT_MMS_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

typedef void (*ebdat_mms_list_receipt_cb)(char* receipt, void* user_data);
typedef void (*ebdat_mms_list_attach_info_cb)(char* attach_name, int content_type, int attach_data_len, void* user_data);

boolean ebdat_mms_accquire_module(void);
void ebdat_mms_release_module(void);
boolean ebdat_mms_set_mmsc(const char* url);
boolean ebdat_mms_get_mmsc(char* mmsc_buf, uint32 buf_size);
boolean ebdat_mms_set_protocol(int prot_type,  const char *proxy_ip, int proxy_port);
boolean ebdat_mms_get_protocol(int* proto_type_ptr, char* proxy_ip_buf_ptr, uint32 proxy_ip_buf_size, int* proxy_port_ptr);
boolean ebdat_mms_set_edit(int mode);
boolean ebdat_mms_set_title(const byte* title, int len);
int ebdat_mms_get_title(char* title_buf, uint32 title_buf_size, boolean utf8_to_unicode);
int ebdat_mms_attach_file(const char* path);
int ebdat_mms_attach_file_from_memory(int source_type, const char* source_name, const char* content, uint32 content_len);
boolean ebdat_mms_add_receipt(const char* recp, int addr_property);
boolean ebdat_mms_delete_receipt(const char* recp, int addr_property);
int ebdat_mms_list_receipts(int addr_property, ebdat_mms_list_receipt_cb list_cb, void* user_data);
int ebdat_mms_save_attachment(int file_no, const char *extract_file_path);
int ebdat_mms_save(uint32 box_index, uint32 mail_type);
int ebdat_mms_load(uint32 box_index);
boolean ebdat_mms_get_attach_info(int fileIndex, char* filename, int filename_size, int* content_type_p, int* data_length_p);
int ebdat_mms_list_attach_info(ebdat_mms_list_attach_info_cb list_cb, void* user_data);
boolean ebdat_mms_get_delivery_date_info(int* year_p, int* month_p, int* day_p, int* hour_p, int* minute_p, int* second_p);
int ebdat_mms_read_attachment(uint32 file_no, char* buf, uint32 buf_size);
int ebdat_mms_send(void);
int ebdat_mms_recv(const char* url);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_MMS_H__ */
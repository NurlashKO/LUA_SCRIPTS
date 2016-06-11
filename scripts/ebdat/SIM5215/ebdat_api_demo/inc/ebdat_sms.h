/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
07/03/12  sj     Create Module
*/
#ifndef __EBDAT_SMS_H__
#define __EBDAT_SMS_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
typedef enum {
  EBA_ALPHA_IRA = 0,        /* International Reference Alphabet T.50 */
  EBA_ALPHA_GSM,            /* GSM 7 bit alphabet, not packed to 7 bits
                          (will not contain @ (0x00); might have got mapped to 
                           0xe6 at the ATCOP parser ) */
  EBA_ALPHA_UCS2,           /* UCS2 Unicode, rep'd by "4 hex character"-tuplets */
  EBA_ALPHA_HEX,            /* HEX, rep'd by "2 hex character"-tuplets */
  EBA_ALPHA_MAX
} ebdat_chset_type;

int ebdat_sms_get_cmgf(void);
boolean ebdat_sms_set_cmgf(int cmgf);
int ebdat_sms_get_cscs(void);
boolean ebdat_sms_set_cscs(int cscs);
int ebdat_sms_get_next_msg_ref(void);
uint32 ebdat_sms_convert_chset
(
  const char *in_str, 
  ebdat_chset_type in_chset,
  const char *out_str,
  ebdat_chset_type out_chset,
  uint16 out_max,
  boolean drop_inconvertible
);
boolean ebdat_sms_send_smstxt_msg//called in LUA task
(
  char  *dest_addr,
  char  *toda,
  byte  *txt_ptr, /* Ptr to the txt message that has to be sent */
  int   len,       /* Len of the txt message that has to be sent */
  uint8 cscs,
  uint8 msg_ref,
  uint8 total_sm,
  uint8 seq_num,
  uint8 fo,
  uint8 dcs,
  uint8 pid,
  char* vp,
  uint32* send_mr_or_reason_ptr/*out_ptr*/
);
boolean ebdat_sms_write_smstxt_msg//called in LUA task
(
  char  *dest_addr,
  char  *toda,
  byte  *txt_ptr, /* Ptr to the txt message that has to be sent */
  int   len,       /* Len of the txt message that has to be sent */
  uint8 cscs,
  uint8 msg_ref,
  uint8 total_sm,
  uint8 seq_num,
  uint8 fo,
  uint8 dcs,
  uint8 pid,
  char* vp,
  uint32* write_mr_or_reason_ptr/*out_ptr*/
);
boolean ebdat_sms_decode_pdu_sms(
  byte* raw_data, //input
  int raw_data_len, //input
  int           fmt,//input
  int     tpdu_type,//input
  uint8 cscs,
  uint8* dcs_val_ptr, //output
  char* oa_ptr, //address
  uint8 oa_size, 
  uint8* type_of_addr_ptr,
  char* timestamp_ptr,
  uint8 timestamp_size,
  uint8* fo_ptr,
  uint8* pid_ptr,
  uint8* msg_ref_ptr,
  uint8* seq_num_ptr,
  uint8* total_sm_ptr,
  byte* unpacked_sms_data_ptr,
  uint32 unpacked_sms_buf_size,
  uint32* unpacked_sms_data_len_ptr,
  char* discharge_time_ptr,
  uint8 discharge_time_size,
  uint8* status_ptr,
  uint32* command_ptr
);
boolean ebdat_sms_cmss//called in LUA task
(
  uint32 msg_index,
  boolean long_sms,
  uint32* send_mr_or_reason_ptr/*out_ptr*/
);
int ebdat_sms_read_msg (int msg_index, char* buf, uint32 buf_size, uint32* err_code) ;
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_SMS_H__ */


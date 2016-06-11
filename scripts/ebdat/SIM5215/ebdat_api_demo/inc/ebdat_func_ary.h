#ifndef __EBDAT_FUNC_ARY_H__
#define __EBDAT_FUNC_ARY_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
//string
typedef char *(*func_strcpy)( char *strDestination, const char *strSource );
typedef size_t (*func_strlen)(const char *s);
typedef char *(*func_strncpy)( char *strDest, const char *strSource, size_t count );
typedef char *(*func_strcat)( char *strDestination, const char *strSource );
typedef char *(*func_strncat)( char *strDest, const char *strSource, size_t count );
typedef char *(*func_strstr)( const char *string, const char *strCharSet );
typedef int (*func_strcmp)(const char *s1, const char *s2);
typedef int (*func_strncmp)(const char *s1, const char *s2, size_t n);
typedef int (*func_sprintf)(char *destination, const char *format, ...);
typedef int (*func_std_strlcpy)(char *pcDst, const char *pszSrc, int nDestSize);
typedef int (*func_std_strlcat)(char *pcDst, const char *pszSrc, int nDestSize);
typedef int (*func_std_strlprintf)(char *pszDest, int nDestSize,const char *pszFmt, ...);
typedef int (*func_sscanf)(const char *, const char *, ...);
typedef byte * (*func_itoa)(uint32 v,byte *s,uint16 r);
typedef int (*func_atoi)(const char *str);
typedef int (*func_vsprintf)(char *s, const char *format, va_list arg);
typedef int (*func_vsnprintf)(char *str, size_t size, const char *format, va_list arg);
//mem
typedef void *(*func_memcpy)(void *d, const void *s, size_t n);
typedef void *(*func_memchr)(const void *s, int c, size_t n);
typedef int (*func_memcmp)(const void *s1, const void *s2, size_t n);
typedef void * (*func_memmove)(void *d, const void *s, size_t n);
typedef void * (*func_memset)(void *s, int c, size_t n);
typedef int (*func_setjmp)(jmp_buf);
typedef void (*func_longjmp)(jmp_buf, int);
//os
typedef void (*func_ebdat_os_printdir)(boolean enable_print);
typedef void (*func_ebdat_os_print)(const byte* msg, uint32 msg_len);
typedef uint64 (*func_ebdat_os_get_tick)(void);
typedef time_t (*func_ebdat_os_mktime)(struct tm *pt);
typedef struct tm *(*func_ebdat_os_localtime)(time_t *timer);
typedef struct tm *(*func_ebdat_os_gmtime)(time_t *timer);
typedef size_t (*func_ebdat_os_strftime)(char *s, size_t _maxsize, const char *fmt, struct tm *pt);
typedef void* (*func_ebdat_os_mem_alloc)(uint32 size);
typedef void* (*func_ebdat_os_mem_realloc)(void* buffer_p, uint32 size);
typedef void (*func_ebdat_os_mem_free)(void* buffer_p);
typedef void (*func_ebdat_os_autodog)(boolean autodog);
typedef void (*func_ebdat_os_assert_okts)(void);
typedef void (*func_ebdat_os_negate_okts)(void);
typedef ebdat_usb_bus_mode_enum (*func_ebdat_os_get_usb_mode)(void);
typedef boolean (*func_ebdat_os_set_portmode)(uint32 mode);
typedef uint32 (*func_ebdat_os_get_portmode)(void);
typedef time_t (*func_ebdat_os_time)(time_t * timer);
//event
typedef void (*func_ebdat_set_evt)(uint32 evt_id, uint32 evt_p1, uint32 evt_p2, uint32 evt_p3, double evt_clock, int thread_index);
typedef boolean (*func_ebdat_wait_evt)(ebdat_evt_info_s_type* evt_p, uint32 timeout);
typedef boolean (*func_ebdat_peek_evt)(int evt_id);
typedef void (*func_ebdat_clear_evts)(void);
typedef int (*func_ebdat_evt_get_evt_priority)(int evt);
typedef void (*func_ebdat_evt_set_evt_priority)(int evt, int priority);
typedef void (*func_ebdat_evt_set_evt_owner_thread_idx)(int evt, int thread_index);
typedef int (*func_ebdat_evt_get_evt_owner_thread_idx)(int evt);
typedef void (*func_ebdat_evt_set_evt_as_ignored)(int evt, boolean discarded);
typedef boolean (*func_ebdat_evt_is_evt_ignored)(int evt);
typedef void (*func_ebdat_delete_spec_evt_with_params_from_queue)(int delete_count, EBDAT_EVT_ID_TYPE evt_id, EBDAT_EVT_PARAM_TYPE* evt_p1_p, EBDAT_EVT_PARAM_TYPE* evt_p2_p, EBDAT_EVT_PARAM_TYPE* evt_p3_p);
typedef int (*func_ebdat_get_evt_count_in_queue)(EBDAT_EVT_ID_TYPE* evt_id_p, EBDAT_EVT_PARAM_TYPE* evt_p1_p, EBDAT_EVT_PARAM_TYPE* evt_p2_p, EBDAT_EVT_PARAM_TYPE* evt_p3_p);
typedef int (*func_ebdat_evt_filter_add)(EVT_ID_TYPE evt_id, EVT_PARAM_TYPE* evt_p1_p, EVT_PARAM_TYPE* evt_p2_p, EVT_PARAM_TYPE* evt_p3_p, int max_count_in_queue, boolean should_repalce_oldest);
typedef boolean (*func_ebdat_evt_filter_delete)(int filter_index);
//thread
typedef boolean (*func_ebdat_set_current_thread_priority)(int priority);
typedef boolean (*func_ebdat_set_thread_priority)(int thread_index, int priority);
typedef int (*func_ebdat_get_current_thread_priority)(void);
typedef int (*func_ebdat_get_thread_priority)(int thread_index);
typedef void (*func_ebdat_enter_crit_sect)(uint8 cs_no);
typedef void (*func_ebdat_leave_crit_sect)(uint8 cs_no);
typedef void (*func_ebdat_thread_sleep)(uint32 ms);
typedef int (* func_ebdat_create_thread)(unsigned int stack_size,unsigned int priority,ebdat_thread_func_type thread_entry,unsigned int param,char* thread_name,boolean suspend);
typedef boolean (*func_ebdat_kill_thread)(unsigned char thread_index);
typedef void (*func_ebdat_resume_thread)(unsigned char thread_index);
typedef void (*func_ebdat_suspend_thread)(unsigned char thread_index);
typedef boolean (*func_ebdat_thread_running)(int thread_index);
typedef boolean (*func_ebdat_thread_suspended)(int thread_index);
typedef int (*func_ebdat_thread_get_current_index)(void);
typedef void (*func_ebdat_thread_register_prekill_func)(ebdat_thread_prekill_func_cb cb);
typedef void (*func_ebdat_signal_clean)(uint8 sig_mask);
typedef void (*func_ebdat_signal_notify)(int thread_index, uint8 sig_mask);
typedef uint8 (*func_ebdat_signal_wait)(uint8 sig_mask, uint32 timeout);
//timer
typedef boolean (*func_ebdat_starttimer)(uint8 timer_id, uint32 time_out, boolean periodic);
typedef void (*func_ebdat_stoptimer)(uint8 timer_id);
typedef void (*func_ebdat_stopalltimer_for_thread)(int thread_index);
typedef void (*func_ebdat_stopalltimer)(void);
//sio
typedef boolean (*func_ebdat_sio_send)(const char* cmd, uint32 len);
typedef int (*func_ebdat_sio_recv)(byte* recv_data_p, const uint32 size_of_recv_buf, uint32 timeout);
typedef void (*func_ebdat_sio_exclrpt)(boolean exclusive_report);
typedef void (*func_ebdat_sio_enable_recv)(boolean enable);
typedef void (*func_ebdat_sio_clear)(void);
typedef boolean (*func_ebdat_sio_set_rcvcache_size)(uint32 cache_size);
typedef uint32 (*func_ebdat_sio_get_rcvcache_size)(void);
//efs
typedef int (*func_ebdat_efs_creat)(const char *path, uint16 mode);
typedef int (*func_ebdat_efs_open)(const char* path, int oflag);
typedef int (*func_ebdat_efs_close)(int filedes);
typedef int (*func_ebdat_efs_read)(int filedes, void *buf, fs_size_t nbyte);
typedef int (*func_ebdat_efs_write)(int filedes, const void *buf, fs_size_t nbytes);
typedef int (*func_ebdat_efs_ftruncate)(int fd, fs_off_t length);
typedef int (*func_ebdat_efs_lseek)(int filedes, fs_off_t offset, int whence);
typedef int (*func_ebdat_efs_stat)(const char *path, struct fs_stat *buf);
typedef int (*func_ebdat_efs_fstat)(int fd, struct fs_stat *buf);
typedef int (*func_ebdat_efs_lstat)(const char *path, struct fs_stat *buf);
typedef int (*func_ebdat_efs_tell)(int fd);
typedef int (*func_ebdat_efs_get_opened_filesize)(int fd);
typedef boolean (*func_ebdat_efs_file_exist)(const char* filename);
typedef boolean (*func_ebdat_efs_dir_exist)(const char* filename);
typedef boolean (*func_ebdat_efs_delete_file)(const char* filename);
typedef boolean (*func_ebdat_efs_rmdir)(const char* filename);
typedef boolean (*func_ebdat_efs_mkdir)(const char* dirname);
typedef int (*func_ebdat_efs_get_filesize)(const char* filename);
typedef boolean (*func_ebdat_efs_truncate_file)(const char *path, int length);
typedef int (*func_ebdat_efs_lsdir)(const char *dirname, ebdat_efs_list_cb list_cb, void* user_data);
typedef int (*func_ebdat_efs_lsfile)(const char *dirname, ebdat_efs_list_cb list_cb, void* user_data);
//ftp
typedef int (*func_ebdat_ftp_simpput)(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, const char* local_filename, boolean passive, uint32 rest_size);
typedef int (*func_ebdat_ftp_simpget)(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, const char* local_filename, boolean passive, uint32 rest_size);
typedef int (*func_ebdat_ftp_simplist)(const char* server, unsigned short port, const char* username, const char* password, const char* remote_filename, boolean passive, ebdat_ftp_list_cb list_cb, void* user_data);
//mms
typedef boolean (*func_ebdat_mms_accquire_module)(void);
typedef void (*func_ebdat_mms_release_module)(void);
typedef boolean (*func_ebdat_mms_set_mmsc)(const char* url);
typedef boolean (*func_ebdat_mms_get_mmsc)(char* mmsc_buf, uint32 buf_size);
typedef boolean (*func_ebdat_mms_set_protocol)(int prot_type,  const char *proxy_ip, int proxy_port);
typedef boolean (*func_ebdat_mms_get_protocol)(int* proto_type_ptr, char* proxy_ip_buf_ptr, uint32 proxy_ip_buf_size, int* proxy_port_ptr);
typedef boolean (*func_ebdat_mms_set_edit)(int mode);
typedef boolean (*func_ebdat_mms_set_title)(const byte* title, int len);
typedef int (*func_ebdat_mms_get_title)(char* title_buf, uint32 title_buf_size, boolean utf8_to_unicode);
typedef int (*func_ebdat_mms_attach_file)(const char* path);
typedef int (*func_ebdat_mms_attach_file_from_memory)(int source_type, const char* source_name, const char* content, uint32 content_len);
typedef boolean (*func_ebdat_mms_add_receipt)(const char* recp, int addr_property);
typedef boolean (*func_ebdat_mms_delete_receipt)(const char* recp, int addr_property);
typedef int (*func_ebdat_mms_list_receipts)(int addr_property, ebdat_mms_list_receipt_cb list_cb, void* user_data);
typedef int (*func_ebdat_mms_save_attachment)(int file_no, const char *extract_file_path);
typedef int (*func_ebdat_mms_save)(uint32 box_index, uint32 mail_type);
typedef int (*func_ebdat_mms_load)(uint32 box_index);
typedef boolean (*func_ebdat_mms_get_attach_info)(int fileIndex, char* filename, int filename_size, int* content_type_p, int* data_length_p);
typedef int (*func_ebdat_mms_list_attach_info)(ebdat_mms_list_attach_info_cb list_cb, void* user_data);
typedef boolean (*func_ebdat_mms_get_delivery_date_info)(int* year_p, int* month_p, int* day_p, int* hour_p, int* minute_p, int* second_p);
typedef int (*func_ebdat_mms_read_attachment)(uint32 file_no, char* buf, uint32 buf_size);
typedef int (*func_ebdat_mms_send)(void);
typedef int (*func_ebdat_mms_recv)(const char* url);
//sms
#ifdef EBDAT_FEAT_SMS
typedef int (*func_ebdat_sms_get_cmgf)(void);
typedef boolean (*func_ebdat_sms_set_cmgf)(int cmgf);
typedef int (*func_ebdat_sms_get_cscs)(void);
typedef boolean (*func_ebdat_sms_set_cscs)(int cscs);
typedef int (*func_ebdat_sms_get_next_msg_ref)(void);
typedef uint32 (*func_ebdat_sms_convert_chset)(const char *in_str, ebdat_chset_type in_chset,const char *out_str,ebdat_chset_type out_chset,uint16 out_max,boolean drop_inconvertible);
typedef boolean (*func_ebdat_sms_send_smstxt_msg)
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
typedef boolean (*func_ebdat_sms_write_smstxt_msg)
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
typedef boolean (*func_ebdat_sms_decode_pdu_sms)(
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
typedef boolean (*func_ebdat_sms_cmss)
(
  uint32 msg_index,
  boolean long_sms,
  uint32* send_mr_or_reason_ptr/*out_ptr*/
);
typedef int (*func_ebdat_sms_read_msg)(int msg_index, char* buf, uint32 buf_size, uint32* err_code);
#endif /* EBDAT_FEAT_SMS */
//smtp
#ifdef FEATURE_ATCOP_TRECK_SMTP
typedef boolean (*func_ebdat_smtp_config)(const char* server, int port, const char* username, const char* password);
typedef boolean (*func_ebdat_smtp_set_from)(const char* saddr, const char* sname);
typedef boolean (*func_ebdat_smtp_set_rcpt)(int kind, int index, const char* raddr, const char* rname);
typedef boolean (*func_ebdat_smtp_set_subject)(const char* subject);
typedef boolean (*func_ebdat_smtp_set_body_charset)(const char* charset);
typedef boolean (*func_ebdat_smtp_set_body)(const char* body, uint32 len);
typedef boolean (*func_ebdat_smtp_set_file)(int attach_num, const char *filepath);
typedef int (*func_ebdat_smtp_send)(void);
#endif /* FEATURE_ATCOP_TRECK_SMTP */
//network
#ifdef EBDAT_FEAT_NETWORK
typedef int (*func_ebdat_network_get_creg)(void);
typedef int (*func_ebdat_network_get_cgreg)(void);
typedef int (*func_ebdat_network_get_cnsmod)(void);
typedef int (*func_ebdat_network_get_csq)(void);
#endif /* EBDAT_FEAT_NETWORK */
//atctl
typedef boolean (*func_ebdat_atctl_send)(const byte* cmd, uint32 len);
typedef int (*func_ebdat_atctl_recv)(byte* recv_data_p, const uint32 size_of_recv_buf, uint32 timeout);
typedef void (*func_ebdat_atctl_setport)(int port);
typedef void (*func_ebdat_atctl_clear)(void);
//gps
#ifdef EBDAT_FEAT_GPS
#ifdef FEATURE_ATCOP_GPS
typedef boolean (*func_ebdat_gps_start)(ebdat_gps_start_mode_type_enum mode);
typedef boolean (*func_ebdat_gps_stop)(void);
typedef void (*func_ebdat_gps_get_fix_info)(char * gps_info, uint32 buf_size);
typedef int (*func_ebdat_gps_get_nmea_info)(ebdat_nmea_e_type nmea_type, char * nmea, uint32 buf_size);
typedef boolean (*func_ebdat_gps_set_mode)(ebdat_session_operation_e_type op);
typedef ebdat_session_operation_e_type (*func_ebdat_gps_get_mode)(void);
typedef boolean (*func_ebdat_gps_delete_info)(void);
#endif /* FEATURE_ATCOP_GPS */
#endif /* EBDAT_FEAT_GPS */
//gpio
#ifdef EBDAT_FEAT_GPIO
typedef boolean (*func_ebdat_gpio_config)(uint8 gpio, ebdat_gpio_direction_t gpio_io);
typedef boolean (*func_ebdat_gpio_out)(uint8 gpio, ebdat_gpio_value_t gpio_val);
typedef ebdat_gpio_value_t (*func_ebdat_gpio_get)(uint8 gpio);
typedef boolean (*func_ebdat_gpio_func_set)(uint8 gpio_func, boolean bEnabled);
typedef boolean (*func_ebdat_gpio_isr_set)(uint8 gpio_no, ebdat_gpio_int_detect_t detect, ebdat_gpio_int_pol_t polarity);
typedef boolean (*func_ebdat_gpio_debounce_set)(uint8 gpio_no, uint32 debounce_ms);
#endif /* EBDAT_FEAT_GPIO */
//spi
#ifdef EBDAT_FEAT_SPI
#ifdef FEATURE_SUPPORT_SPI
typedef void (*func_ebdat_spi_init)(void);
typedef void (*func_ebdat_spi_set_clk_info)(ebdat_spi_clk_pol_t clk_pol, ebdat_spi_clk_mode_t clk_md, ebdat_spi_trans_mode_t trans_md);
typedef void (*func_ebdat_spi_set_cs)(ebdat_spi_cs_mode_t cs_md, ebdat_spi_cs_pol_t cs_pol);
typedef void (*func_ebdat_spi_set_frequency)(uint32 nMinFreq, uint32 nMaxFreq, uint32 nDeassertionTime);
typedef void (*func_ebdat_spi_set_param)( uint8 nNumBits, ebdat_spi_input_packing_t input_packing, ebdat_spi_output_unpacking_t output_packing);
typedef void (*func_ebdat_spi_write_data)(uint8* data_byte, uint32 len);
typedef void (*func_ebdat_spi_write_uint32_data)(uint32* data_byte, uint32 len);
typedef void (*func_ebdat_spi_write_reg)(uint32 reg, uint32 reg_val, uint32 len);
typedef void (*func_ebdat_spi_read_reg)(uint32 reg, uint8* read_buf, uint32 len);
#endif /* FEATURE_SUPPORT_SPI */
#endif /* EBDAT_FEAT_SPI */
//hd
#ifdef EBDAT_FEAT_HD
typedef int (*func_ebdat_adc_read)(ebdat_adc_t adc_type);
typedef boolean (*func_ebdat_vaux_set)(uint16 level);
typedef uint16 (*func_ebdat_vaux_get)(void);
typedef boolean (*func_ebdat_vaux_switch)(boolean bEnabled);
typedef boolean (*func_ebdat_vaux_get_state)(void);
typedef boolean (*func_ebdat_i2c_read)(byte slave_addr, byte reg, byte *read_buf, int read_len);
typedef boolean (*func_ebdat_i2c_combined_write_read)(byte slave_addr, byte reg, byte *read_buf, int read_len);
typedef boolean (*func_ebdat_i2c_write)(byte slave_addr, byte reg, byte *write_buf, int write_len);
#endif /* EBDAT_FEAT_HD */
//pm
#ifdef EBDAT_FEAT_PM
typedef boolean (*func_ebdat_pm_auto_pwr_off_set)(uint32 low_voltage);
typedef uint32 (*func_ebdat_pm_auto_pwr_off_get)(void);
typedef void (*func_ebdat_pm_enable_low_voltage_alarm)(uint32 low_voltage);
typedef void (*func_ebdat_pm_disable_low_voltage_alarm)(void);
typedef boolean (*func_ebdat_pm_enable_auto_pwr_on)(uint8 hour, uint8 minute, boolean bRepeated);
typedef void (*func_ebdat_pm_disable_auto_pwr_on)(void);
typedef boolean (*func_ebdat_pm_enable_auto_pwr_off)(uint8 hour, uint8 minute, boolean bRepeated);
typedef void (*func_ebdat_pm_disable_auto_pwr_off)(void);
typedef void (*func_ebdat_pm_power_off)(void);
typedef void (*func_ebdat_pm_power_reset)(void);
#endif /* EBDAT_FEAT_PM */
//audio
#ifdef EBDAT_FEAT_AUDIO
typedef boolean (*func_ebdat_audio_mic_gain_set)(uint8 amp_level);
typedef boolean (*func_ebdat_audio_sidetone_set)(uint16 gain);
typedef boolean (*func_ebdat_auido_tx_gain_set)(uint16 gain);
typedef boolean (*func_ebdat_audio_rx_gain_set)(uint16 gain);
typedef boolean (*func_ebdat_audio_tx_vol_set)(uint16 volumn);
typedef boolean (*func_ebdat_audio_rx_vol_set)(uint16 volumn);
typedef boolean (*func_ebdat_audio_tx_ftr_set)(const ebdat_audio_pcm_ftr_t *ftr_param);
typedef boolean (*func_ebdat_audio_rx_ftr_set)(const ebdat_audio_pcm_ftr_t *ftr_param);
typedef boolean (*func_ebdat_audio_echo_mode_set)(ebdat_audio_ec_t ec_md);
typedef boolean (*func_ebdat_audio_noise_mode_set)(ebdat_audio_ns_t ns_md);
typedef boolean (*func_ebdat_audio_echo_param_set)(uint8 param_index, uint16 param_val);
typedef boolean (*func_ebdat_audio_volumn_level_set)(uint8 level, int16 volumn);
typedef boolean (*func_ebdat_audio_volumn_level_select)(uint8 level);
typedef boolean (*func_ebdat_audio_device_set)(ebdat_audio_dev_t dev_type);
typedef boolean (*func_ebdat_audio_device_mute)(boolean in_mute, boolean out_mute);
typedef boolean (*func_ebdat_audio_pcm_set)(ebdat_pcm_mode_t mode, ebdat_pcm_fmt_t fmt, uint8 slot);
typedef void (*func_ebdat_audio_play_tone)(ebdat_audio_dev_t dev, uint8 tone_id);
#endif /* EBDAT_FEAT_AUDIO */
//socket
typedef ebdat_ps_op_result_e_type (*func_ebdat_ps_open_ps_network)(uint8 cid,  ebdat_ps_op_net_cb_fcn net_cb_func, void* net_cb_user_data,ebdat_ps_sock_cb_fcn sock_cb_func,void* sock_cb_user_data, sint15* net_handle_ptr/*output*/);
typedef ebdat_ps_op_result_e_type (*func_ebdat_ps_close_ps_network)(int16 net_handle);
typedef ebdat_ps_op_result_e_type (*func_ebdat_ps_release_ps_netlib)(int net_handle);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_async_deselect)( int16 sock_fd, int32 event_mask);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_async_select)(int16 sock_fd, int32 event_mask);
typedef int16 (*func_ebdat_sock_create)(int16 nethandle, byte   family, byte   type,byte   protocol);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_connect)(const int16 sfd, struct sockaddr_in * addr, const size_t saddrsiz);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_recv)(const int16 sfd, byte* buf, uint32 len, int* bytes_recv_p);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_send)(const int16 sfd, byte* buf, uint32 len, int* bytes_sent_p);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_recvfrom)(const int16 sfd, byte* buf, uint32 len, int* bytes_recv_p, struct sockaddr_in* fromaddr_p);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_sendto)(const int16 sfd, byte* buf, uint32 len, int* bytes_sent_p, struct sockaddr_in* destaddr_p);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_close)(const int16 sfd);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_bind)(const int16 sfd, struct sockaddr_in * addr, const size_t saddrsiz);
typedef ebdat_ps_op_result_e_type (*func_ebdat_sock_listen)(const int16 sfd);
typedef int16 (*func_ebdat_sock_accept)(const int16 sfd, struct sockaddr_in* peer_addr_p);
typedef boolean (*func_ebdat_sock_setsockopt)( int sockfd,   int level,   int optname,   void *optval,   uint32 *optlen);
typedef boolean (*func_ebdat_sock_getsockopt)(  int sockfd,   int level,    int optname,    void *optval,      uint32 *optlen  );
typedef boolean (*func_ebdat_sock_get_sock_name)(int16 sfd, struct sockaddr* addr_p, uint16* addrlen_p);
typedef ebdat_ps_op_result_e_type (*func_ebdat_dns_get_host_entry)(const char *const host,  struct in_addr *const ip_address, ebdat_dns_event_callback_fcn dns_cb, void* user_data);
//math
typedef void (*func_srand)(unsigned int seed);
typedef int (*func_rand)(void);
typedef void (*func_qsort)(void *base, size_t nmemb, size_t size, int (*compar) (const void *, const void *));
typedef double (*func_atof)(const char* str);
typedef double (*func_fabs)( double x );
typedef double (*func_sin)(   double x);
typedef double (*func_sinh)( double x );
typedef double (*func_cos)(    double x );
typedef double (*func_cosh)(    double x );
typedef double (*func_tan)(   double x );
typedef double (*func_tanh)(   double x );
typedef double (*func_asin)(    double x );
typedef double (*func_acos)(    double x );
typedef double (*func_atan)(    double x );
typedef double (*func_atan2)(    double y,    double x );
typedef double (*func_ceil)(    double x );
typedef double (*func_floor)(   double x);
typedef double (*func_fmod)(    double x,   double y );
typedef double (*func_modf)(   double x,   double *intptr );
typedef double (*func_sqrt)(   double x );
typedef double (*func_log)(   double x );
typedef double (*func_log10)(   double x);
typedef double (*func_exp)(    double x);
typedef double (*func_frexp)(   double x,   int *expptr );
typedef double (*func_ldexp)(   double x,   int exp );
typedef void * (*func_bsearch)(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *));
//hash
typedef void (*func_ebdat_md5_Init)(ebdat_md5_ctx_s_type *);
typedef void (*func_ebdat_md5_update)(ebdat_md5_ctx_s_type *, const uint8 *, size_t);
typedef void (*func_ebdat_md5_final)(uint8 [MD5_DIGEST_LENGTH], ebdat_md5_ctx_s_type *);
typedef void (*func_ebdat_sha1_init)(ebdat_sha1_ctx_s_type * context);
typedef void (*func_ebdat_sha1_update)(ebdat_sha1_ctx_s_type *context, const unsigned char *data, unsigned int len);
typedef void (*func_ebdat_sha1_final)(unsigned char digest[SHA1_DIGEST_LENGTH], ebdat_sha1_ctx_s_type *context);
typedef void (*func_ebdat_sha256_init)(ebdat_sha2_ctx_s_type *);
typedef void (*func_ebdat_sha256_update)(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
typedef void (*func_ebdat_sha256_final)(uint8[SHA256_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);
typedef void (*func_ebdat_sha384_init)(ebdat_sha2_ctx_s_type *);
typedef void (*func_ebdat_sha384_update)(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
typedef void (*func_ebdat_sha384_final)(uint8[SHA384_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);
typedef void (*func_ebdat_sha512_init)(ebdat_sha2_ctx_s_type *);
typedef void (*func_ebdat_sha512_update)(ebdat_sha2_ctx_s_type *, const uint8 *, size_t);
typedef void (*func_ebdat_sha512_final)(uint8[SHA512_DIGEST_LENGTH], ebdat_sha2_ctx_s_type *);
//minizip
typedef void* (*func_ebdat_minizip_openzip)(char* zipfile_pathname, int append);
typedef int (*func_ebdat_minizip_add_file)(void* zf, char* filepathname,char* password, int opt_compress_level, boolean opt_exclude_path);
typedef int (*func_ebdat_minizip_closezip)(void* zf);
typedef void* (*func_ebdat_miniunz_openzip)(char* zipfile_pathname);
typedef int (*func_ebdat_miniunz_closezip)(void* uf);
typedef int (*func_ebdat_miniunz_get_entry_count)(void* uf);
typedef int (*func_ebdat_miniunz_get_current_file_info)(void* uf, char * szFileName, uint32 fileNameBufferSize, uint32* filesize_p, boolean* crypted_p);
typedef int (*func_ebdat_miniunz_goto_next_file) (void*  uf);
typedef int (*func_ebdat_miniunz_extract_currentfile)(void* uf,const char* password,char* dirname);
//lua
typedef boolean (*func_ebdat_lua_register_api_handler)(uint32 api_no, ebdat_lua_api_handler_func_type func);
typedef boolean (*func_ebdat_lua_deregister_api_handler)(uint32 api_no);
typedef boolean (*func_ebdat_lua_set_evt)(int thread_idx, EVT_ID_TYPE evt, EVT_PARAM_TYPE evt_p1, EVT_PARAM_TYPE evt_p2, EVT_PARAM_TYPE evt_p3, double evt_clock);
typedef void (*func_ebdat_lua_signal_notify)(int thread_index, uint8 sig_mask);
typedef void (*func_ebdat_lua_set_ready)(boolean ready);

//declare function pointer variables
#define DECLARE_FUNC(name) \
  extern func_##name f_##name
  
DECLARE_FUNC(strcpy);
DECLARE_FUNC(strlen);
DECLARE_FUNC(strncpy);
DECLARE_FUNC(strcat);
DECLARE_FUNC(strncat);
DECLARE_FUNC(strstr);
DECLARE_FUNC(strcmp);
DECLARE_FUNC(strncmp);
DECLARE_FUNC(sprintf);
DECLARE_FUNC(std_strlcpy);
DECLARE_FUNC(std_strlcat);
DECLARE_FUNC(std_strlprintf);
DECLARE_FUNC(sscanf);
DECLARE_FUNC(itoa);
DECLARE_FUNC(atoi);
DECLARE_FUNC(vsprintf);
DECLARE_FUNC(vsnprintf);

DECLARE_FUNC(memcpy);
DECLARE_FUNC(memchr);
DECLARE_FUNC(memcmp);
DECLARE_FUNC(memmove);
DECLARE_FUNC(memset);
DECLARE_FUNC(setjmp);
DECLARE_FUNC(longjmp);

DECLARE_FUNC(ebdat_os_printdir);
DECLARE_FUNC(ebdat_os_print);
DECLARE_FUNC(ebdat_os_get_tick);
DECLARE_FUNC(ebdat_os_mktime);
DECLARE_FUNC(ebdat_os_localtime);
DECLARE_FUNC(ebdat_os_gmtime);
DECLARE_FUNC(ebdat_os_strftime);
DECLARE_FUNC(ebdat_os_mem_alloc);
DECLARE_FUNC(ebdat_os_mem_realloc);
DECLARE_FUNC(ebdat_os_mem_free);
DECLARE_FUNC(ebdat_os_autodog);
DECLARE_FUNC(ebdat_os_assert_okts);
DECLARE_FUNC(ebdat_os_negate_okts);
DECLARE_FUNC(ebdat_os_get_usb_mode);
DECLARE_FUNC(ebdat_os_set_portmode);
DECLARE_FUNC(ebdat_os_get_portmode);
DECLARE_FUNC(ebdat_os_time);

DECLARE_FUNC(ebdat_set_evt);
DECLARE_FUNC(ebdat_wait_evt);
DECLARE_FUNC(ebdat_peek_evt);
DECLARE_FUNC(ebdat_clear_evts);
DECLARE_FUNC(ebdat_evt_get_evt_priority);
DECLARE_FUNC(ebdat_evt_set_evt_priority);
DECLARE_FUNC(ebdat_evt_set_evt_owner_thread_idx);
DECLARE_FUNC(ebdat_evt_get_evt_owner_thread_idx);
DECLARE_FUNC(ebdat_evt_set_evt_as_ignored);
DECLARE_FUNC(ebdat_evt_is_evt_ignored);
DECLARE_FUNC(ebdat_delete_spec_evt_with_params_from_queue);
DECLARE_FUNC(ebdat_get_evt_count_in_queue);
DECLARE_FUNC(ebdat_evt_filter_add);
DECLARE_FUNC(ebdat_evt_filter_delete);

DECLARE_FUNC(ebdat_set_current_thread_priority);
DECLARE_FUNC(ebdat_set_thread_priority);
DECLARE_FUNC(ebdat_get_current_thread_priority);
DECLARE_FUNC(ebdat_get_thread_priority);
DECLARE_FUNC(ebdat_enter_crit_sect);
DECLARE_FUNC(ebdat_leave_crit_sect);
DECLARE_FUNC(ebdat_thread_sleep);
DECLARE_FUNC(ebdat_create_thread);
DECLARE_FUNC(ebdat_kill_thread);
DECLARE_FUNC(ebdat_resume_thread);
DECLARE_FUNC(ebdat_suspend_thread);
DECLARE_FUNC(ebdat_thread_running);
DECLARE_FUNC(ebdat_thread_suspended);
DECLARE_FUNC(ebdat_thread_get_current_index);
DECLARE_FUNC(ebdat_thread_register_prekill_func);
DECLARE_FUNC(ebdat_signal_clean);
DECLARE_FUNC(ebdat_signal_notify);
DECLARE_FUNC(ebdat_signal_wait);

DECLARE_FUNC(ebdat_starttimer);
DECLARE_FUNC(ebdat_stoptimer);
DECLARE_FUNC(ebdat_stopalltimer_for_thread);
DECLARE_FUNC(ebdat_stopalltimer);
DECLARE_FUNC(ebdat_sio_send);
DECLARE_FUNC(ebdat_sio_recv);
DECLARE_FUNC(ebdat_sio_exclrpt);
DECLARE_FUNC(ebdat_sio_enable_recv);
DECLARE_FUNC(ebdat_sio_clear);
DECLARE_FUNC(ebdat_sio_set_rcvcache_size);
DECLARE_FUNC(ebdat_sio_get_rcvcache_size);
//efs
DECLARE_FUNC(ebdat_efs_creat);
DECLARE_FUNC(ebdat_efs_open);
DECLARE_FUNC(ebdat_efs_close);
DECLARE_FUNC(ebdat_efs_read);
DECLARE_FUNC(ebdat_efs_write);
DECLARE_FUNC(ebdat_efs_ftruncate);
DECLARE_FUNC(ebdat_efs_lseek);
DECLARE_FUNC(ebdat_efs_stat);
DECLARE_FUNC(ebdat_efs_fstat);
DECLARE_FUNC(ebdat_efs_lstat);
DECLARE_FUNC(ebdat_efs_tell);
DECLARE_FUNC(ebdat_efs_get_opened_filesize);
DECLARE_FUNC(ebdat_efs_file_exist);
DECLARE_FUNC(ebdat_efs_dir_exist);
DECLARE_FUNC(ebdat_efs_delete_file);
DECLARE_FUNC(ebdat_efs_rmdir);
DECLARE_FUNC(ebdat_efs_mkdir);
DECLARE_FUNC(ebdat_efs_get_filesize);
DECLARE_FUNC(ebdat_efs_truncate_file);
DECLARE_FUNC(ebdat_efs_lsdir);
DECLARE_FUNC(ebdat_efs_lsfile);
//ftp
DECLARE_FUNC(ebdat_ftp_simpput);
DECLARE_FUNC(ebdat_ftp_simpget);
DECLARE_FUNC(ebdat_ftp_simplist);
//mms
DECLARE_FUNC(ebdat_mms_accquire_module);
DECLARE_FUNC(ebdat_mms_release_module);
DECLARE_FUNC(ebdat_mms_set_mmsc);
DECLARE_FUNC(ebdat_mms_get_mmsc);
DECLARE_FUNC(ebdat_mms_set_protocol);
DECLARE_FUNC(ebdat_mms_get_protocol);
DECLARE_FUNC(ebdat_mms_set_edit);
DECLARE_FUNC(ebdat_mms_set_title);
DECLARE_FUNC(ebdat_mms_get_title);
DECLARE_FUNC(ebdat_mms_attach_file);
DECLARE_FUNC(ebdat_mms_attach_file_from_memory);
DECLARE_FUNC(ebdat_mms_add_receipt);
DECLARE_FUNC(ebdat_mms_delete_receipt);
DECLARE_FUNC(ebdat_mms_list_receipts);
DECLARE_FUNC(ebdat_mms_save_attachment);
DECLARE_FUNC(ebdat_mms_save);
DECLARE_FUNC(ebdat_mms_load);
DECLARE_FUNC(ebdat_mms_get_attach_info);
DECLARE_FUNC(ebdat_mms_list_attach_info);
DECLARE_FUNC(ebdat_mms_get_delivery_date_info);
DECLARE_FUNC(ebdat_mms_read_attachment);
DECLARE_FUNC(ebdat_mms_send);
DECLARE_FUNC(ebdat_mms_recv);
//sms
#ifdef EBDAT_FEAT_SMS
DECLARE_FUNC(ebdat_sms_get_cmgf);
DECLARE_FUNC(ebdat_sms_set_cmgf);
DECLARE_FUNC(ebdat_sms_get_cscs);
DECLARE_FUNC(ebdat_sms_set_cscs);
DECLARE_FUNC(ebdat_sms_get_next_msg_ref);
DECLARE_FUNC(ebdat_sms_convert_chset);
DECLARE_FUNC(ebdat_sms_send_smstxt_msg);
DECLARE_FUNC(ebdat_sms_write_smstxt_msg);
DECLARE_FUNC(ebdat_sms_decode_pdu_sms);
DECLARE_FUNC(ebdat_sms_cmss);
DECLARE_FUNC(ebdat_sms_read_msg);
#endif /* EBDAT_FEAT_SMS */
//smtp
#ifdef FEATURE_ATCOP_TRECK_SMTP
DECLARE_FUNC(ebdat_smtp_config);
DECLARE_FUNC(ebdat_smtp_set_from);
DECLARE_FUNC(ebdat_smtp_set_rcpt);
DECLARE_FUNC(ebdat_smtp_set_subject);
DECLARE_FUNC(ebdat_smtp_set_body_charset);
DECLARE_FUNC(ebdat_smtp_set_body);
DECLARE_FUNC(ebdat_smtp_set_file);
DECLARE_FUNC(ebdat_smtp_send);
#endif /* FEATURE_ATCOP_TRECK_SMTP */
//network
#ifdef EBDAT_FEAT_NETWORK
DECLARE_FUNC(ebdat_network_get_creg);
DECLARE_FUNC(ebdat_network_get_cgreg);
DECLARE_FUNC(ebdat_network_get_cnsmod);
DECLARE_FUNC(ebdat_network_get_csq);
#endif /* EBDAT_FEAT_NETWORK */
//atctl
DECLARE_FUNC(ebdat_atctl_send);
DECLARE_FUNC(ebdat_atctl_recv);
DECLARE_FUNC(ebdat_atctl_setport);
DECLARE_FUNC(ebdat_atctl_clear);

//gps
#ifdef EBDAT_FEAT_GPS
#ifdef FEATURE_ATCOP_GPS
DECLARE_FUNC(ebdat_gps_start);
DECLARE_FUNC(ebdat_gps_stop);
DECLARE_FUNC(ebdat_gps_get_fix_info);
DECLARE_FUNC(ebdat_gps_get_nmea_info);
DECLARE_FUNC(ebdat_gps_set_mode);
DECLARE_FUNC(ebdat_gps_get_mode);
DECLARE_FUNC(ebdat_gps_delete_info);
#endif /* FEATURE_ATCOP_GPS */
#endif /* EBDAT_FEAT_GPS */

//gpio
#ifdef EBDAT_FEAT_GPIO
DECLARE_FUNC(ebdat_gpio_config);
DECLARE_FUNC(ebdat_gpio_out);
DECLARE_FUNC(ebdat_gpio_get);
DECLARE_FUNC(ebdat_gpio_func_set);
DECLARE_FUNC(ebdat_gpio_isr_set);
DECLARE_FUNC(ebdat_gpio_debounce_set);
#endif /* EBDAT_FEAT_GPIO */
//spi
#ifdef EBDAT_FEAT_SPI
#ifdef FEATURE_SUPPORT_SPI
DECLARE_FUNC(ebdat_spi_init);
DECLARE_FUNC(ebdat_spi_set_clk_info);
DECLARE_FUNC(ebdat_spi_set_cs);
DECLARE_FUNC(ebdat_spi_set_frequency);
DECLARE_FUNC(ebdat_spi_set_param);
DECLARE_FUNC(ebdat_spi_write_data);
DECLARE_FUNC(ebdat_spi_write_uint32_data);
DECLARE_FUNC(ebdat_spi_write_reg);
DECLARE_FUNC(ebdat_spi_read_reg);
#endif /* FEATURE_SUPPORT_SPI */
#endif /* EBDAT_FEAT_SPI */
//hd
#ifdef EBDAT_FEAT_HD
DECLARE_FUNC(ebdat_adc_read);
DECLARE_FUNC(ebdat_vaux_set);
DECLARE_FUNC(ebdat_vaux_get);
DECLARE_FUNC(ebdat_vaux_switch);
DECLARE_FUNC(ebdat_vaux_get_state);
DECLARE_FUNC(ebdat_i2c_read);
DECLARE_FUNC(ebdat_i2c_combined_write_read);
DECLARE_FUNC(ebdat_i2c_write);
#endif /* EBDAT_FEAT_HD */
//pm
#ifdef EBDAT_FEAT_PM
DECLARE_FUNC(ebdat_pm_auto_pwr_off_set);
DECLARE_FUNC(ebdat_pm_auto_pwr_off_get);
DECLARE_FUNC(ebdat_pm_enable_low_voltage_alarm);
DECLARE_FUNC(ebdat_pm_disable_low_voltage_alarm);
DECLARE_FUNC(ebdat_pm_enable_auto_pwr_on);
DECLARE_FUNC(ebdat_pm_disable_auto_pwr_on);
DECLARE_FUNC(ebdat_pm_enable_auto_pwr_off);
DECLARE_FUNC(ebdat_pm_disable_auto_pwr_off);
DECLARE_FUNC(ebdat_pm_power_off);
DECLARE_FUNC(ebdat_pm_power_reset);
#endif /* EBDAT_FEAT_PM */
//audio
#ifdef EBDAT_FEAT_AUDIO
DECLARE_FUNC(ebdat_audio_mic_gain_set);
DECLARE_FUNC(ebdat_audio_sidetone_set);
DECLARE_FUNC(ebdat_auido_tx_gain_set);
DECLARE_FUNC(ebdat_audio_rx_gain_set);
DECLARE_FUNC(ebdat_audio_tx_vol_set);
DECLARE_FUNC(ebdat_audio_rx_vol_set);
DECLARE_FUNC(ebdat_audio_tx_ftr_set);
DECLARE_FUNC(ebdat_audio_rx_ftr_set);
DECLARE_FUNC(ebdat_audio_echo_mode_set);
DECLARE_FUNC(ebdat_audio_noise_mode_set);
DECLARE_FUNC(ebdat_audio_echo_param_set);
DECLARE_FUNC(ebdat_audio_volumn_level_set);
DECLARE_FUNC(ebdat_audio_volumn_level_select);
DECLARE_FUNC(ebdat_audio_device_set);
DECLARE_FUNC(ebdat_audio_device_mute);
DECLARE_FUNC(ebdat_audio_pcm_set);
DECLARE_FUNC(ebdat_audio_play_tone);
#endif /* EBDAT_FEAT_AUDIO */
//socket
DECLARE_FUNC(ebdat_ps_open_ps_network);
DECLARE_FUNC(ebdat_ps_close_ps_network);
DECLARE_FUNC(ebdat_ps_release_ps_netlib);
DECLARE_FUNC(ebdat_sock_async_deselect);
DECLARE_FUNC(ebdat_sock_async_select);
DECLARE_FUNC(ebdat_sock_create);
DECLARE_FUNC(ebdat_sock_connect);
DECLARE_FUNC(ebdat_sock_recv);
DECLARE_FUNC(ebdat_sock_send);
DECLARE_FUNC(ebdat_sock_recvfrom);
DECLARE_FUNC(ebdat_sock_sendto);
DECLARE_FUNC(ebdat_sock_close);
DECLARE_FUNC(ebdat_sock_bind);
DECLARE_FUNC(ebdat_sock_listen);
DECLARE_FUNC(ebdat_sock_accept);
DECLARE_FUNC(ebdat_sock_setsockopt);
DECLARE_FUNC(ebdat_sock_getsockopt);
DECLARE_FUNC(ebdat_sock_get_sock_name);
DECLARE_FUNC(ebdat_dns_get_host_entry);
//math
DECLARE_FUNC(srand);
DECLARE_FUNC(rand);
DECLARE_FUNC(qsort);
DECLARE_FUNC(atof);
DECLARE_FUNC(fabs);
DECLARE_FUNC(sin);
DECLARE_FUNC(sinh);
DECLARE_FUNC(cos);
DECLARE_FUNC(cosh);
DECLARE_FUNC(tan);
DECLARE_FUNC(tanh);
DECLARE_FUNC(asin);
DECLARE_FUNC(acos);
DECLARE_FUNC(atan);
DECLARE_FUNC(atan2);
DECLARE_FUNC(ceil);
DECLARE_FUNC(floor);
DECLARE_FUNC(fmod);
DECLARE_FUNC(modf);
DECLARE_FUNC(sqrt);
DECLARE_FUNC(log);
DECLARE_FUNC(log10);
DECLARE_FUNC(exp);
DECLARE_FUNC(frexp);
DECLARE_FUNC(ldexp);
DECLARE_FUNC(bsearch);
//hash
DECLARE_FUNC(ebdat_md5_Init);
DECLARE_FUNC(ebdat_md5_update);
DECLARE_FUNC(ebdat_md5_final);
DECLARE_FUNC(ebdat_sha1_init);
DECLARE_FUNC(ebdat_sha1_update);
DECLARE_FUNC(ebdat_sha1_final);
DECLARE_FUNC(ebdat_sha256_init);
DECLARE_FUNC(ebdat_sha256_update);
DECLARE_FUNC(ebdat_sha256_final);
DECLARE_FUNC(ebdat_sha384_init);
DECLARE_FUNC(ebdat_sha384_update);
DECLARE_FUNC(ebdat_sha384_final);
DECLARE_FUNC(ebdat_sha512_init);
DECLARE_FUNC(ebdat_sha512_update);
DECLARE_FUNC(ebdat_sha512_final);
//minizip
DECLARE_FUNC(ebdat_minizip_openzip);
DECLARE_FUNC(ebdat_minizip_add_file);
DECLARE_FUNC(ebdat_minizip_closezip);
DECLARE_FUNC(ebdat_miniunz_openzip);
DECLARE_FUNC(ebdat_miniunz_closezip);
DECLARE_FUNC(ebdat_miniunz_get_entry_count);
DECLARE_FUNC(ebdat_miniunz_get_current_file_info);
DECLARE_FUNC(ebdat_miniunz_goto_next_file);
DECLARE_FUNC(ebdat_miniunz_extract_currentfile);
//lua
DECLARE_FUNC(ebdat_lua_register_api_handler);
DECLARE_FUNC(ebdat_lua_deregister_api_handler);
DECLARE_FUNC(ebdat_lua_set_evt);
DECLARE_FUNC(ebdat_lua_signal_notify); 
DECLARE_FUNC(ebdat_lua_set_ready);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_FUNC_ARY_H__ */

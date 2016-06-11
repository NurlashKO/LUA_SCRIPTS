#include ".\inc\cust_header.h"

//declare function pointer variables
#define DEFINE_FUNC(name) \
func_##name f_##name
  
DEFINE_FUNC(strcpy);
DEFINE_FUNC(strlen);
DEFINE_FUNC(strncpy);
DEFINE_FUNC(strcat);
DEFINE_FUNC(strncat);
DEFINE_FUNC(strstr);
DEFINE_FUNC(strcmp);
DEFINE_FUNC(strncmp);
DEFINE_FUNC(sprintf);
DEFINE_FUNC(std_strlcpy);
DEFINE_FUNC(std_strlcat);
DEFINE_FUNC(std_strlprintf);
DEFINE_FUNC(sscanf);
DEFINE_FUNC(itoa);
DEFINE_FUNC(atoi);
DEFINE_FUNC(vsprintf);
DEFINE_FUNC(vsnprintf);

DEFINE_FUNC(memcpy);
DEFINE_FUNC(memchr);
DEFINE_FUNC(memcmp);
DEFINE_FUNC(memmove);
DEFINE_FUNC(memset);
DEFINE_FUNC(setjmp);
DEFINE_FUNC(longjmp);

DEFINE_FUNC(ebdat_os_printdir);
DEFINE_FUNC(ebdat_os_print);
DEFINE_FUNC(ebdat_os_get_tick);
DEFINE_FUNC(ebdat_os_mktime);
DEFINE_FUNC(ebdat_os_localtime);
DEFINE_FUNC(ebdat_os_gmtime);
DEFINE_FUNC(ebdat_os_strftime);
DEFINE_FUNC(ebdat_os_mem_alloc);
DEFINE_FUNC(ebdat_os_mem_realloc);
DEFINE_FUNC(ebdat_os_mem_free);
DEFINE_FUNC(ebdat_os_autodog);
DEFINE_FUNC(ebdat_os_assert_okts);
DEFINE_FUNC(ebdat_os_negate_okts);
DEFINE_FUNC(ebdat_os_get_usb_mode);
DEFINE_FUNC(ebdat_os_set_portmode);
DEFINE_FUNC(ebdat_os_get_portmode);
DEFINE_FUNC(ebdat_os_time);

DEFINE_FUNC(ebdat_set_evt);
DEFINE_FUNC(ebdat_wait_evt);
DEFINE_FUNC(ebdat_peek_evt);
DEFINE_FUNC(ebdat_clear_evts);
DEFINE_FUNC(ebdat_evt_get_evt_priority);
DEFINE_FUNC(ebdat_evt_set_evt_priority);
DEFINE_FUNC(ebdat_evt_set_evt_owner_thread_idx);
DEFINE_FUNC(ebdat_evt_get_evt_owner_thread_idx);
DEFINE_FUNC(ebdat_evt_set_evt_as_ignored);
DEFINE_FUNC(ebdat_evt_is_evt_ignored);
DEFINE_FUNC(ebdat_delete_spec_evt_with_params_from_queue);
DEFINE_FUNC(ebdat_get_evt_count_in_queue);
DEFINE_FUNC(ebdat_evt_filter_add);
DEFINE_FUNC(ebdat_evt_filter_delete);

DEFINE_FUNC(ebdat_set_current_thread_priority);
DEFINE_FUNC(ebdat_set_thread_priority);
DEFINE_FUNC(ebdat_get_current_thread_priority);
DEFINE_FUNC(ebdat_get_thread_priority);
DEFINE_FUNC(ebdat_enter_crit_sect);
DEFINE_FUNC(ebdat_leave_crit_sect);
DEFINE_FUNC(ebdat_thread_sleep);
DEFINE_FUNC(ebdat_create_thread);
DEFINE_FUNC(ebdat_kill_thread);
DEFINE_FUNC(ebdat_resume_thread);
DEFINE_FUNC(ebdat_suspend_thread);
DEFINE_FUNC(ebdat_thread_running);
DEFINE_FUNC(ebdat_thread_suspended);
DEFINE_FUNC(ebdat_thread_get_current_index);
DEFINE_FUNC(ebdat_thread_register_prekill_func);
DEFINE_FUNC(ebdat_signal_clean);
DEFINE_FUNC(ebdat_signal_notify);
DEFINE_FUNC(ebdat_signal_wait);

DEFINE_FUNC(ebdat_starttimer);
DEFINE_FUNC(ebdat_stoptimer);
DEFINE_FUNC(ebdat_stopalltimer_for_thread);
DEFINE_FUNC(ebdat_stopalltimer);
DEFINE_FUNC(ebdat_sio_send);
DEFINE_FUNC(ebdat_sio_recv);
DEFINE_FUNC(ebdat_sio_exclrpt);
DEFINE_FUNC(ebdat_sio_enable_recv);
DEFINE_FUNC(ebdat_sio_clear);
DEFINE_FUNC(ebdat_sio_set_rcvcache_size);
DEFINE_FUNC(ebdat_sio_get_rcvcache_size);
//efs
DEFINE_FUNC(ebdat_efs_creat);
DEFINE_FUNC(ebdat_efs_open);
DEFINE_FUNC(ebdat_efs_close);
DEFINE_FUNC(ebdat_efs_read);
DEFINE_FUNC(ebdat_efs_write);
DEFINE_FUNC(ebdat_efs_ftruncate);
DEFINE_FUNC(ebdat_efs_lseek);
DEFINE_FUNC(ebdat_efs_stat);
DEFINE_FUNC(ebdat_efs_fstat);
DEFINE_FUNC(ebdat_efs_lstat);
DEFINE_FUNC(ebdat_efs_tell);
DEFINE_FUNC(ebdat_efs_get_opened_filesize);
DEFINE_FUNC(ebdat_efs_file_exist);
DEFINE_FUNC(ebdat_efs_dir_exist);
DEFINE_FUNC(ebdat_efs_delete_file);
DEFINE_FUNC(ebdat_efs_rmdir);
DEFINE_FUNC(ebdat_efs_mkdir);
DEFINE_FUNC(ebdat_efs_get_filesize);
DEFINE_FUNC(ebdat_efs_truncate_file);
DEFINE_FUNC(ebdat_efs_lsdir);
DEFINE_FUNC(ebdat_efs_lsfile);
//ftp
DEFINE_FUNC(ebdat_ftp_simpput);
DEFINE_FUNC(ebdat_ftp_simpget);
DEFINE_FUNC(ebdat_ftp_simplist);
//mms
DEFINE_FUNC(ebdat_mms_accquire_module);
DEFINE_FUNC(ebdat_mms_release_module);
DEFINE_FUNC(ebdat_mms_set_mmsc);
DEFINE_FUNC(ebdat_mms_get_mmsc);
DEFINE_FUNC(ebdat_mms_set_protocol);
DEFINE_FUNC(ebdat_mms_get_protocol);
DEFINE_FUNC(ebdat_mms_set_edit);
DEFINE_FUNC(ebdat_mms_set_title);
DEFINE_FUNC(ebdat_mms_get_title);
DEFINE_FUNC(ebdat_mms_attach_file);
DEFINE_FUNC(ebdat_mms_attach_file_from_memory);
DEFINE_FUNC(ebdat_mms_add_receipt);
DEFINE_FUNC(ebdat_mms_delete_receipt);
DEFINE_FUNC(ebdat_mms_list_receipts);
DEFINE_FUNC(ebdat_mms_save_attachment);
DEFINE_FUNC(ebdat_mms_save);
DEFINE_FUNC(ebdat_mms_load);
DEFINE_FUNC(ebdat_mms_get_attach_info);
DEFINE_FUNC(ebdat_mms_list_attach_info);
DEFINE_FUNC(ebdat_mms_get_delivery_date_info);
DEFINE_FUNC(ebdat_mms_read_attachment);
DEFINE_FUNC(ebdat_mms_send);
DEFINE_FUNC(ebdat_mms_recv);
//sms
#ifdef EBDAT_FEAT_SMS
DEFINE_FUNC(ebdat_sms_get_cmgf);
DEFINE_FUNC(ebdat_sms_set_cmgf);
DEFINE_FUNC(ebdat_sms_get_cscs);
DEFINE_FUNC(ebdat_sms_set_cscs);
DEFINE_FUNC(ebdat_sms_get_next_msg_ref);
DEFINE_FUNC(ebdat_sms_convert_chset);
DEFINE_FUNC(ebdat_sms_send_smstxt_msg);
DEFINE_FUNC(ebdat_sms_write_smstxt_msg);
DEFINE_FUNC(ebdat_sms_decode_pdu_sms);
DEFINE_FUNC(ebdat_sms_cmss);
DEFINE_FUNC(ebdat_sms_read_msg);
#endif /* EBDAT_FEAT_SMS */
//smtp
#ifdef FEATURE_ATCOP_TRECK_SMTP
DEFINE_FUNC(ebdat_smtp_config);
DEFINE_FUNC(ebdat_smtp_set_from);
DEFINE_FUNC(ebdat_smtp_set_rcpt);
DEFINE_FUNC(ebdat_smtp_set_subject);
DEFINE_FUNC(ebdat_smtp_set_body_charset);
DEFINE_FUNC(ebdat_smtp_set_body);
DEFINE_FUNC(ebdat_smtp_set_file);
DEFINE_FUNC(ebdat_smtp_send);
#endif /* FEATURE_ATCOP_TRECK_SMTP */
//network
#ifdef EBDAT_FEAT_NETWORK
DEFINE_FUNC(ebdat_network_get_creg);
DEFINE_FUNC(ebdat_network_get_cgreg);
DEFINE_FUNC(ebdat_network_get_cnsmod);
DEFINE_FUNC(ebdat_network_get_csq);
#endif /* EBDAT_FEAT_NETWORK */
//atctl
DEFINE_FUNC(ebdat_atctl_send);
DEFINE_FUNC(ebdat_atctl_recv);
DEFINE_FUNC(ebdat_atctl_setport);
DEFINE_FUNC(ebdat_atctl_clear);
//gps
#ifdef EBDAT_FEAT_GPS
#ifdef FEATURE_ATCOP_GPS
DEFINE_FUNC(ebdat_gps_start);
DEFINE_FUNC(ebdat_gps_stop);
DEFINE_FUNC(ebdat_gps_get_fix_info);
DEFINE_FUNC(ebdat_gps_get_nmea_info);
DEFINE_FUNC(ebdat_gps_set_mode);
DEFINE_FUNC(ebdat_gps_get_mode);
DEFINE_FUNC(ebdat_gps_delete_info);
#endif /* FEATURE_ATCOP_GPS */
#endif /* EBDAT_FEAT_GPS */
//gpio
#ifdef EBDAT_FEAT_GPIO
DEFINE_FUNC(ebdat_gpio_config);
DEFINE_FUNC(ebdat_gpio_out);
DEFINE_FUNC(ebdat_gpio_get);
DEFINE_FUNC(ebdat_gpio_func_set);
DEFINE_FUNC(ebdat_gpio_isr_set);
DEFINE_FUNC(ebdat_gpio_debounce_set);
#endif /* EBDAT_FEAT_GPIO */
//spi
#ifdef EBDAT_FEAT_SPI
#ifdef FEATURE_SUPPORT_SPI
DEFINE_FUNC(ebdat_spi_init);
DEFINE_FUNC(ebdat_spi_set_clk_info);
DEFINE_FUNC(ebdat_spi_set_cs);
DEFINE_FUNC(ebdat_spi_set_frequency);
DEFINE_FUNC(ebdat_spi_set_param);
DEFINE_FUNC(ebdat_spi_write_data);
DEFINE_FUNC(ebdat_spi_write_uint32_data);
DEFINE_FUNC(ebdat_spi_write_reg);
DEFINE_FUNC(ebdat_spi_read_reg);
#endif /* FEATURE_SUPPORT_SPI */
#endif /* EBDAT_FEAT_SPI */
//hd
#ifdef EBDAT_FEAT_HD
DEFINE_FUNC(ebdat_adc_read);
DEFINE_FUNC(ebdat_vaux_set);
DEFINE_FUNC(ebdat_vaux_get);
DEFINE_FUNC(ebdat_vaux_switch);
DEFINE_FUNC(ebdat_vaux_get_state);
DEFINE_FUNC(ebdat_i2c_read);
DEFINE_FUNC(ebdat_i2c_combined_write_read);
DEFINE_FUNC(ebdat_i2c_write);
#endif /* EBDAT_FEAT_HD */
//pm
#ifdef EBDAT_FEAT_PM
DEFINE_FUNC(ebdat_pm_auto_pwr_off_set);
DEFINE_FUNC(ebdat_pm_auto_pwr_off_get);
DEFINE_FUNC(ebdat_pm_enable_low_voltage_alarm);
DEFINE_FUNC(ebdat_pm_disable_low_voltage_alarm);
DEFINE_FUNC(ebdat_pm_enable_auto_pwr_on);
DEFINE_FUNC(ebdat_pm_disable_auto_pwr_on);
DEFINE_FUNC(ebdat_pm_enable_auto_pwr_off);
DEFINE_FUNC(ebdat_pm_disable_auto_pwr_off);
DEFINE_FUNC(ebdat_pm_power_off);
DEFINE_FUNC(ebdat_pm_power_reset);
#endif /* EBDAT_FEAT_PM */
//audio
#ifdef EBDAT_FEAT_AUDIO
DEFINE_FUNC(ebdat_audio_mic_gain_set);
DEFINE_FUNC(ebdat_audio_sidetone_set);
DEFINE_FUNC(ebdat_auido_tx_gain_set);
DEFINE_FUNC(ebdat_audio_rx_gain_set);
DEFINE_FUNC(ebdat_audio_tx_vol_set);
DEFINE_FUNC(ebdat_audio_rx_vol_set);
DEFINE_FUNC(ebdat_audio_tx_ftr_set);
DEFINE_FUNC(ebdat_audio_rx_ftr_set);
DEFINE_FUNC(ebdat_audio_echo_mode_set);
DEFINE_FUNC(ebdat_audio_noise_mode_set);
DEFINE_FUNC(ebdat_audio_echo_param_set);
DEFINE_FUNC(ebdat_audio_volumn_level_set);
DEFINE_FUNC(ebdat_audio_volumn_level_select);
DEFINE_FUNC(ebdat_audio_device_set);
DEFINE_FUNC(ebdat_audio_device_mute);
DEFINE_FUNC(ebdat_audio_pcm_set);
DEFINE_FUNC(ebdat_audio_play_tone);
#endif /* EBDAT_FEAT_AUDIO */
//socket
DEFINE_FUNC(ebdat_ps_open_ps_network);
DEFINE_FUNC(ebdat_ps_close_ps_network);
DEFINE_FUNC(ebdat_ps_release_ps_netlib);
DEFINE_FUNC(ebdat_sock_async_deselect);
DEFINE_FUNC(ebdat_sock_async_select);
DEFINE_FUNC(ebdat_sock_create);
DEFINE_FUNC(ebdat_sock_connect);
DEFINE_FUNC(ebdat_sock_recv);
DEFINE_FUNC(ebdat_sock_send);
DEFINE_FUNC(ebdat_sock_recvfrom);
DEFINE_FUNC(ebdat_sock_sendto);
DEFINE_FUNC(ebdat_sock_close);
DEFINE_FUNC(ebdat_sock_bind);
DEFINE_FUNC(ebdat_sock_listen);
DEFINE_FUNC(ebdat_sock_accept);
DEFINE_FUNC(ebdat_sock_setsockopt);
DEFINE_FUNC(ebdat_sock_getsockopt);
DEFINE_FUNC(ebdat_sock_get_sock_name);
DEFINE_FUNC(ebdat_dns_get_host_entry);
//math
DEFINE_FUNC(srand);
DEFINE_FUNC(rand);
DEFINE_FUNC(qsort);
DEFINE_FUNC(atof);
DEFINE_FUNC(fabs);
DEFINE_FUNC(sin);
DEFINE_FUNC(sinh);
DEFINE_FUNC(cos);
DEFINE_FUNC(cosh);
DEFINE_FUNC(tan);
DEFINE_FUNC(tanh);
DEFINE_FUNC(asin);
DEFINE_FUNC(acos);
DEFINE_FUNC(atan);
DEFINE_FUNC(atan2);
DEFINE_FUNC(ceil);
DEFINE_FUNC(floor);
DEFINE_FUNC(fmod);
DEFINE_FUNC(modf);
DEFINE_FUNC(sqrt);
DEFINE_FUNC(log);
DEFINE_FUNC(log10);
DEFINE_FUNC(exp);
DEFINE_FUNC(frexp);
DEFINE_FUNC(ldexp);
DEFINE_FUNC(bsearch);
//hash
DEFINE_FUNC(ebdat_md5_Init);
DEFINE_FUNC(ebdat_md5_update);
DEFINE_FUNC(ebdat_md5_final);
DEFINE_FUNC(ebdat_sha1_init);
DEFINE_FUNC(ebdat_sha1_update);
DEFINE_FUNC(ebdat_sha1_final);
DEFINE_FUNC(ebdat_sha256_init);
DEFINE_FUNC(ebdat_sha256_update);
DEFINE_FUNC(ebdat_sha256_final);
DEFINE_FUNC(ebdat_sha384_init);
DEFINE_FUNC(ebdat_sha384_update);
DEFINE_FUNC(ebdat_sha384_final);
DEFINE_FUNC(ebdat_sha512_init);
DEFINE_FUNC(ebdat_sha512_update);
DEFINE_FUNC(ebdat_sha512_final);
//minizip
DEFINE_FUNC(ebdat_minizip_openzip);
DEFINE_FUNC(ebdat_minizip_add_file);
DEFINE_FUNC(ebdat_minizip_closezip);
DEFINE_FUNC(ebdat_miniunz_openzip);
DEFINE_FUNC(ebdat_miniunz_closezip);
DEFINE_FUNC(ebdat_miniunz_get_entry_count);
DEFINE_FUNC(ebdat_miniunz_get_current_file_info);
DEFINE_FUNC(ebdat_miniunz_goto_next_file);
DEFINE_FUNC(ebdat_miniunz_extract_currentfile);
//lua
DEFINE_FUNC(ebdat_lua_register_api_handler);
DEFINE_FUNC(ebdat_lua_deregister_api_handler);
DEFINE_FUNC(ebdat_lua_set_evt);
DEFINE_FUNC(ebdat_lua_signal_notify);
DEFINE_FUNC(ebdat_lua_set_ready);


#define LOAD_EBDAT_FUNC_ARY_ITEM(name) \
  f_##name = (func_##name)func_ary[IDF_##name]

boolean ebdat_func_load_ary(void** func_ary, uint32 func_count)
{
	if (!func_ary || func_count == 0)
	{
		  return FALSE;
	}
	LOAD_EBDAT_FUNC_ARY_ITEM(strcpy);
	LOAD_EBDAT_FUNC_ARY_ITEM(strlen);
  LOAD_EBDAT_FUNC_ARY_ITEM(strncpy);
  LOAD_EBDAT_FUNC_ARY_ITEM(strcat);
  LOAD_EBDAT_FUNC_ARY_ITEM(strncat);
  LOAD_EBDAT_FUNC_ARY_ITEM(strstr);
  LOAD_EBDAT_FUNC_ARY_ITEM(strcmp);
  LOAD_EBDAT_FUNC_ARY_ITEM(strncmp);
  LOAD_EBDAT_FUNC_ARY_ITEM(sprintf);
  LOAD_EBDAT_FUNC_ARY_ITEM(std_strlcpy);
  LOAD_EBDAT_FUNC_ARY_ITEM(std_strlcat);
  LOAD_EBDAT_FUNC_ARY_ITEM(std_strlprintf);
  LOAD_EBDAT_FUNC_ARY_ITEM(sscanf);
  LOAD_EBDAT_FUNC_ARY_ITEM(itoa);
  LOAD_EBDAT_FUNC_ARY_ITEM(atoi);
  LOAD_EBDAT_FUNC_ARY_ITEM(vsprintf);
  LOAD_EBDAT_FUNC_ARY_ITEM(vsnprintf);
  
  LOAD_EBDAT_FUNC_ARY_ITEM(memcpy);
  LOAD_EBDAT_FUNC_ARY_ITEM(memchr);
  LOAD_EBDAT_FUNC_ARY_ITEM(memcmp);
  LOAD_EBDAT_FUNC_ARY_ITEM(memmove);
  LOAD_EBDAT_FUNC_ARY_ITEM(memset);
  LOAD_EBDAT_FUNC_ARY_ITEM(setjmp);
  LOAD_EBDAT_FUNC_ARY_ITEM(longjmp);
  
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_printdir);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_print);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_get_tick);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_mktime);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_localtime);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_gmtime);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_strftime);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_mem_alloc);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_mem_realloc);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_mem_free);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_autodog);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_assert_okts);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_negate_okts);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_get_usb_mode);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_set_portmode);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_get_portmode);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_os_time);
  
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_set_evt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_wait_evt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_peek_evt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_clear_evts);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_get_evt_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_set_evt_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_set_evt_owner_thread_idx);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_get_evt_owner_thread_idx);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_set_evt_as_ignored);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_is_evt_ignored);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_delete_spec_evt_with_params_from_queue);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_get_evt_count_in_queue);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_filter_add);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_evt_filter_delete);
  
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_set_current_thread_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_set_thread_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_get_current_thread_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_get_thread_priority);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_enter_crit_sect);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_leave_crit_sect);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_thread_sleep);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_create_thread);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_kill_thread);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_resume_thread);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_suspend_thread);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_thread_running);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_thread_suspended);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_thread_get_current_index);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_thread_register_prekill_func);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_signal_clean);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_signal_notify);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_signal_wait);
  
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_starttimer);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_stoptimer);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_stopalltimer_for_thread);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_stopalltimer);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sio_send);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sio_recv);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sio_exclrpt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sio_enable_recv);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sio_clear);
  //efs
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_creat);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_open);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_close);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_read);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_write);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_ftruncate);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_lseek);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_stat);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_fstat);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_lstat);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_tell);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_get_opened_filesize);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_file_exist);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_dir_exist);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_delete_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_rmdir);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_mkdir);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_get_filesize);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_truncate_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_lsdir);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_efs_lsfile);
  //ftp
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ftp_simpput);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ftp_simpget);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ftp_simplist);
  //mms
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_accquire_module);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_release_module);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_set_mmsc);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_get_mmsc);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_set_protocol);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_get_protocol);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_set_edit);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_set_title);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_get_title);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_attach_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_attach_file_from_memory);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_add_receipt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_delete_receipt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_list_receipts);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_save_attachment);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_save);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_load);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_get_attach_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_list_attach_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_get_delivery_date_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_read_attachment);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_send);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_mms_recv);
  //sms
#ifdef EBDAT_FEAT_SMS
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_get_cmgf);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_set_cmgf);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_get_cscs);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_set_cscs);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_get_next_msg_ref);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_convert_chset);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_send_smstxt_msg);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_write_smstxt_msg);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_decode_pdu_sms);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_cmss);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sms_read_msg);
#endif /* EBDAT_FEAT_SMS */
  //smtp
#ifdef FEATURE_ATCOP_TRECK_SMTP
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_config);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_from);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_rcpt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_subject);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_body_charset);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_body);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_set_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_smtp_send);
#endif /* FEATURE_ATCOP_TRECK_SMTP */
  //network
#ifdef EBDAT_FEAT_NETWORK
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_network_get_creg);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_network_get_cgreg);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_network_get_cnsmod);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_network_get_csq);
#endif /* EBDAT_FEAT_NETWORK */
  //atctl
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_atctl_send);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_atctl_recv);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_atctl_setport);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_atctl_clear);
  //gps
#ifdef EBDAT_FEAT_GPS
#ifdef FEATURE_ATCOP_GPS
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_start);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_stop);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_get_fix_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_get_nmea_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_set_mode);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_get_mode);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gps_delete_info);
#endif /* FEATURE_ATCOP_GPS */
#endif /* EBDAT_FEAT_GPS */
  //gpio
#ifdef EBDAT_FEAT_GPIO
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_config);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_out);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_get);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_func_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_isr_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_gpio_debounce_set);
#endif /* EBDAT_FEAT_GPIO */
  //spi
#ifdef EBDAT_FEAT_SPI
#ifdef FEATURE_SUPPORT_SPI
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_set_clk_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_set_cs);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_set_frequency);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_set_param);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_write_data);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_write_uint32_data);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_write_reg);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_spi_read_reg);
#endif /* FEATURE_SUPPORT_SPI */
#endif /* EBDAT_FEAT_SPI */
  //hd
#ifdef EBDAT_FEAT_HD
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_adc_read);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_vaux_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_vaux_get);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_vaux_switch);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_vaux_get_state);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_i2c_read);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_i2c_combined_write_read);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_i2c_write);
#endif /* EBDAT_FEAT_HD */
  //pm
#ifdef EBDAT_FEAT_PM
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_auto_pwr_off_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_auto_pwr_off_get);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_enable_low_voltage_alarm);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_disable_low_voltage_alarm);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_enable_auto_pwr_on);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_disable_auto_pwr_on);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_enable_auto_pwr_off);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_disable_auto_pwr_off);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_power_off);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_pm_power_reset);
#endif /* EBDAT_FEAT_PM */

  //audio
#ifdef EBDAT_FEAT_AUDIO
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_mic_gain_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_sidetone_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_auido_tx_gain_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_rx_gain_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_tx_vol_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_rx_vol_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_tx_ftr_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_rx_ftr_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_echo_mode_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_noise_mode_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_echo_param_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_volumn_level_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_volumn_level_select);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_device_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_device_mute);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_pcm_set);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_audio_play_tone);
#endif /* EBDAT_FEAT_AUDIO */
  //socket
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ps_open_ps_network);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ps_close_ps_network);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_ps_release_ps_netlib);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_async_deselect);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_async_select);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_create);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_connect);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_recv);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_send);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_recvfrom);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_sendto);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_close);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_bind);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_listen);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_accept);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_setsockopt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_getsockopt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sock_get_sock_name);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_dns_get_host_entry);
  //math
  LOAD_EBDAT_FUNC_ARY_ITEM(srand);
  LOAD_EBDAT_FUNC_ARY_ITEM(rand);
  LOAD_EBDAT_FUNC_ARY_ITEM(qsort);
  LOAD_EBDAT_FUNC_ARY_ITEM(atof);
  LOAD_EBDAT_FUNC_ARY_ITEM(fabs);
  LOAD_EBDAT_FUNC_ARY_ITEM(sin);
  LOAD_EBDAT_FUNC_ARY_ITEM(sinh);
  LOAD_EBDAT_FUNC_ARY_ITEM(cos);
  LOAD_EBDAT_FUNC_ARY_ITEM(cosh);
  LOAD_EBDAT_FUNC_ARY_ITEM(tan);
  LOAD_EBDAT_FUNC_ARY_ITEM(tanh);
  LOAD_EBDAT_FUNC_ARY_ITEM(asin);
  LOAD_EBDAT_FUNC_ARY_ITEM(acos);
  LOAD_EBDAT_FUNC_ARY_ITEM(atan);
  LOAD_EBDAT_FUNC_ARY_ITEM(atan2);
  LOAD_EBDAT_FUNC_ARY_ITEM(ceil);
  LOAD_EBDAT_FUNC_ARY_ITEM(floor);
  LOAD_EBDAT_FUNC_ARY_ITEM(fmod);
  LOAD_EBDAT_FUNC_ARY_ITEM(modf);
  LOAD_EBDAT_FUNC_ARY_ITEM(sqrt);
  LOAD_EBDAT_FUNC_ARY_ITEM(log);
  LOAD_EBDAT_FUNC_ARY_ITEM(log10);
  LOAD_EBDAT_FUNC_ARY_ITEM(exp);
  LOAD_EBDAT_FUNC_ARY_ITEM(frexp);
  LOAD_EBDAT_FUNC_ARY_ITEM(ldexp);
  LOAD_EBDAT_FUNC_ARY_ITEM(bsearch);
  //hash
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_md5_Init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_md5_update);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_md5_final);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha1_init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha1_update);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha1_final);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha256_init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha256_update);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha256_final);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha384_init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha384_update);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha384_final);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha512_init);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha512_update);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_sha512_final);
  //minizip
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_minizip_openzip);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_minizip_add_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_minizip_closezip);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_openzip);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_closezip);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_get_entry_count);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_get_current_file_info);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_goto_next_file);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_miniunz_extract_currentfile);
  //lua
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_lua_register_api_handler);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_lua_deregister_api_handler);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_lua_set_evt);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_lua_signal_notify);
  LOAD_EBDAT_FUNC_ARY_ITEM(ebdat_lua_set_ready);
  return TRUE;
}

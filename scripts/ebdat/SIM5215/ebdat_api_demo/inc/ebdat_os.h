/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
06/15/12  sj     Create Module
*/
#ifndef __EBDAT_OS_H__
#define __EBDAT_OS_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
typedef enum 
{
  USB_BUS_MODE_SUSPENDED,
  USB_BUS_MODE_RESUMED,
  USB_BUS_MODE_UNCONFIGURED,
  USB_BUS_MODE_CONFIGURED,
  USB_BUS_MODE_DISCONNECTED,
  USB_BUS_MODE_CONNECTED,
  USB_API_FEATURE_NOT_SUPPORTED=255//no suupport this USB query, on CDMA platform, it not supported yet
} ebdat_usb_bus_mode_enum;

void ebdat_os_printdir(boolean enable_print);
void ebdat_os_print(const byte* msg, uint32 msg_len);
/*time operation*/
uint64 ebdat_os_get_tick(void);
time_t ebdat_os_mktime(struct tm *pt);
struct tm *ebdat_os_localtime(time_t *timer);
struct tm *ebdat_os_gmtime(time_t *timer);
time_t ebdat_os_time(time_t * timer);
size_t ebdat_os_strftime(char *s, size_t _maxsize, const char *fmt, struct tm *pt);
/*memory operation*/
void* ebdat_os_mem_alloc(uint32 size);
void* ebdat_os_mem_realloc(void* buffer_p, uint32 size);
void ebdat_os_mem_free(void* buffer_p);
void ebdat_os_autodog(boolean autodog);
void ebdat_os_assert_okts(void);//allow module to sleep
void ebdat_os_negate_okts(void);//not allow module to sleep
ebdat_usb_bus_mode_enum ebdat_os_get_usb_mode(void);
boolean ebdat_os_set_portmode(uint32 mode);
uint32 ebdat_os_get_portmode(void);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_OS_H__ */

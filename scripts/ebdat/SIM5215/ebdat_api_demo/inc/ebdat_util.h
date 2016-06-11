/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
06/14/12  sj     Create Module
*/
#include "comdef.h"
#include "customer.h"
#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#ifndef __EBDATUTIL_H__
#define __EBDATUTIL_H__

#ifdef FEATURE_ETSI_PBM
#include "err.h"
#include "clk.h"

#ifdef FEATURE_PM1000
#error code not present
#elif defined (FEATURE_PMIC_RTC)
#include "clkrtc.h"
#endif
#endif /* FEATURE_ETSI_PBM */

#if defined(FEATURE_SEC_TIME) && !defined(FEATURE_SEC_PROCESS_INIT)
  #include "sectime.h"                  /* Secure time header file */
#endif /* FEATURE_SEC_TIME && !FEATURE_SEC_PROCESS_INIT */

#include "time.h"
#include "nv.h"
#include "clk.h"
#include "rex.h"
#include "task.h"
#include "sys.h"
#include "assert.h"
#include "msg.h"
#include "qw.h"
#include "memheap.h"
#include "tmc.h"

#include "ebdat_task.h"

#define  UPCASE( c ) ( ((c) >= 'a' && (c) <= 'z') ? ((c) - 0x20) : (c) )

#define ebdat_mem_realloc(size,buffer_p) {buffer_p = mem_realloc(&tmc_heap, buffer_p, size); }  
#define ebdat_mem_zeroalloc(size,buffer_p){         \
        buffer_p = mem_malloc(&tmc_heap, size); \
        if (buffer_p) \
          memset(buffer_p,0,size);}
#define ebdat_mem_free(buffer_p) {if(buffer_p!=NULL) mem_free(&tmc_heap, buffer_p);buffer_p=NULL;}
#define ebdat_mem_alloc(size,buffer_p){buffer_p = mem_malloc(&tmc_heap, size);}

void ebdat_timer_cb( unsigned long param);
#define EBDAT_TIMER_CREATE(timer, cb_param) rex_def_timer_ex(timer, ebdat_timer_cb, (unsigned long)cb_param)
#define EBDAT_TIMER_START(timer, timeout_value)    rex_set_timer(timer, timeout_value)
#define EBDAT_TIMER_STOP(timer)                  do{  \
                                                     if (rex_get_timer(timer))   \
                                                         rex_clr_timer(timer);   \
                                                  } while (0)

nv_stat_enum_type ebdatutil_get_nv_item
(
  nv_items_enum_type  item,           /* Which item */
  nv_item_type       *data_ptr        /* Pointer to space for item */
);
nv_stat_enum_type ebdatutil_put_nv_item
(
  nv_items_enum_type  item,           /* Which item */
  nv_item_type       *data_ptr        /* Pointer to space for item */
);
boolean ebdatutil_get_real_time_clock
(
  clk_julian_type* rt_clk_p
);
boolean ebdatutil_set_real_time_clock
(
  clk_julian_type* rt_clk_p 
);
boolean ebdatutil_get_timezone
(
  int* timezone_p
);
boolean ebdatutil_set_timezone
(
  int time_zone
);
uint64 ebdatutil_gettick(void);
time_t ebdatutil_mktime(struct tm *pt);
size_t ebdatutil_strftime(char *s, size_t _maxsize, const char *fmt, struct tm *pt);
time_t ebdatutil_time(time_t * timer);
struct tm *ebdatutil_gmtime(time_t * timer);
struct tm *ebdatutil_localtime(time_t * timer);
boolean ebdat_util_win_to_efs_path(const char* win_path, char* efs_path, unsigned long efs_path_size, boolean remove_root_dir);
boolean ebdat_util_send_atcmd(byte* buf, int len);
#endif /* __EBDATUTIL_H__ */
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */


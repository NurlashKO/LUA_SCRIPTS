/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
06/14/12  sj     Create Module
*/
#include "comdef.h"
#include "customer.h"
#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#ifndef __EBDAT_THREAD_H__
#define __EBDAT_THREAD_H__
#include "rex.h"
#include "task.h"
#include "ebdat_evt.h"
#include "ebdat_thread_def.h"

typedef struct ebdat_thread_param_struct{
  rex_task_func_type cust_thread_entry;
  unsigned long        param;
  uint8                   thread_index;
}ebdat_thread_param_s_type;

typedef struct {
   rex_tcb_type     *tcb_ptr;
   void             *stack_ptr;
   ebdat_evt_queue_s_type evt_queue;
   boolean is_wait_event_sync;
   rex_timer_type  wait_timer;
   ebdat_thread_param_s_type param;
} ebdat_thread_tcb_type;


typedef  rex_crit_sect_type ebdat_thread_crit_sect_type;

extern ebdat_thread_tcb_type  ebdat_thread_tcbs[];
extern rex_crit_sect_type ebdat_thread_cs;

#endif /* __EBDAT_THREAD_H__ */
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
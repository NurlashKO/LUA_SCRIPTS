#ifndef __EBDAT_EVT_DEF_H__
#define __EBDAT_EVT_DEF_H__

/*===========================================================================

                      EDIT HISTORY FOR FILE BY SIMCOM
                      
when         who     what, where, why
--------   ---     ----------------------------------------------------------  
05/14/13   sj      Modify bug MKBUG00002927 to support event filter
06/14/12   sj    Create Module
===========================================================================*/

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#include "ebdat_lua_common.h"

#define EBDAT_EVT_ID_TYPE EVT_ID_TYPE
#define EBDAT_EVT_PARAM_TYPE EVT_PARAM_TYPE

#define MAX_EBDAT_EVT_COUNT   40
#define MAX_EBDAT_EVT_OCCURED_COUNT (MAX_EBDAT_EVT_COUNT*2)

typedef struct ebdat_evt_info_tag
{
   EBDAT_EVT_ID_TYPE evt_id;
   double evt_clockinfo;
   EBDAT_EVT_PARAM_TYPE evt_param1;
   EBDAT_EVT_PARAM_TYPE evt_param2;
   EBDAT_EVT_PARAM_TYPE evt_param3;   
   int filter_index;
   int filter_set_times;
}ebdat_evt_info_s_type;

void ebdat_set_evt(EBDAT_EVT_ID_TYPE evt_id, EBDAT_EVT_PARAM_TYPE evt_p1, EBDAT_EVT_PARAM_TYPE evt_p2, EBDAT_EVT_PARAM_TYPE evt_p3, double evt_clock, int thread_index);
boolean ebdat_wait_evt(ebdat_evt_info_s_type* evt_p, uint32 timeout);
boolean ebdat_peek_evt(int evt_id);
void ebdat_clear_evts(void);
boolean ebdat_peek_evt(int evt_id);
int ebdat_get_evt_count_in_queue(EBDAT_EVT_ID_TYPE* evt_id_p, EBDAT_EVT_PARAM_TYPE* evt_p1_p, EBDAT_EVT_PARAM_TYPE* evt_p2_p, EBDAT_EVT_PARAM_TYPE* evt_p3_p);
void ebdat_delete_spec_evt_with_params_from_queue(int delete_count, EBDAT_EVT_ID_TYPE evt_id, EBDAT_EVT_PARAM_TYPE* evt_p1_p, EBDAT_EVT_PARAM_TYPE* evt_p2_p, EBDAT_EVT_PARAM_TYPE* evt_p3_p);
int ebdat_evt_filter_add(EVT_ID_TYPE evt_id, EVT_PARAM_TYPE* evt_p1_p, EVT_PARAM_TYPE* evt_p2_p, EVT_PARAM_TYPE* evt_p3_p, int max_count_in_queue, boolean should_repalce_oldest);
boolean ebdat_evt_filter_delete(int filter_index);
int ebdat_evt_get_evt_priority(int evt);
void ebdat_evt_set_evt_priority(int evt, int priority);
void ebdat_evt_set_evt_owner_thread_idx(int evt, int thread_index);
int ebdat_evt_get_evt_owner_thread_idx(int evt);
void ebdat_evt_set_evt_as_ignored(int evt, boolean discarded);
boolean ebdat_evt_is_evt_ignored(int evt);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_EVT_DEF_H__ */

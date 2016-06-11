#ifndef __EBDAT_EVT_H__
#define __EBDAT_EVT_H__

/*===========================================================================

                      EDIT HISTORY FOR FILE BY SIMCOM
                      
when         who     what, where, why
--------   ---     ----------------------------------------------------------  
05/14/13   sj    Modify bug MKBUG00002927 to support event filter
06/14/12   sj    Create Module
===========================================================================*/

#include "comdef.h"
#include "customer.h"
#include "rex.h"
#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#include "ebdat_evt_def.h"

typedef struct evt_filter_params_s_tag
{
  boolean filter_param1;
  boolean filter_param2;
  boolean filter_param3;
  int max_evt_in_queue;
  int count_in_queue;
  boolean replace_oldest;
  EVT_ID_TYPE evt_id;
  EVT_PARAM_TYPE param1;
  EVT_PARAM_TYPE param2;
  EVT_PARAM_TYPE param3;
  boolean used;
  uint64 set_times;
}evt_filter_params_s_type;

#define MAX_EBDAT_EVT_FILTERS 10
#define EVT_FILTER_MASK(evt_id) (((uint64)1) << evt_id)
typedef struct ebdat_evt_filters_s_tag
{
  evt_filter_params_s_type filter[MAX_EBDAT_EVT_FILTERS];
  uint64 filter_evt_mask;
  int filter_count;
  rex_crit_sect_type filter_cs;
}ebdat_evt_filters_s_type;

typedef struct ebdat_evt_queue_s_tag
{
  ebdat_evt_filters_s_type filter;
  ebdat_evt_info_s_type evt_array[MAX_EBDAT_EVT_OCCURED_COUNT];
  int each_evt_count[MAX_EBDAT_EVT_COUNT];//count for each event
  rex_crit_sect_type event_cs;
  int count_in_queue;
}ebdat_evt_queue_s_type;

extern boolean ebdattask_is_running; /* lua script is running now?*/
extern boolean ebdat_add_imediate_event(EBDAT_EVT_ID_TYPE evt, EBDAT_EVT_PARAM_TYPE param1, EBDAT_EVT_PARAM_TYPE param2, EBDAT_EVT_PARAM_TYPE param3, int8 thread_index);
extern boolean ebdat_add_delayed_event(EBDAT_EVT_ID_TYPE evt, EBDAT_EVT_PARAM_TYPE param1, EBDAT_EVT_PARAM_TYPE param2, EBDAT_EVT_PARAM_TYPE param3, int8 thread_index);
extern boolean ebdat_evt_limit_evt_count_in_queue(ebdat_evt_queue_s_type* evt_queue_p, EBDAT_EVT_ID_TYPE evt_id, int max_count);
extern void ebdat_evt_clear_evts_in_queue(ebdat_evt_queue_s_type* evt_queue_p);
extern boolean ebdat_evt_get_first_evt_in_queue(ebdat_evt_queue_s_type* evt_queue_p, ebdat_evt_info_s_type* evt_p);
extern void ebdat_evt_delete_spec_evt_from_queue(ebdat_evt_queue_s_type* evt_queue_p, EBDAT_EVT_ID_TYPE evt);
extern boolean ebdat_insert_evt_to_queue(ebdat_evt_queue_s_type* evt_queue_p, EBDAT_EVT_ID_TYPE evt, EBDAT_EVT_PARAM_TYPE param, EBDAT_EVT_PARAM_TYPE param2, EBDAT_EVT_PARAM_TYPE param3, double clockinfo);
extern void ebdat_evt_meta_init_once(void);
extern void ebdat_evt_queue_init_once(ebdat_evt_queue_s_type* evt_queue_p);
int ebdat_add_evt_filter(ebdat_evt_filters_s_type* filter_p, EVT_ID_TYPE evt_id, EVT_PARAM_TYPE* evt_p1_p, EVT_PARAM_TYPE* evt_p2_p, EVT_PARAM_TYPE* evt_p3_p, int max_count_in_queue, boolean should_repalce_oldest);
boolean ebdat_del_evt_filter(ebdat_evt_filters_s_type* filter_p, int filter_index);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */

#endif /* __LEVTDEF_H__ */
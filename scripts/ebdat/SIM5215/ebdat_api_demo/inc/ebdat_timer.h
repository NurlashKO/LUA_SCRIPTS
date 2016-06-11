/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
06/15/12  sj     Create Module
*/
#ifndef __EBDAT_TIMER_H__
#define __EBDAT_TIMER_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
boolean ebdat_starttimer(uint8 timer_id, uint32 time_out, boolean periodic);
void ebdat_stoptimer(uint8 timer_id);
void ebdat_stopalltimer_for_thread(int thread_index);
void ebdat_stopalltimer(void);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_TIMER_H__ */

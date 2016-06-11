/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
09/12/13  sj      Modify bug MKBUG00003983 to extend the signal count for ebdat_signal_xxx
12/12/12  sj      Modify bug MKBUG00002189 to let ebdat_signal_* functions support maximum 3 signals
12/10/12  sj      Modify bug MKBUG00002223 to add ebdat_signal_* functions
06/14/12  sj     Create Module
*/
#ifndef __EBDAT_THREAD__DEF_H__
#define __EBDAT_THREAD__DEF_H__

#include "ebdat_types.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT

#define MAX_EBDAT_THREAD	10 + 1  /*the size of our qvp_tcbs array*/
#define EBDAT_THREAD_PRIORITY_LOW 1
#define EBDAT_THREAD_PRIORITY_MID 2
#define EBDAT_THREAD_PRIORITY_HIGH 3

#define MAX_EBDAT_CRIT_SECT  12

#define EBDAT_SIG_1 0x1
#define EBDAT_SIG_2 0X2
#define EBDAT_SIG_3 0X4
#define EBDAT_SIG_4 0X8
#define EBDAT_SIG_5 0X10
#define EBDAT_SIG_6 0X20
#define EBDAT_SIG_7 0X40
#define EBDAT_SIG_8 0X80

extern boolean ebdat_set_current_thread_priority(int priority);
extern boolean ebdat_set_thread_priority(int thread_index, int priority);
extern int ebdat_get_current_thread_priority(void);
extern int ebdat_get_thread_priority(int thread_index);
extern void ebdat_enter_crit_sect(uint8 cs_no);
extern void ebdat_leave_crit_sect(uint8 cs_no);
extern void ebdat_signal_clean(uint8 sig_mask);
extern void ebdat_signal_notify(int thread_index, uint8 sig_mask);
extern uint8 ebdat_signal_wait(uint8 sig_mask, uint32 timeout);
extern void ebdat_thread_sleep(uint32 ms);

typedef void (*ebdat_thread_func_type)( unsigned long );
extern int ebdat_create_thread(
	unsigned int stack_size, 
	unsigned int priority,
	ebdat_thread_func_type thread_entry,
	unsigned int param,
	char* thread_name,
	boolean suspend
);
extern boolean ebdat_kill_thread(unsigned char thread_index);
extern void ebdat_resume_thread(unsigned char thread_index);
void ebdat_suspend_thread(unsigned char thread_index);
extern boolean ebdat_thread_running(int thread_index);
extern boolean ebdat_thread_suspended(int thread_index);
extern int ebdat_thread_get_current_index(void);

typedef void(*ebdat_thread_prekill_func_cb)(int thread_index);
void ebdat_thread_register_prekill_func(ebdat_thread_prekill_func_cb cb);
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */
#endif /* __EBDAT_THREAD__DEF_H__ */

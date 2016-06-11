#ifndef __EBDAT_TASK_H__
#define __EBDAT_TASK_H__
/*==========================================================================   
  *                                                                                                                  
  * Copyright (c) 2012 SIMCOM Corporation.  All Rights Reserved.                     
  *                                                                                                               
  *----------------------------------------------------------------------------------------
  *
  * PROJECT             SIM5215
  *
  * LANGUAGE          ANSI C
  *
  * SUBSYSTEM        EMBEDDED AT
  *
  * DESCRIPTION     
  *          embed at task header file                 
  *
  *---------------------------------------------------------------------------------------
  *
  * HOSTORY
  * 
  *       when            who            what, where, why     
  * 2013/09/12     sj              Modify bug MKBUG00003983 to extend the signal count for ebdat_signal_xxx
  * 2012/12/12     sj              Modify bug MKBUG00002189 to let ebdat_signal_* functions support maximum 3 signals
  * 2012/10/12     sj              Modify bug MKBUG00002223 to add ebdat_signal_* functions
  * 2012/11/29     sj              Modify bug MKBUG00002153 to support function array.
  * 2012/05/30     aaron        initial version
  *
  *========================================================================*/

/*-------------------------------------------------------------------------------------*/
/*        INCLUDE FILE                                                                                              */
/*-------------------------------------------------------------------------------------*/
#include "comdef.h"
#include "customer.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#include "cmd.h"
#include "boot_shared_seg.h"

#define EBDATTASK_NUM_CMD_BUFS 100
/*--------------------------------------------------------------------------
                             Signal Masks
--------------------------------------------------------------------------*/
#define  EBDATTASK_RPT_TIMER_SIG      0x0001
#define  EBDATTASK_CMD_Q_SIG          0x0002

#define EBDATTASK_NV_CMD_SIG           0x0004   /* NV item retrieval signal       */

#define EBDATTASK_SYNC_RESULT_CMD_SIG           0x0008   
  /* This signal is set when command is completed by LUA Task. */

#define EBDATTASK_TIMER_CMD_SIG           0x0010  

#define EBDATTASK_NEW_EVENT_CMD_SIG           0x0020   

#define EBDATTASK_DELAYED_EVENT_ADD_CMD_SIG           0x0040 

#define EBDATTASK_LAUNCH_CUSTOMER_APP_SIG           0x0080 

#define EBDATTASK_CUSTOMER_SIG             0x100 
#define EBDATTASK_CUSTOMER_SIG2           0x200 
#define EBDATTASK_CUSTOMER_SIG3           0x400 
#define EBDATTASK_CUSTOMER_SIG4           0x800 
#define EBDATTASK_CUSTOMER_SIG5           0x1000 
#define EBDATTASK_CUSTOMER_SIG6           0x2000 
#define EBDATTASK_CUSTOMER_SIG7           0x4000 
#define EBDATTASK_CUSTOMER_SIG8           0x8000 

/*--------------------------------------------------------------------------
                                 MACROS
--------------------------------------------------------------------------*/

/* Kick the watchdog */
#define  EBDATTASK_DOG_RPT() \
  dog_report(DOG_EBDATTASK_RPT); \
  (void) rex_set_timer ( &ebdattask_rpt_timer, DOG_EBDATTASK_RPT_TIME )

/* Kick the watchdog */
#define  EBDATTASK2_DOG_RPT() \
  dog_report(DOG_EBDATTASK2_RPT); \
  (void) rex_set_timer ( &ebdattask2_rpt_timer, DOG_EBDATTASK_RPT_TIME )


typedef enum
{
  EBDAT2_MIN_CMD = -1,  
  EBDAT2_ADD_DELAYED_EVT_CMD = 0,/* wap push url*/
  EBDAT2_CLEAN_THREAD_CMD = 1,/* clear thread*/
  EBDAT2_MAX_CMDS
}ebdattask2_cmd_name_type;

typedef enum
{
  EBDATTASK2_CMD_ERR_NONE       = 0,
  EBDATTASK2_CMD_FAILED_ADD_DELAYED_EVENT
}ebdattask2_cmd_err_e_type;

typedef void (* ebdattask2_cmd_cb_type )
(
  ebdattask2_cmd_name_type        cmd,
    /* which command's status being reported
    */
  void                                 *user_data,
  ebdattask2_cmd_err_e_type       cmd_err
    /* the status of the command
    */
);

/* The common Header for all the commands */
typedef struct {
  cmd_hdr_type          cmd_hdr;        /* command header */
  ebdattask2_cmd_name_type  command;        /* The command */
  void                  *user_data;     /* User data */
  void  (*cmd_cb)( ebdattask2_cmd_cb_type cmd_id, void *user_data, ebdattask2_cmd_err_e_type err);
                                        /* Pointer to Function to send report */
} ebdattask2_hdr_type;

typedef struct
{
  int evt;
  int evt_p1;
  int evt_p2;
  int evt_p3;
  double evt_clock;
  rex_tcb_type* thread_rex_tcb_ptr;
  int thread_idx;
} ebdattask2_cmd_add_delayed_evt_type;

typedef struct
{
  int thread_index;
  void* handle;
} ebdattask2_cmd_clear_thread_type;

typedef struct {
  ebdattask2_hdr_type          hdr;            /* Generic header */
  union
  {
    /* Configuration group commands
    */
    ebdattask2_cmd_add_delayed_evt_type       add_delayed_evt;
    ebdattask2_cmd_clear_thread_type clear_thread;
  } cmd;
} ebdattask2_cmd_type;


/* Status:
*/
typedef enum
{
  EBDATTASK_OK_S                  = 0,
  EBDATTASK_ERROR_S,  
}ebdattask_status_e_type;

typedef void (*ebdat_entry_ptr_type)(uint32 param, void** func_ary, uint32 func_count);

#ifdef FEATURE_SHARED_SEGMENT

typedef struct 
{
	BOOT_SHARED_SEG_HEADER
	uint32 ret_error;
	ebdat_entry_ptr_type ebdat_entry_ptr;
}ebdat_shared_info;

#endif 
/*============================================================================

  FUNCTION          :  EBDATTASK_INIT
                       
  DESCRIPTION       :  This procedure initializes the queues and timers for 
                       EBDAT Task. It should be called only once, at powerup time.
                       
  PARAMETERS        :  None
                       
  DEPENDENCIES      :  None
                       
  RETURN VALUE      :  None
                       
  SIDE EFFECTS      :  None
                       
============================================================================*/

void ebdattask_init
(
   void
);

/*============================================================================

  FUNCTION          :  EBDAT_TASK
                       
  DESCRIPTION       :  This procedure is the entry point for the EBDAT Task
                                              
  PARAMETERS        :  dummy - Parameter required for REX. Not used
                       
  DEPENDENCIES      :  None
                       
  RETURN VALUE      :  Does not return
                       
  SIDE EFFECTS      :  None
                       
============================================================================*/

void ebdat_task
(
  dword dummy
    /* Parameter required for REX.  Tell lint to ignore it. */
    /*lint -esym(715,dummy) */
);

void ebdattask2_init
(
   void
);

/*============================================================================

  FUNCTION          :  EBDAT_TASK2
                       
  DESCRIPTION       :  This procedure is the entry point for the EBDAT Task
                                              
  PARAMETERS        :  dummy - Parameter required for REX. Not used
                       
  DEPENDENCIES      :  None
                       
  RETURN VALUE      :  Does not return
                       
  SIDE EFFECTS      :  None
                       
============================================================================*/

void ebdat_task2
(
  dword dummy
    /* Parameter required for REX.  Tell lint to ignore it. */
    /*lint -esym(715,dummy) */
);

#endif   /*FEATURE_SIMCOM_EMBEDDED_AT*/

#endif  /*__EBDAT_TASK_H__*/


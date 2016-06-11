
#define __EBDAT_ENTRY_C__
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
  *          embeded at demo source file                
  *
  *---------------------------------------------------------------------------------------
  *
  * HOSTORY
  * 
  *       when            who            what, where, why     
  * 
  * 2012/11/29     sj           Add function pointer support
  * 2012/05/30     aaron        initial version
  *
  *========================================================================*/

/*-------------------------------------------------------------------------------------*/
/*        INCLUDE FILE                                                                                               */
/*-------------------------------------------------------------------------------------*/
#ifndef __ARMCC_VERSION
#define __ARMCC_VERSION 1200
#endif

#include ".\inc\cust_header.h"

/*-------------------------------------------------------------------------------------*/
/*        MACRO                                                                                                     */
/*-------------------------------------------------------------------------------------*/
#define EBDAT_MAX_PRINT_BUFFER_LEN     (256)
#define EBDAT_TEST_DATA_REGION_LEN     (10 * 1024)
#define EBDAT_MAX_GPS_TEST_LEN     (1024)


/*-------------------------------------------------------------------------------------*/
/*        TYPES                                                                                                     */
/*-------------------------------------------------------------------------------------*/


#define USE_FUNC_POINTER//Use function pointer which may support firmware update without recompiling the customer EBDAT application source code.

#ifdef USE_FUNC_POINTER
#define EBFUNC(name) f_##name
#else
#define EBFUNC(name) name
#endif

/*-------------------------------------------------------------------------------------*/
/*        LOCAL VARIABLE                                                                                       */
/*-------------------------------------------------------------------------------------*/
static char print_buf[EBDAT_MAX_PRINT_BUFFER_LEN] = {0};


/*-------------------------------------------------------------------------------------*/
/*        FUNCTION DEFINITION                                                                             */
/*-------------------------------------------------------------------------------------*/

/*=== test function ===*/

void ebdat_print_string(char* str)
{
	  EBFUNC(ebdat_os_print)((byte*)str, EBFUNC(strlen)(str));
}

void ebdat_thread_print(char* msg, uint32 msg_len)
{
	  EBFUNC(ebdat_enter_crit_sect)(0);
	  EBFUNC(ebdat_os_print)((byte*)msg, msg_len);
	  EBFUNC(ebdat_leave_crit_sect)(0);
}

void ebdat_thread_print_string(char* msg)
{
	  EBFUNC(ebdat_enter_crit_sect)(0);
	  ebdat_print_string(msg);
	  EBFUNC(ebdat_leave_crit_sect)(0);
}

int ebdat_lua_api_0_handler(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p)
{
	ebdat_thread_print_string("ebdat_lua_api_0_handler\r\n");
	if (!in_param_p)
	{
		return EBDAT_LUA_ERROR_WRONG_PARAM;
  }
  ebdat_thread_print((char*)in_param_p->str_param1, in_param_p->str_param1_len);
  return EBDAT_LUA_ERROR_NONE;
}

ebdat_lua_api_handler_func_type g_sub_func_api0_array[10] = {0};

boolean ebdat_lua_register_api1_sub_func_handler(uint32 sub_api_no, ebdat_lua_api_handler_func_type func)
{
	if (sub_api_no >= 10)
	{
		  return FALSE;
  }
  g_sub_func_api0_array[sub_api_no] = func;
  return TRUE;
}

int ebdat_lua_api_1_0_handler(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p)
{
	ebdat_thread_print_string("ebdat_lua_api_1_0_handler\r\n");
	if (!in_param_p)
	{
		return EBDAT_LUA_ERROR_WRONG_PARAM;
  }
  ebdat_thread_print((char*)in_param_p->str_param1, in_param_p->str_param1_len);
  return EBDAT_LUA_ERROR_NONE;
}

int ebdat_lua_api_1_1_handler(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p)
{
	ebdat_thread_print_string("ebdat_lua_api_1_1_handler\r\n");
	if (!in_param_p)
	{
		return EBDAT_LUA_ERROR_WRONG_PARAM;
  }
  ebdat_thread_print((char*)in_param_p->str_param1, in_param_p->str_param1_len);
  return EBDAT_LUA_ERROR_NONE;
}


int ebdat_lua_api_1_handler(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p)
{
	ebdat_thread_print_string("ebdat_lua_api_1_handler\r\n");
	if (!in_param_p)
	{
		return EBDAT_LUA_ERROR_WRONG_PARAM;
  }
  if (in_param_p->sub_api_no >= 10)
  {
  	return EBDAT_LUA_ERROR_NO_API;
  }
  if (!g_sub_func_api0_array[in_param_p->sub_api_no])
  {
  	return EBDAT_LUA_ERROR_NO_API;
  }
  return g_sub_func_api0_array[in_param_p->sub_api_no](in_param_p, out_param_p);
}

static char* my_test_str2 = "test my static return string2";
int ebdat_lua_api_2_handler(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p)
{
	ebdat_thread_print_string("ebdat_lua_api_2_handler\r\n");
	if (!in_param_p)
	{
		return EBDAT_LUA_ERROR_WRONG_PARAM;
  }
  if (out_param_p)
  {
  	byte* buffer_p = EBFUNC(ebdat_os_mem_alloc)(60);
  	if (buffer_p)
  	{
  	  EBFUNC(strcpy)((char*)buffer_p, "Test my return string use ebdat_os_mem_alloc");
  	  out_param_p->str_param1 = (byte*)buffer_p;
  	  out_param_p->str_param1_len = EBFUNC(strlen)((char*)buffer_p);
  	  out_param_p->str_param1_need_free = TRUE;//VERY important
  	  
  	  out_param_p->str_param2 = (byte*)my_test_str2;
  	  out_param_p->str_param2_len = EBFUNC(strlen)((char*)my_test_str2);
  	  out_param_p->str_param2_need_free = FALSE;//VERY important
    }
  }
  return EBDAT_LUA_ERROR_NONE;
}


extern boolean ebdat_func_load_ary(void** func_ary, uint32 func_count);
#pragma arm section code = "ebdat_entry"
/*
  * the entry function must running at address :0x3700000
  */

/***************************************************************************************
  *
  * FUNCTION:   ebdat_customer_entry
  * 
  * DESCRIPTION: This function is the entry function for embeded at demo system
  * AT+CEBDATSTART=<param>
  * AT+CEBDATSTART
  *
  * AT+CEBDATAUTORUN=<0|1> is used to control whether the customer application can be launched when UE power on.
  * 
  * AT+CEBDATPRINTDIR=<0|1> is used to set the value instead of using ebdat_os_printdir, which is only used for trace purpose.
  * PARAMETER:
  *
  * DEPENDENCIES:
  *
  * SIDE EFFECTS:
  *
  ***************************************************************************************/
  
void ebdat_customer_entry(uint32 param, void** func_ary, uint32 func_count)//for autorun, the param is 0. for AT+CEBDATSTART\r\n, the param is also 0
{
	ebdat_func_load_ary(func_ary, func_count);
	EBFUNC(ebdat_os_printdir)(TRUE);
	
#ifdef USE_FUNC_POINTER
  ebdat_print_string("begin ebdat_customer_entry with func_pointer supported\r\n");
#else
  ebdat_print_string("begin ebdat_customer_entry without func_pointer supported\r\n");
#endif /* USE_FUNC_POINTER */

  if (!EBFUNC(ebdat_lua_register_api_handler))
  {
  	ebdat_print_string("ERROR! The firmware doesn't support EBDAT for LUA API module\r\n");
  	return;
  }
  
  EBFUNC(ebdat_lua_register_api_handler)(0, ebdat_lua_api_0_handler);
  //test sub-func
  ebdat_lua_register_api1_sub_func_handler(0, ebdat_lua_api_1_0_handler);
  ebdat_lua_register_api1_sub_func_handler(1, ebdat_lua_api_1_1_handler);
  
  EBFUNC(ebdat_lua_register_api_handler)(1, ebdat_lua_api_1_handler);
  EBFUNC(ebdat_lua_register_api_handler)(2, ebdat_lua_api_2_handler);
  EBFUNC(ebdat_lua_set_ready)(TRUE);
  ebdat_print_string("Now EBDAT for LUA module ready\r\n");
  while (TRUE)//don't exit from main EBDAT thread, or else the EBDAT for LUA APIs will be released.
  {
  	EBFUNC(ebdat_thread_sleep)(100);
  }
	

	ebdat_print_string("end of ebdat_customer_entry\r\n");
}
#pragma arm section code


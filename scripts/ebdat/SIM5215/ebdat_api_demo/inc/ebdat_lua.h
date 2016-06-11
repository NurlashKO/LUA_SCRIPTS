/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
11/04/13  sj     Create Module
*/
#ifndef __EBDAT_LUA_H__
#define __EBDAT_LUA_H__

#include "ebdat_types.h"
#include "ebdat_lua_common.h"

#ifdef FEATURE_SIMCOM_EMBEDDED_AT
#define EBDAT_LUA_MAX_APIS 200

typedef struct
{
	int api_no;
	int sub_api_no;
       int caller_thread_idx;
	int param1;
	int param2;
	int param3;
	int param4;
	int param5;
	int param6;
	byte* str_param1;
	unsigned int str_param1_len;
	byte* str_param2;
	unsigned int str_param2_len;
	byte* str_param3;
	unsigned int str_param3_len; 
}ebdat_lua_api_in_param_s_type;

#define EBDAT_LUA_ERROR_NONE 0
#define EBDAT_LUA_ERROR_NO_API -100
#define EBDAT_LUA_ERROR_WRONG_PARAM -101

typedef struct
{
	int param1;
	int param2;
	int param3;
	int param4;
	int param5;
	int param6;
	byte* str_param1;
	unsigned int str_param1_len;
       boolean str_param1_need_free;
	byte* str_param2;
	unsigned int str_param2_len;
       boolean str_param2_need_free;
	byte* str_param3;
	unsigned int str_param3_len; 
       boolean str_param3_need_free;
}ebdat_lua_api_out_param_s_type;

typedef int(*ebdat_lua_api_handler_func_type)(ebdat_lua_api_in_param_s_type* in_param_p, ebdat_lua_api_out_param_s_type* out_param_p);

boolean ebdat_lua_register_api_handler(uint32 api_no, ebdat_lua_api_handler_func_type func);
boolean ebdat_lua_deregister_api_handler(uint32 api_no);
boolean ebdat_lua_set_evt(int thread_idx, EVT_ID_TYPE evt, EVT_PARAM_TYPE evt_p1, EVT_PARAM_TYPE evt_p2, EVT_PARAM_TYPE evt_p3, double evt_clock);
void ebdat_lua_signal_notify(int thread_index, uint8 sig_mask);
void ebdat_lua_set_ready(boolean ready);//after all APIs register finished, set the reday flag to TRUE.
#endif /* FEATURE_SIMCOM_EMBEDDED_AT */

#endif /* __EBDAT_LUA_H__ */


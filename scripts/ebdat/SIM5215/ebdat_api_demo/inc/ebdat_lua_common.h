/*
when       who     what, where, why
--------   ---     ----------------------------------------------------------
11/01/13  sj     Modify bug MKBUG00004618 to add LEVT_ZIGBEE_RECV_EVENT
09/27/13  sj     Modify MKBUG00004033 to add LEVT_SMS_EVENT
09/27/13  sj     Modify bug MKBUG00004021 to add LUA voice_call library
09/18/13  sj     Modify bug MKBUG00004001 to add LEVT_FTPS_EVENT
09/13/13  sj     Modify bug MKBUG00003986 to add LEVT_COMMON_CH_EVENT
09/11/13  sj     Modify bug MKBUG00003977 to add LEVT_SOCKET_EVENT
06/21/12  dyy  Add LEVT_PB_EVENT define
06/15/12  sj     Create Module
*/
#ifndef __EBDAT_LUA_COMMON_H__
#define __EBDAT_LUA_COMMON_H__

#ifndef FEATURE_EBDAT_CLIENT
/* 
  * simcom just use the original types
  */
#include "comdef.h"
#include "customer.h"
#else
#include "ebdat_types.h"
#endif /* FEATURE_EBDAT_CLIENT */

#if defined (FEATURE_SIMCOM_EMBEDDED_AT) || defined(FEATURE_LUATASK)

#define LEVT_GPIO_EVENT_1           0
#define LEVT_UART_EVENT_1           1
#define LEVT_KEYPAD_EVENT_1      2
#define LEVT_USB_EVENT_1             3
#define LEVT_AUDIO_EVENT_1        4
#define LEVT_ZIGBEE_RECV_EVENT      7
#define LEVT_LAST_ISR_EVENT       20
#define LEVT_CALL_EVENT           21
#define LEVT_SOCKET_EVENT           22
#define LEVT_SLEEP_EVENT             23
#define LEVT_COMMON_CH_EVENT           24
#define LEVT_FTPS_EVENT           25
#define LEVT_SMS_EVENT            26
#define LEVT_TIMER_EVENT             28
#define LEVT_SIO_RECV_EVENT      29
#define LEVT_ATCTL_RECV_EVENT  30
#define LEVT_OUT_CMD_EVT           31
#define LEVT_LED_EVENT                 32
#define LEVT_PDP_EVENT                 33
#define LEVT_PB_EVENT                   34
#define LEVT_NMEA_RECV_EVENT    35
#define LEVT_MULTIMEDIA_EVENT              36

#define EVT_ID_TYPE uint32
#define EVT_PARAM_TYPE uint32

typedef enum
{
  LEVT_SMS_CMTI,
  LEVT_SMS_CSDI
}levt_sms_evt_p1_t;

typedef enum
{
  LEVT_SMS_STORE_ME,
  LEVT_SMS_STORE_SIM
}levt_sms_evt_p2_t;

typedef enum
{
  LEVT_MULTIMEDIA_WAV
}levt_multimedia_evt_p1_t;

typedef enum
{
  LEVT_SLEEP_ENTER,
  LEVT_SLEEP_LEAVE
}levt_sleep_t;

/*add by aaron*/
/*
  * parameter 1 of luaBi_setevt by event LEVT_UART_EVENT_1
  */
typedef enum
{
	LEVT_UART_DTR_INTERRUPT,   /*dtr interrupt event*/
	NUMBER_OF_LEVT_UART = 0xFFFFFFFF
}levt_uart_t;
/*end by aaron*/

typedef enum
{
	USB_MODE_CHANGE,   /*dtr interrupt event*/
	USB_MEDIA_REMOVAL,   /*USB media remove event*/
	NUMBER_OF_LEVT_USB_P1 = 0xFFFFFFFF
}levt_usb_evt_p1_t;

typedef enum
{
	LEVT_PDP_ATTACH_ACCEPT = 0,   /*dtr interrupt event*/
	LEVT_PDP_ATTACH_REJECT = 1,    /*attach reject event*/
	LEVT_ACTIVATE_PDP_ACCEPT = 2,
	LEVT_ACTIVATE_PDP_REJECT = 3,
	LEVT_ACTIVATE_PDP_REQUEST = 4,
	LEVT_DEACTIVATE_PDP_REQUEST_SENT=5,
	LEVT_DEACTIVATE_PDP_REQUEST_RECEIVE=6,
	LEVT_DEACTIVATE_PDP_ACCEPT_SENT=7,
	LEVT_DEACTIVATE_PDP_ACCEPT_RECEIVE=8,
	NUMBER_OF_PDP = 0xFFFFFFFF
}levt_pdp_evt_p1_t;


typedef enum
{
  VOICELIB_STATE_UNKNOWN = -1,
  VOICELIB_STATE_ACTIVE = 0,
  VOICELIB_STATE_HELD = 1,
  VOICELIB_STATE_DIALING = 2,
  VOICELIB_STATE_ALERTING = 3,
  VOICELIB_STATE_INCOMING = 4,
  VOICELIB_STATE_WAITING = 5,
  VOICELIB_STATE_DISCONNECT = 6,
  VOICELIB_RX_DTMF = 250
}lvoicelib_external_call_state_e_type;

int lvoicelib_get_active_call_count(void);
int ebdat_lua_common_get_call_state(uint8 call_id);
void ebdat_lua_common_add_call_state_change_evt(uint8           call_id);


extern boolean ebdat_lua_common_add_delayed_evt(uint32 evt, uint32 param1, uint32 param2, uint32 param3);
extern boolean ebdat_lua_common_add_imediate_evt(uint32 evt, uint32 param1, uint32 param2, uint32 param3);
#endif
#endif /* __EBDAT_LUA_COMMON_H__ */

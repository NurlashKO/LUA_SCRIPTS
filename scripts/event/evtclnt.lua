--------------------------------------------------------------------------------
--测试说明
--本脚本测试EVENT功能
--1. 在"CONFIGURATION SECTION"部分修改相关配置变量
--------------------------------------------------------------------------------
function handle_received_sio_data(hdr_idx)
  --print("hdr_idx=",hdr_idx,"\r\n");
  if (hdr_idx == SIO_OK_RECVED) then
    --received OK
    return string.len(sio_rpt_hdr[hdr_idx]);
  elseif (hdr_idx == SIO_ERROR_RECVED) then
    --received ERROR
    return string.len(sio_rpt_hdr[hdr_idx]);
  elseif (hdr_idx == SIO_CME_ERROR_RECVED) then
    --received +CME ERROR
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    if (end_pos) then
      return end_pos + 1;
    end;
  elseif (hdr_idx == SIO_CMMSSEND_RECVED) then
    --received +CMMSSEND
    if (string.startwith(sio_recved_string,"\r\n+CMMSSEND: 0\r\n")) then
      --succeeded in sending mms
      main_state = 0;
      return string.len("\r\n+CMMSSEND: 0\r\n");
    else
      --Failed in sending mms, find the "\r\n" after +CMMSSEND:
      local end_pos = string.absfind(sio_recved_string,"\r\n",3);
      if (end_pos) then
        return end_pos;
      end;
    end;
  elseif (hdr_idx == SIO_CMMSRECV_RECVED) then
    --received +CMMSRECV
    if (string.startwith(sio_recved_string,"\r\n+CMMSRECV: 0\r\n")) then
      --succeeded in sending mms
      main_state = 0;
      return string.len("\r\n+CMMSRECV: 0\r\n");
    else
      --Failed in sending mms, find the "\r\n" after +CMMSRECV:
      local end_pos = string.absfind(sio_recved_string,"\r\n",3);
      if (end_pos) then
        return end_pos + 1;
      end;
    end;
  elseif (hdr_idx == SIO_WAP_PUSH_MMS_RECVED) then
    --received +WAP_PUSH_MMS
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    if (end_pos) then
      return end_pos + 1;
    end;
  elseif (hdr_idx == SIO_CSQ_RECVED) then
    --received +CSQ:
    --print("received +CSQ\r\n");
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    --print("end_pos=",end_pos,"\r\n");
    if (end_pos) then
      return end_pos + 1;
    end;
  elseif (hdr_idx == SIO_CPIN_RECVED) then
    --received +CPIN:
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    if (end_pos) then
      return end_pos + 1;
    end;
  else
    --handle other sio string...
    return string.len(sio_recved_string);
  end;
  return 0;
end;
-----------------------------------
--const values for event id, these are defined in the lua task on the module.
GPIO_EVENT  = 0
UART_EVENT  = 1
KEYPAD_EVENT = 2
USB_EVENT = 3
AUDIO_EVENT = 4
TIMER_EVENT = 28
SIO_RCVD_EVENT = 29
AT_CTL_EVENT = 30

-----------------------------------
--all possible sio report data headers
--enum value
SIO_OK_RECVED                      = 1
SIO_ERROR_RECVED                   = 2 
SIO_CME_ERROR_RECVED               = 3 
SIO_CMMSSEND_RECVED                = 4 
SIO_CMMSRECV_RECVED                = 5 
SIO_WAP_PUSH_MMS_RECVED            = 6 
SIO_CSQ_RECVED                     = 7 
SIO_CPIN_RECVED                    = 8 
SIO_UGSM_RECVED                    = 9 
SIO_ATE_RECVED                     = 10
SIO_CREG_RECVED                    = 11
SIO_CGREG_RECVED                   = 12
SIO_CNSMOD_RECVED                  = 13
SIO_CCLK_RECVED                    = 14
SIO_CGMR_RECVED                    = 15
SIO_COPS_RECVED                    = 16
SIO_CNMP_RECVED                    = 17
SIO_CNBP_RECVED                    = 18
SIO_CNRP_RECVED                    = 19
SIO_CNAOP_RECVED                   = 20
SIO_CNSDP_RECVED                   = 21
SIO_CFUN_RECVED                    = 22
SIO_CPSI_RECVED                    = 23
SIO_VOICE_CALL_END_RECVED          = 24
SIO_VOICE_CALL_BEGIN_RECVED        = 25
SIO_VOICE_CALL_ALERTING_RECVED     = 26
SIO_CLIP_RECVED                    = 27
SIO_RING_RECVED                    = 28
SIO_MISSED_CALL_RECVED             = 29
SIO_NO_CARRIER_RECVED              = 30
SIO_VPRINGBACK_RECVED              = 31
SIO_VPCONNECTED_RECVED             = 32
SIO_VPINCOM_RECVED                 = 33
SIO_VPEND_RECVED                   = 34
SIO_CCFC_RECVED                    = 35
SIO_CCWA_RECVED                    = 36
SIO_CUSD_RECVED                    = 37
SIO_CMGS_RECVED                    = 38
SIO_CMGSO_RECVED                   = 39
SIO_CMGRO_RECVED                   = 40
SIO_WAP_PUSH_RECVED                = 41
SIO_CLASS0_RECVED                  = 42
SIO_CMGRD_RECVED                   = 43
SIO_CMGL_RECVED                    = 44
SIO_CMTI_RECVED                    = 45
SIO_SMS_FULL_RECVED                = 46
SIO_CMS_ERROR_RECVED               = 47
SIO_CMGF_RECVED                    = 48
SIO_CSCA_RECVED                    = 49
SIO_CPMS_RECVED                    = 50
SIO_NEW_LINE_SYMB_RECVED           = 51
SIO_CMGW_RECVED                    = 52
SIO_CMGWO_RECVED                   = 53
SIO_CMGWSIM_RECVED                 = 54
SIO_CMSS_RECVED                    = 55
SIO_CGSMS_RECVED                   = 56
SIO_CMVP_RECVED                    = 57
SIO_CBM_RECVED                     = 58
SIO_CDS_RECVED                     = 59
SIO_CSMP_RECVED                    = 60
SIO_CNUM_RECVED                    = 61
SIO_CPBS_RECVED                    = 62
SIO_CPBRE_RECVED                   = 63
SIO_CPBR_RECVED                    = 64
SIO_VGR_RECVED                     = 65
SIO_MICGRECVED                     = 66
SIO_EARKEY_RECVED                  = 67
SIO_HOOKKEY_RECVED                 = 68
SIO_DSWITCH_RECVED                 = 69
SIO_AUTOANSWER_RECVED              = 70
SIO_CLCK_RECVED                    = 71
SIO_CFDN_RECVED                    = 72
SIO_TRIES_REMAINING_RECVED         = 73
SIO_RLOCK_RECVED                   = 74
SIO_CIMI_RECVED                    = 75
SIO_CGSN_RECVED                    = 76
SIO_CINQSWRV_RECVED                = 77
SIO_CSWITCHDM_RECVED               = 78
SIO_CHSDPACAT_RECVED               = 79
SIO_CSPN_RECVED                    = 80
SIO_CONS_RECVED                    = 81
SIO_TEMPERATURE_HIGH_RECVED        = 82
SIO_TEMPERATURE_LOW_RECVED         = 83
SIO_CSIMLOCK_RECVED                = 84
SIO_CSLWCODE_RECVED                = 85
SIO_CSLDCODE_RECVED                = 86
SIO_STIN_RECVED                    = 87

sio_rpt_hdr = {};
sio_rpt_hdr[SIO_OK_RECVED]                     = "\r\nOK\r\n";
sio_rpt_hdr[SIO_ERROR_RECVED]                  = "\r\nERROR\r\n";
sio_rpt_hdr[SIO_CME_ERROR_RECVED]              = "\r\n+CME ERROR:";
sio_rpt_hdr[SIO_CMMSSEND_RECVED]               = "\r\n+CMMSSEND:";
sio_rpt_hdr[SIO_CMMSRECV_RECVED]               = "\r\n+CMMSRECV:";
sio_rpt_hdr[SIO_WAP_PUSH_MMS_RECVED]           = "\r\n+WAP_PUSH_MMS:";
sio_rpt_hdr[SIO_CSQ_RECVED]                    = "\r\n+CSQ:";
sio_rpt_hdr[SIO_CPIN_RECVED]                   = "\r\n+CPIN:";
sio_rpt_hdr[SIO_UGSM_RECVED]                   = "\r\n+UGSM:";
sio_rpt_hdr[SIO_ATE_RECVED]                    = "\r\nATE";
sio_rpt_hdr[SIO_CREG_RECVED]                   = "\r\n+CREG:";
sio_rpt_hdr[SIO_CGREG_RECVED]                  = "\r\n+CGREG:";
sio_rpt_hdr[SIO_CNSMOD_RECVED]                 = "\r\n+CNSMOD:";
sio_rpt_hdr[SIO_CCLK_RECVED]                   = "\r\n+CCLK:";
sio_rpt_hdr[SIO_CGMR_RECVED]                   = "\r\n+CGMR:";
sio_rpt_hdr[SIO_COPS_RECVED]                   = "\r\n+COPS:";
sio_rpt_hdr[SIO_CNMP_RECVED]                   = "\r\n+CNMP:";
sio_rpt_hdr[SIO_CNBP_RECVED]                   = "\r\n+CNBP:";
sio_rpt_hdr[SIO_CNRP_RECVED]                   = "\r\n+CNRP:";
sio_rpt_hdr[SIO_CNAOP_RECVED]                  = "\r\n+CNAOP:";
sio_rpt_hdr[SIO_CNSDP_RECVED]                  = "\r\n+CNSDP:";
sio_rpt_hdr[SIO_CFUN_RECVED]                   = "\r\n+CFUN:";
sio_rpt_hdr[SIO_CPSI_RECVED]                   = "\r\n+CPSI:";
sio_rpt_hdr[SIO_VOICE_CALL_END_RECVED]         = "\r\nVOICE CALL: END:";
sio_rpt_hdr[SIO_VOICE_CALL_BEGIN_RECVED]       = "\r\nVOICE CALL: BEGIN";
sio_rpt_hdr[SIO_VOICE_CALL_ALERTING_RECVED]    = "\r\nVOICE CALL: ALERTING";
sio_rpt_hdr[SIO_CLIP_RECVED]                   = "\r\n+CLIP:";
sio_rpt_hdr[SIO_RING_RECVED]                   = "\r\nRING";
sio_rpt_hdr[SIO_MISSED_CALL_RECVED]            = "\r\nMISSED_CALL:";
sio_rpt_hdr[SIO_NO_CARRIER_RECVED]             = "\r\nNO CARRIER";
sio_rpt_hdr[SIO_VPRINGBACK_RECVED]             = "\r\nVPRINGBACK";
sio_rpt_hdr[SIO_VPCONNECTED_RECVED]            = "\r\nVPCONNECTED";
sio_rpt_hdr[SIO_VPINCOM_RECVED]                = "\r\nVPINCOM";
sio_rpt_hdr[SIO_VPEND_RECVED]                  = "\r\nVPEND\r\n";
sio_rpt_hdr[SIO_CCFC_RECVED]                   = "\r\n+CCFC:";
sio_rpt_hdr[SIO_CCWA_RECVED]                   = "\r\n+CCWA:";
sio_rpt_hdr[SIO_CUSD_RECVED]                   = "\r\n+CUSD:";
sio_rpt_hdr[SIO_CMGS_RECVED]                   = "\r\n+CMGS:";
sio_rpt_hdr[SIO_CMGSO_RECVED]                  = "\r\n+CMGSO:";
sio_rpt_hdr[SIO_CMGRO_RECVED]                  = "\r\n+CMGRO:";
sio_rpt_hdr[SIO_WAP_PUSH_RECVED]               = "\r\n+WAP_PUSH:";
sio_rpt_hdr[SIO_CLASS0_RECVED]                 = "\r\n+CLASS0:";
sio_rpt_hdr[SIO_CMGRD_RECVED]                  = "\r\n+CMGRD:";
sio_rpt_hdr[SIO_CMGL_RECVED]                   = "\r\n+CMGL:";
sio_rpt_hdr[SIO_CMTI_RECVED]                   = "\r\n+CMTI:";
sio_rpt_hdr[SIO_SMS_FULL_RECVED]               = "\r\n+SMS_FULL";
sio_rpt_hdr[SIO_CMS_ERROR_RECVED]              = "\r\n+CMS ERROR:";
sio_rpt_hdr[SIO_CMGF_RECVED]                   = "\r\n+CMGF:";
sio_rpt_hdr[SIO_CSCA_RECVED]                   = "\r\n+CSCA:";
sio_rpt_hdr[SIO_CPMS_RECVED]                   = "\r\n+CPMS:";
sio_rpt_hdr[SIO_NEW_LINE_SYMB_RECVED]          = "\r\n>";
sio_rpt_hdr[SIO_CMGW_RECVED]                   = "\r\n+CMGW:";
sio_rpt_hdr[SIO_CMGWO_RECVED]                  = "\r\n+CMGWO:";
sio_rpt_hdr[SIO_CMGWSIM_RECVED]                = "\r\n+CMGWSIM:";
sio_rpt_hdr[SIO_CMSS_RECVED]                   = "\r\n+CMSS:";
sio_rpt_hdr[SIO_CGSMS_RECVED]                  = "\r\n+CGSMS:";
sio_rpt_hdr[SIO_CMVP_RECVED]                   = "\r\n+CMVP:";
sio_rpt_hdr[SIO_CBM_RECVED]                    = "\r\n+CBM:";
sio_rpt_hdr[SIO_CDS_RECVED]                    = "\r\n+CDS:";
sio_rpt_hdr[SIO_CSMP_RECVED]                   = "\r\n+CSMP:";
sio_rpt_hdr[SIO_CNUM_RECVED]                   = "\r\n+CNUM:";
sio_rpt_hdr[SIO_CPBS_RECVED]                   = "\r\n+CPBS:";
sio_rpt_hdr[SIO_CPBRE_RECVED]                  = "\r\n+CPBRE:";
sio_rpt_hdr[SIO_CPBR_RECVED]                   = "\r\n+CPBR:";
sio_rpt_hdr[SIO_VGR_RECVED]                    = "\r\n+VGR:";
sio_rpt_hdr[SIO_MICGRECVED]                    = "\r\n+MICG:";
sio_rpt_hdr[SIO_EARKEY_RECVED]                 = "\r\n+EARKEY:";
sio_rpt_hdr[SIO_HOOKKEY_RECVED]                = "\r\n+HOOKKEY";
sio_rpt_hdr[SIO_DSWITCH_RECVED]                = "\r\n+DSWITCH:";
sio_rpt_hdr[SIO_AUTOANSWER_RECVED]             = "\r\n+AUTOANSWER:";
sio_rpt_hdr[SIO_CLCK_RECVED]                   = "\r\n+CLCK:";
sio_rpt_hdr[SIO_CFDN_RECVED]                   = "\r\n+CFDN:";
sio_rpt_hdr[SIO_TRIES_REMAINING_RECVED]        = "\r\n+TRIES_REMAINING:";
sio_rpt_hdr[SIO_RLOCK_RECVED]                  = "\r\n+RLOCK:";
sio_rpt_hdr[SIO_CIMI_RECVED]                   = "\r\n+CIMI:";
sio_rpt_hdr[SIO_CGSN_RECVED]                   = "\r\n+CGSN:";
sio_rpt_hdr[SIO_CINQSWRV_RECVED]               = "\r\n+CINQSWRV:";
sio_rpt_hdr[SIO_CSWITCHDM_RECVED]              = "\r\n+CSWITCHDM:";
sio_rpt_hdr[SIO_CHSDPACAT_RECVED]              = "\r\n+CHSDPACAT:";
sio_rpt_hdr[SIO_CSPN_RECVED]                   = "\r\n+CSPN:";
sio_rpt_hdr[SIO_CONS_RECVED]                   = "\r\n+CONS:";
sio_rpt_hdr[SIO_TEMPERATURE_HIGH_RECVED]       = "\r\n+TEMPERATURE_HIGH";
sio_rpt_hdr[SIO_TEMPERATURE_LOW_RECVED]        = "\r\n+TEMPERATURE_LOW";
sio_rpt_hdr[SIO_CSIMLOCK_RECVED]               = "\r\n+CSIMLOCK:";
sio_rpt_hdr[SIO_CSLWCODE_RECVED]               = "\r\n+CSLWCODE:";
sio_rpt_hdr[SIO_CSLDCODE_RECVED]               = "\r\n+CSLDCODE:";
sio_rpt_hdr[SIO_STIN_RECVED]                   = "\r\n+STIN:";
-----------------------------------

-----------------------------------
--enumeration of main state for this script
MAIN_STATE_IDLE           = 0
MAIN_STATE_VERIFY_PIN     = 1
MAIN_STATE_SEND_MMS       = 2
MAIN_STATE_RECV_MMS       = 3
MAIN_STATE_SEND_SMS       = 4
MAIN_STATE_VOICE_CALL     = 5
MAIN_STATE_VIDEO_PHONE    = 6

-----------------------------------
--CONFIGURATION SECTION

--initial state is idle
main_state = MAIN_STATE_IDLE;

--initial received sio string
sio_recved_string = "";  

MAX_UNKNOWN_SIO_STRING_LEN  = 30

--use at+autocsq=1 to test sio event
test_autocsq_event = true;
-----------------------------------

printdir(1);
sio.send("ATE0\r\n");
sio_recv(5000);
sio.clear();
  
if (test_autocsq_event) then
  sio.send("AT+AUTOCSQ=1\r\n");
  rsp = sio_recv(5000);
  print(rsp);
end;

--the minimum value of the second parameter for vmstarttimer(...) is 20ms
vmstarttimer(0,2000);
vmstarttimer(1,5000);
--only generate 1 timer event for timer id 2
vmstarttimer(2,50,0);
--vmstarttimer(3,5);

count = 0;
--main loop
while ( true ) do
  --only test for handling 20 events
  if (count >= 20) then
    break;
  end;
  evt, evt_param = waitevt(15000);
  if (evt >= 0) then
    count = count + 1;
    print("\r\n----(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
    if ( evt == GPIO_EVENT ) then
      print("\r\ngpio event occured, parameter=",evt_param,"\r\n");
    elseif ( evt == UART_EVENT ) then
      print("\r\nuart event occured, parameter=",evt_param,"\r\n");
    elseif ( evt == KEYPAD_EVENT ) then
      print("\r\nkeypad event occured, parameter=",evt_param,"\r\n");
    elseif ( evt == USB_EVENT ) then
      print("\r\nusb event occured, parameter=",evt_param,"\r\n");
    elseif ( evt == AUDIO_EVENT ) then
      print("\r\naudio event occured, parameter=",evt_param,"\r\n");
    elseif ( evt == TIMER_EVENT ) then
      print("\r\ntimer event occured, timer_id=",evt_param,"\r\n");
    elseif ( evt == AT_CTL_EVENT ) then
      print("\r\atctl event occured, parameter=",evt_param,"\r\n");
    elseif (evt == SIO_RCVD_EVENT) then
      local found_matched_hdr_idx = -1;
      local rsp = sio_recv(5000);
      if (rsp) then
        print("\r\nsio event occured: ", rsp,"\r\n");
        --sio_recved_string = string.concat(sio_recved_string,rsp);
        sio_recved_string = sio_recved_string..rsp;
		
        print(" sio_recved_string.len=",string.len(sio_recved_string),"\r\n");
		print("----",sio_recved_string,"*****\r\n");
        --------------------------------------------
        --handle all the received string
        while (true) do
          found_matched_hdr_idx = -1;
          if (string.len(sio_recved_string) > 0) then
            for idx, val in pairs(sio_rpt_hdr) do
              --print("val=",val,"\r\n");
              if (string.startwith(sio_recved_string,val)) then
                found_matched_hdr_idx = idx;
                --print("found idx=", idx, "\r\n");
                break;
              end;
            end;
          end;
          --handle the found hdr
          if (found_matched_hdr_idx >= 0) then
            local used_len = handle_received_sio_data(found_matched_hdr_idx);
            if (used_len == string.len(sio_recved_string)) then
              sio_recved_string = "";
              break;
            elseif (used_len > 0) then
              sio_recved_string = string.sub(sio_recved_string,used_len+1,string.len(sio_recved_string));
            else
              --cannot handle the received string, maybe it is not a complete packet, so wait for next report string to complete it.
              if (string.len(sio_recved_string) > MAX_UNKNOWN_SIO_STRING_LEN) then
                --discard the sio string which cannot be recognized for it's length exceeds the threshold value.
                sio_recved_string = "";
              end;
			        break;
            end;
          else
            break;
          end;
        end;
        --end of handling the received string
        --------------------------------------------
      end;       
    end;
  end;
end;

vmstoptimer(0);
vmstoptimer(1);
vmstoptimer(2);
--vmstoptimer(3);

if (test_autocsq_event) then
  sio.send("AT+AUTOCSQ=0\r\n");
  rsp = sio_recv(5000);
  print(rsp);
end;

sio.send("ATE1\r\n");
rsp = sio_recv(5000);
print(rsp);


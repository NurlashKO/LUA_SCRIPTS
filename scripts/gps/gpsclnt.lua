--------------------------------------------------------------------------------
--测试说明
--本脚本执行GPS上报功能:
--1. 在"CONFIGURATION SECTION"部分修改相关配置变量
--2. 自动运行脚本(脚本名称为autorun.lua)
--3. LUA 优先级设置为高
--4. GPS定位成功后发送一条短消息给客户
--5. 每隔一个小时通过短消息发送一次GPS坐标信息给客户
--6. 接收短消息查询，当消息内容包含GPS info时，发送一条GPS定位信息短消息给客户，如果没有坐标，就发送基站信息
--7. 低电压告警发送短消息出来
--8. 关机前发送坐标短消息出来(目前不支持)
--------------------------------------------------------------------------------
function handle_cmt_content(hdr_idx)
  local total_len = string.len(sio_recved_string); 
  if (not(hdr_idx == SIO_CMT_RECVED)) then
    print("currently only +CMT is supported");
    return total_len;
  end;
  if (not (main_state == MAIN_STATE_RECEIVED_SMS_QUERY)) then
    local idx = string.absfind(sio_recved_string, "+CMT:");
    if (not idx) then
      print("Failed to find +CMT\r\n");
      return total_len;
    end;
    local tmp_rcvd_string = string.sub(sio_recved_string, idx, string.len(sio_recved_string));
    if (not tmp_rcvd_string) then
      print("Failed to call string.sub starting from +CMT\r\n");
      return total_len; 
    end;
    local dest_no = parse_sio_report_parameter(tmp_rcvd_string,"+CMT:",1,",",",",true);
    if (not dest_no) then
      print("Failed to parse dest_no\r\n");
      return total_len;
    end;
    print("dest_no= "..dest_no.."\r\n");
    idx = string.absfind(tmp_rcvd_string, "\r\n");
    if (not idx) then
      return total_len;
    end;
    tmp_rcvd_string = string.sub(tmp_rcvd_string, idx, string.len(sio_recved_string));
    if (not tmp_rcvd_string) then
      return total_len; 
    end;
    --tmp_rcvd_string = string.sub(1, pdu_len);
    idx = string.absfind(tmp_rcvd_string, QUERY_SMS_CONTENT);
    if (not idx) then
      return total_len;
    end;
    --the sms contains the query gps info, then handle it
    handle_timer_event(1, dest_no);
  end;
  return total_len;
end;
function handle_received_sio_data(hdr_idx)
  --print("hdr_idx=",hdr_idx,"\r\n");
  if (hdr_idx == SIO_CMTI_RECVED) then
    --received +CMTI
    return string.len(sio_recved_string);
  elseif (hdr_idx == SIO_CMT_RECVED) then
    --received +CMT
    print("Received +CMT\r\n");
    return handle_cmt_content(hdr_idx);
  elseif (hdr_idx == SIO_VOL_ALARM) then
    --received warning! voltage is low:
    send_sms_with_gps_info(SMS_REPORT_PHONE_NUMBER, "warning! voltage is low", SMS_REPORT_MAX_RETRY_COUNT);
    return string.len(sio_recved_string);
  else
    --handle other sio string...
    return string.len(sio_recved_string);
  end;
  return string.len(sio_recved_string);
end;
function init_sms_configuration_info(cmgf, cnmi_p1, cnmi_p2, csca)
  local cmd = string.format("at+cmgf=%d\r\n",cmgf);
  local rsp =sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set cmgf\r\n");
    return false;
  end;
  
  cmd = string.format("at+cnmi=%d,%d\r\n",cnmi_p1, cnmi_p2);
  rsp = sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set cnmi\r\n");
    return false;
  end;
  
  cmd = string.format("at+csca=\"%s\"\r\n",csca);
  rsp = sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set csca\r\n");
    return false;
  end;
  print("Succeeded in setting sms configuration\r\n");
  return true;
end;

function send_sms_with_gps_info(dest_no, content, max_retry)
  local rsp = nil;
  local exp_num = -1;
  local cmd = nil;
  local retry_count = 0;
  --print("begin to send sms\r\n");
  while (true) do
    cmd = string.format("at+cmgs=\"%s\"\r\n", dest_no);
    rsp, exp_num  = sio_send_and_recv3(cmd,">", "+CME ERROR", "+CMS ERROR",5000);
    if (exp_num == 1) then      
      cmd = content .. "\26";
      rsp, exp_num = sio_send_and_recv3(cmd,"OK","+CMGS", "+CMS ERROR", 3 * 60000);
      --print(rsp);
      if (rsp and ((exp_num == 1) or (exp_num == 2))) then
        return true;
      end;
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
      
    else
      --print("step4, failed to send sms:", rsp," exp_num=",exp_num, "\r\n");
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
    end;
  end;
  return false;
end;

function start_gps(mode, start_type)
  local s_mode = gps.gpssetmode(mode);
  if(not s_mode) then
    return false;
  end;
  local start = gps.gpsstart(start_type)
  if(not start) then
    return false;
  end;
  return true;
end;

function stop_gps()
  close = gps.gpsclose();
  if(not close) then
    return false;
  end;
  return true;
end;

function get_gpsinfo()
  return gps.gpsinfo();
end;

function wait_first_valid_gpsinfo(timeout)
  local start_count = os.clock();
  local fix = nil;
  while (true) do
    local fix = get_gpsinfo();
    if (not string.equal(fix,INVALID_GPS_INFO)) then
      return fix;
    end;
    local cur_count = os.clock();
    if (timeout) then
      if (((cur_count - start_count)*1000) > timeout) then
        --print("time out for receiving valid gps info");
        break;
      end;
    end;
    vmsleep(1000);
  end;
  return nil;
end;

function get_netinfo()
  FAILED_TO_GET_NETINFO = "Failed to get net info";
  local exp_num = -1;
  local rsp = nil;
  sio.clear();
  rsp =sio_send_and_recv("AT+CPSI?\r\n","\r\n+CPSI:", 5000);
  if (not rsp) then
    return FAILED_TO_GET_NETINFO;
  end;
  local mode = parse_sio_report_parameter(rsp,"\r\n+CPSI:",1,",",",",false);
  if (not mode) then
    return FAILED_TO_GET_NETINFO;
  end;
  if (mode == "WCDMA") then
    sio.clear();
    rsp, exp_num =sio_send_and_recv2("AT+CRUS\r\n","\r\n+CRUS: Active SET","\r\n+CRUS: Active SET,NULL", 5000);
    if (not rsp) then
      return "WCDMA,NULL,NULL";
    end;
    if (exp_num ~= 1) then
      return "WCDMA,NULL,NULL";
    end;
    local psc = parse_sio_report_parameter(rsp,"\r\n+CRUS:",3,",",",",false);
    local arfcn = parse_sio_report_parameter(rsp,"\r\n+CRUS:",4,",",",",false);
    if (arfcn and psc) then
      return "WCDMA,"..psc..","..arfcn;
    else
      return "WCDMA,NULL,NULL";
    end;
  elseif (mode == "GSM") then
    sio.clear();
    rsp =sio_send_and_recv("AT+CCINFO\r\n","\r\n+CCINFO:", 5000);
    if (not rsp) then
      return "GSM,NULL,NULL";
    end;
    print("rsp="..rsp);
    local arfcn = parse_sio_report_parameter(rsp,"\r\n+CCINFO:",2,",",",",false);
    local bsic = parse_sio_report_parameter(rsp,"\r\n+CCINFO:",7,",",",",false);
    print("arfcn="..arfcn.."    bsic="..bsic.."\r\n");
    if (arfcn and bsic) then
      arfcn = parse_sio_report_parameter(arfcn,"ARFCN:",1,",",nil,false);
      bsic = parse_sio_report_parameter(bsic,"BSIC:",1,",",nil,false);
      if (arfcn and bsic) then
        return "GSM,"..bsic..","..arfcn;
      else
        return "GSM,NULL,NULL";
      end;
    else
      return "GSM,NULL,NULL";
    end
  elseif (mode == "NO SERVICE") then
    return "NO SERVICE,NULL,NULL";
  else
    return FAILED_TO_GET_NETINFO;
  end;
end;

function handle_timer_event(timer_id, dest_no)
  --print("timer_id=", timer_id," destno="..dest_no.."\r\n");
  if (timer_id == 0) then
    --try to fix gps info for the first time
    if (main_state >= MAIN_STATE_GOT_1ST_GPS_FIX )then
      return;
    end;
    local fix = get_gpsinfo();
    if ((string.equal(fix,INVALID_GPS_INFO))) then
      return;
    else      
      main_state = MAIN_STATE_GOT_1ST_GPS_FIX;
      vmstoptimer(timer_id);
      send_sms_with_gps_info(dest_no, fix, SMS_REPORT_MAX_RETRY_COUNT);
    end;
  elseif (timer_id == 1) then
    -- 1 hour timer
    local fix = get_gpsinfo();
    print("fix="..fix.."\r\n");
    if (not string.equal(fix,INVALID_GPS_INFO)) then
      send_sms_with_gps_info(dest_no, fix, SMS_REPORT_MAX_RETRY_COUNT);
    else
      local net_info = get_netinfo();
      send_sms_with_gps_info(dest_no, net_info, SMS_REPORT_MAX_RETRY_COUNT);    
    end;
  end;
end;

function sio_recv_contain(expect_result, timeout)
  local find_rst = nil;
  local rsp = nil;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  while (not find_rst) do
    rsp = sio.recv(1000); 
    --print(rsp);   
    if (rsp) then
      find_rst = string.absfind(rsp,expect_result);
    else      
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          --print("time out for receiving expect result");
          break;
        end;
      end;
    end;
  end
  return rsp;
end

--receive result1 or result2
function sio_recv_contain2(expect_result1, expect_result2, timeout)
  local find_rst = nil;
  local rsp = nil;
  local rst_num = -1;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  --print("sio_recv_contain2",expect_result1, expect_result2);
  while (not find_rst) do
    rsp = sio.recv(1000);    
    if (rsp) then
      --print("recv2,rsp="..rsp);
      find_rst = string.absfind(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
        --print("find_rst(2)=",find_rst, expect_result2);
        if (find_rst) then
          rst_num = 2;
        end;
      else
        rst_num = 1;
      end;
    else
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          --print("time out for receiving expect result");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2", rsp, rst_num);
  end
  return rsp , rst_num;
end

--receive result1 or result2 or result3
function sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout)
  local find_rst = nil;
  local rsp = nil;
  local rst_num = -1;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  while (not find_rst) do
    rsp = sio.recv(1000);    
    if (rsp) then
      --print(rsp);
      find_rst = string.absfind(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
        --print("find_rst(2)=",find_rst, expect_result2);
        if (not find_rst) then
          find_rst = string.absfind(rsp,expect_result3);
          if (find_rst) then
            rst_num = 3;
          end;
        else
          rst_num = 2;
        end;
      else
        rst_num = 1;
      end;
    else
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          --print("time out for receiving expect result");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2", rsp, rst_num);
  end
  return rsp , rst_num;
end

function sio_send_and_recv(cmd, expect_result, timeout)
  print(">>>>>>>>>>>>>>", cmd);
  sio.send(cmd);
  local rsp = sio_recv_contain(expect_result, timeout);
  return rsp;
end

function sio_send_and_recv2(cmd, expect_result1, expect_result2, timeout)
  print(">>>>>>>>>>>>>>", cmd);  
  sio.send(cmd);
  local rsp, exp_num = sio_recv_contain2(expect_result1, expect_result2, timeout);
  --print("sio_send_and_recv2",rsp, exp_num);
  return rsp, exp_num;
end

function sio_send_and_recv3(cmd, expect_result1, expect_result2, expect_result3, timeout)
  print(">>>>>>>>>>>>>>", cmd);
  sio.send(cmd);
  local rsp, exp_num = sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout);
  --print("sio_send_and_recv2",rsp, exp_num);
  return rsp, exp_num;
end

function trim (s)
    return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

function parse_sio_report_parameter(sio_rcvd_string, report_header,  param_idx, delimiter, right_token, remove_quota)
  local report_header_pos = 0;
  if (report_header) then
    string.absfind(sio_rcvd_string,report_header);
  end;
  if (report_header_pos) then
    sio_rcvd_string = string.sub(sio_rcvd_string,report_header_pos,string.len(sio_rcvd_string));
    local left_colon_pos = string.len(report_header);
    if (left_colon_pos) then
      sio_rcvd_string = string.sub(sio_rcvd_string,left_colon_pos+1,string.len(sio_rcvd_string));
      for idx = 1, (param_idx -1), 1 do
        local left_comma_pos = string.absfind(sio_rcvd_string,delimiter);
        if (left_comma_pos) then
          sio_rcvd_string = string.sub(sio_rcvd_string,left_comma_pos+1,string.len(sio_rcvd_string));
        end;
      end;
      local right_token_pos = string.len(sio_rcvd_string) + 1;
      if (right_token) then
        right_token_pos = string.absfind(sio_rcvd_string,right_token);
      end;
      if (right_token_pos) then
        sio_rcvd_string = string.sub(sio_rcvd_string,1,right_token_pos-1);
        sio_rcvd_string = trim(sio_rcvd_string);
        if (remove_quota) then
          local len_of_parameter = string.len(sio_rcvd_string);
          if (len_of_parameter >= 2) then
            if ((string.sub(sio_rcvd_string,1,1) == "\"") and (string.sub(sio_rcvd_string,len_of_parameter,len_of_parameter) == "\"")) then
              if (len_of_parameter == 2) then
                return "";
              else
                return string.sub(sio_rcvd_string,2,len_of_parameter-1);
              end;
            end;
          end;
        else
          return sio_rcvd_string;
        end;
      end;
    end;
  end;
  print("failed to parse parameter\r\n");
  return nil;
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
SIO_CMT_RECVED                     = 88
SIO_VOL_ALARM                      = 89
SIO_SMS_DONE                       = 90
SIO_PB_DONE                        = 91

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
sio_rpt_hdr[SIO_CMT_RECVED]                    = "\r\n+CMT:";
sio_rpt_hdr[SIO_VOL_ALARM]                     = "\r\nwarning! voltage is low:";
sio_rpt_hdr[SIO_SMS_DONE]                      = "\r\nSMS DONE\r\n";
sio_rpt_hdr[SIO_PB_DONE]                       = "\r\nPB DONE\r\n";
-----------------------------------

-----------------------------------
--enumeration of main state for this script
MAIN_STATE_IDLE               = 0
MAIN_STATE_STARTED_GPS        = 1
MAIN_STATE_GOT_1ST_GPS_FIX    = 2
MAIN_STATE_RECEIVED_SMS_QUERY = 3

-----------------------------------
--CONFIGURATION SECTION

--initial state is idle
main_state = MAIN_STATE_IDLE;

--initial received sio string
sio_recved_string = "";  

INVALID_GPS_INFO = ",,,,,,,";
QUERY_SMS_CONTENT = "GPS info"; --text mode in +CMT

MAX_UNKNOWN_SIO_STRING_LEN  = 0

SMS_CSCA = "+8613800210500";
SMS_REPORT_PHONE_NUMBER = "15021309668";
SMS_REPORT_INTERVAL = 1 * 60 * 60 * 1000;
SMS_REPORT_MAX_RETRY_COUNT = 10

-----------------------------------
--main function starts from here

vmsetpri(3); --3=high, 2= middle, 1= low(default)
--printdir(1);
sio.exclrpt(1);

sio.send("ATE0\r\n");
sio.recv(5000);

local rsp = nil;
while (not (rsp and string.absfind(rsp, "\r\n+CPIN: READY\r\n"))) do
  rsp = sio_send_and_recv("AT+CPIN?\r\n","\r\n+CPIN: READY\r\n",60000);
end;
print(rsp);

rsp = sio_send_and_recv("AT+CVALARM=1\r\n","\r\nOK\r\n",5000);
print(rsp);
rsp = false;
while (not rsp) do
  rsp = init_sms_configuration_info(1, 1, 2, SMS_CSCA);
  if (not rsp) then
    vmsleep(5000);
  end;
end;
sio.clear();

gps_mode = 1; --standalone
gps_start_type = 2; -- code start
if (not start_gps(gps_mode, gps_start_type)) then
  print("Failed to start GPS device\r\n");
  send_sms_with_gps_info(SMS_REPORT_PHONE_NUMBER, "Failed to start GPS device", SMS_REPORT_MAX_RETRY_COUNT);    
  return;
end;
print("Succeeded in starting GPS device");

main_state = MAIN_STATE_STARTED_GPS;

--the minimum value of the second parameter for vmstarttimer(...) is 20ms
vmstarttimer(0,1000);
vmstarttimer(1,SMS_REPORT_INTERVAL);

--count = 0;
--main loop
while ( true ) do
  --only test for handling 40 events
  --if (count >= 40) then
    --break;
  --end;
  evt, evt_param = waitevt(15000);
  if (evt >= 0) then
--    count = count + 1;
--    print("\r\n----(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
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
      --print("\r\ntimer event occured, timer_id=",evt_param,"\r\n");
      handle_timer_event(evt_param,SMS_REPORT_PHONE_NUMBER);
    elseif ( evt == AT_CTL_EVENT ) then
      print("\r\atctl event occured, parameter=",evt_param,"\r\n");
    elseif (evt == SIO_RCVD_EVENT) then
      local found_matched_hdr_idx = -1;
      local rsp = sio.recv(5000);
      if (rsp) then
        print("\r\nsio event occured: ", rsp,"\r\n");
        --sio_recved_string = string.concat(sio_recved_string,rsp);
        sio_recved_string = sio_recved_string..rsp;
        print(" sio_recved_string.len=",string.len(sio_recved_string),"\r\n");
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
            if (string.len(sio_recved_string) > MAX_UNKNOWN_SIO_STRING_LEN) then
              --discard the sio string which cannot be recognized for it's length exceeds the threshold value.
              print("found unknown sio string:"..sio_recved_string.."\r\n");
              sio_recved_string = "";
            end;
            break;
          end;
        end;
        --end of handling the received string
        --------------------------------------------
      end;       
    end;
  end;
end;

stop_gps();
vmstoptimer(0);
vmstoptimer(1);

sio.exclrpt(0);
sio.send("ATE1\r\n");
rsp = sio.recv(5000);
print(rsp);


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
--------------------------------------------------------------------------------
--Basic function definition starts from here
function send_sms_with_text_data(dest_no, content, delimiter, max_retry)
  local rsp = nil;
  local exp_num = -1;
  local cmd = nil;
  local array = {};
  local array_item_idx = 1;
  if ((not content) or (string.len(content) == 0)) then
    print("empty sms content, just send it\r\n");
    return send_sms_with_array(dest_no, {}, max_retry);
  end;
  local idx = 1;
  idx = string.absfind(content, delimiter, idx);
  while (idx) do
    local item = "";
    --print("idx=", idx, "\r\n");
    if (idx > 1) then
      item = string.sub(content, 1, idx-1);
    elseif (idx == 1) then
      item = "";
    end;
    --print("item=", item,"\r\n");
    array[array_item_idx] = item;
    array_item_idx = array_item_idx + 1;
    if ((idx + string.len(delimiter) - 1) == string.len(content)) then
      content = "";
      break;
    end;
    --print("----content=", content, "\r\n");
    content = string.sub(content, idx + string.len(delimiter), string.len(content));
    --print("content=", content, "\r\n");
    idx = string.absfind(content, delimiter, idx);
    --vmsleep(3000);
  end;
  if (content and (string.len(content) > 0)) then
    --print("item=", content,"\r\n");
    array[array_item_idx] = content;
    array_item_idx = array_item_idx + 1;
    content = "";
  end;
  --print("dest_no=", dest_no, "\r\n");
  --for idx, cmd in pairs(array) do
      --print("cmd=", cmd, "\r\n");
  --end;
  return send_sms_with_array(dest_no, array, max_retry);
end;

function send_sms_with_array(dest_no, content, max_retry)
  local rsp = nil;
  local exp_num = -1;
  local cmd = nil;
  local retry_count = 0;
  --print("begin to send sms\r\n");
  while (true) do
    cmd = string.format("at+cmgs=\"%s\"\r\n", dest_no);
    rsp, exp_num  = sio_send_and_recv3(cmd,">", "+CME ERROR", "+CMS ERROR",5000);
    if (exp_num == 1) then   
      if (content) then
        local prev_cmd = "";
        local line_idx = 0;
        for idx, cmd in pairs(content) do
          line_idx = line_idx + 1;
          if (line_idx > 1) then
            rsp = sio_send_and_recv(prev_cmd .. "\r",">", 5000);
          end;
          prev_cmd = cmd;
        end;
        if (prev_cmd and (string.len(prev_cmd) > 0)) then
          rsp = sio.send(prev_cmd);
        end;
      end;         
      rsp, exp_num = sio_send_and_recv3("\26","OK","+CMGS", "+CMS ERROR", 60000);
      if (rsp and ((exp_num == 1) or (exp_num == 2))) then
        return true;
      end;
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
      
    else
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
    end;
  end;
  return false;
end;
function sio_recv_contain(expect_result, timeout)
  local find_rst = nil;
  local rsp = nil;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  while (not find_rst) do
    rsp = sio_recv(1000); 
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
    rsp = sio_recv(1000);    
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
    rsp = sio_recv(1000);    
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
--Basic function definition ends here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--operation function definition starts from here
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
  return send_sms_with_text_data(dest_no, content, "\r\n", max_retry);
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
  INVALID_GPS_INFO = ",,,,,,,";
  if (timer_id == 0) then
    --try to fix gps info for the first time
	if (main_state == MAIN_STATE_IDLE) then
	  --try to start gps
	  if (start_gps(GPS_MODE_STANDLONE, GPS_START_TYPE_CODE)) then      
        main_state = MAIN_STATE_STARTED_GPS;
	  else
	    print("Failed to start GPS device\r\n");
		send_sms_with_text_data(SMS_REPORT_PHONE_NUMBER, "Failed to start GPS device", "\r\n", SMS_REPORT_MAX_RETRY_COUNT);    
      end;
	  return;
    elseif (main_state >= MAIN_STATE_GOT_1ST_GPS_FIX )then
      return;
    end;
    local fix = get_gpsinfo();
    if ((string.equal(fix,INVALID_GPS_INFO))) then
	  print("timer 0 occured, Failed to fix GPS info\r\n");
      return;
    else      
	  print("timer 0 occured, Succeed in fixing GPS info\r\n");
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
      send_sms_with_text_data(dest_no, net_info, "\r\n", SMS_REPORT_MAX_RETRY_COUNT);    
    end;
  end;
end;

function register_sio_data_handler(sio_header, handler)
  sio_data_handler[sio_header] = handler;
end;

function deregister_sio_data_handler(sio_header)
  sio_data_handler[sio_header] = nil;
end;

function sio_data_handler_proc(sio_data)
  print("sio_data_handler_proc\r\n");
  --vmsleep(2000);
  for sio_header, handler in pairs(sio_data_handler) do
    if (string.startwith(sio_data,sio_header)) then
	  if (handler) then
	    return handler(sio_data,0,0);
	  else
	    break;
	  end;
	end;
  end;
  return 0;
end;

function sio_data_CMT_handler(sio_data, wparam, lparam)
  print("sio_data_CMT_handler\r\n");
  --vmsleep(2000);
  local total_len = string.len(sio_recved_string); 
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
	if (not sms_query_handler_proc(dest_no, tmp_rcvd_string, 0, 0)) then
	  return total_len;
	end;
  end;
  return total_len;
end;

function sio_data_VoltageLow_handler(sio_data, wparam, lparam)
  local cur_clock = os.clock();
  if (((cur_clock - sms_last_report_low_voltage_clock) * 1000) >= MIN_INTERVAL_OF_REPORTING_LOW_POWER) then
    send_sms_with_text_data(SMS_REPORT_PHONE_NUMBER, "warning! voltage is low", "\r\n", SMS_REPORT_MAX_RETRY_COUNT);
	sms_last_report_low_voltage_clock = os.clock();
  end;
  return string.len(sio_data);
end;

function register_sms_query_handler(query, handler)
  sms_query_handler[query] = handler;
end;

function deregister_sms_query_handler(query)
  sms_query_handler[query] = nil;
end;

function sms_query_handler_proc(dest_no, sms_data, query_wparam, query_lparam)
  --print("sms_query_handler_proc", dest_no, sms_data, "\r\n");
  for query, handler in pairs(sms_query_handler) do
    if (string.absfind(sms_data, query)) then
	  if (handler) then
        return handler(dest_no, sms_data, query_wparam, query_lparam);
      end;
	end;
  end;
  return false;
end;

function sms_GPS_info_query_handler(dest_no, sms_data, query_wparam, query_lparam)
  --the sms contains the query gps info, then handle it
  print("sms_GPS_info_query_handler", dest_no, sms_data, "\r\n");
  handle_timer_event(1, dest_no);
  return true;
end;

--function sms_MyCmd2_query_handler(dest_no, sms_data, query_wparam, query_lparam)
--  print("sms_MyCmd2_query_handler", dest_no, sms_data, "\r\n");
--  send_sms_with_text_data(dest_no, "This is a reply to my cmd2", "\r\n", SMS_REPORT_MAX_RETRY_COUNT);
--  return true;
--end;
	
--this function is used to exit main loop
function exit_mainloop()
  setevt(EXIT_EVENT, 0);
end;

function register_evt_handler(evt, handler)
  evt_handler[evt] = handler;
end;

function deregister_evt_handler(evt)
  evt_handler[evt] = nil;
end;

function event_handler_proc(evt, evt_param)
  local idx = nil;
  local handler = nil;
  if (evt <= 0) then
    return false;
  end;
  for idx, handler in pairs(evt_handler) do
    --print("val=",val,"\r\n");
    if (idx == evt) then
	  if (handler) then
        return handler(evt, evt_param, 0);
	  else
	    break;
	  end;
    end;
  end;
  return default_event_handler(evt, evt_param, 0);
end;

function default_event_handler(evt_id, evt_wparam, evt_lparam)
  return true;
end;

function timer_event_handler(evt_id, evt_wparam, evt_lparam)
  if (evt_id ~= TIMER_EVENT) then
    return false;
  end;
  --only test for 20 timer events
  --count = count + 1;
  --if (count >= 20) then
    --exit_mainloop();
	--return false;
  --end;
  handle_timer_event(evt_wparam,SMS_REPORT_PHONE_NUMBER);
  return true;
end;

function sio_event_handler(evt_id, evt_wparam, evt_lparam)
  print("sio_event_handler\r\n");
  if (evt_id ~= SIO_RCVD_EVENT) then
    return false;
  end;
  MAX_UNKNOWN_SIO_STRING_LEN  = 0
  local rsp = sio_recv(5000);
  if (rsp) then
    sio_recved_string = sio_recved_string..rsp;
    print("sio event occured, len=",string.len(sio_recved_string),"\r\n");
    --------------------------------------------
    --handle the whole received sio string
    while (true) do
	  local used_len = 0;
      if (string.len(sio_recved_string) > 0) then
	    print("call sio_data_handler_proc\r\n");
	    used_len = sio_data_handler_proc(sio_recved_string);
      end;
      --handle the found hdr
      if (used_len > 0) then
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
  return true;
end;

function wait_for_pin_ready()
  local rsp = nil;
  while (not (rsp and string.absfind(rsp, "\r\n+CPIN: READY\r\n"))) do
    rsp = sio_send_and_recv("AT+CPIN?\r\n","\r\n+CPIN: READY\r\n",60000);
  end;
  print(rsp);
end;

function configure_sms()
  rsp = false;
  while (not rsp) do
    rsp = init_sms_configuration_info(1, 1, 2, SMS_CSCA);
    if (not rsp) then
      vmsleep(5000);
    end;
  end;
end;

function enable_low_voltage_alarm()
  rsp = sio_send_and_recv("AT+CVALARM=1\r\n","\r\nOK\r\n",5000);
  print(rsp);
end;

function enable_at_echo(enable)
  if (enable) then
    sio.send("ATE1\r\n");
    sio_recv(5000);
  else
    sio.send("ATE0\r\n");
    sio_recv(5000);
  end;
end;

function lua_main()
  --vmsetpri(3); --3=high, 2= middle, 1= low(default)
  printdir(1);
  --sio.exclrpt(1);
  
  register_evt_handler(TIMER_EVENT,    timer_event_handler);
  register_evt_handler(SIO_RCVD_EVENT, sio_event_handler);
  
  register_sio_data_handler("\r\n+CMT:", sio_data_CMT_handler);
  register_sio_data_handler("\r\nwarning! voltage is low:", sio_data_VoltageLow_handler);
  
  register_sms_query_handler("GPS info", sms_GPS_info_query_handler);
  --register_sms_query_handler("My cmd2",  sms_MyCmd2_query_handler);
  
  --disable AT echo
  enable_at_echo(false);
  
  --loop until pin is ready
  wait_for_pin_ready();
  
  --enable low power alarm
  enable_low_voltage_alarm();  
  
  --configure sms
  configure_sms();  
  
  --start GPS device. if failed ,just return
  if (not start_gps(GPS_MODE_STANDLONE, GPS_START_TYPE_CODE)) then
    print("Failed to start GPS device\r\n");
    send_sms_with_text_data(SMS_REPORT_PHONE_NUMBER, "Failed to start GPS device", "\r\n", SMS_REPORT_MAX_RETRY_COUNT);    
  else
    print("Succeeded in starting GPS device\r\n");
	main_state = MAIN_STATE_STARTED_GPS;
  end;  
  
  --start timer, time 0 is used for 1st GPS fix; time 1 is used for GPS info report for every 1 hour.
  vmstarttimer(0,1000);
  vmstarttimer(1,SMS_REPORT_INTERVAL);
  
  --main loop of event handler
  while ( true ) do
    evt, evt_param = waitevt(15000);
    if (evt >= 0) then
	  if (evt == EXIT_EVENT) then
	    print("exit main loop\r\n");
	    break;
	  else
        event_handler_proc(evt, evt_param);
      end;
    end;
  end;
  
  --stop GPS device
  stop_gps();
  vmstoptimer(0);
  vmstoptimer(1);
  
  sio.exclrpt(0);
  --enable AT echo
  enable_at_echo(true);
end;
--operation function definition ends here
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--const values for event id, these are defined in the lua task on the module.
GPIO_EVENT  = 0
UART_EVENT  = 1
KEYPAD_EVENT = 2
USB_EVENT = 3
AUDIO_EVENT = 4
TIMER_EVENT = 28
SIO_RCVD_EVENT = 29
AT_CTL_EVENT = 30
--EXIT_EVENT is extended by this script, and it is not a constant value defined by the inner module
EXIT_EVENT   = 31

--------------------------------------------------------------------------------
--enumeration of main state for this script
MAIN_STATE_IDLE               = 0
MAIN_STATE_STARTED_GPS        = 1
MAIN_STATE_GOT_1ST_GPS_FIX    = 2
MAIN_STATE_RECEIVED_SMS_QUERY = 3

--------------------------------------------------------------------------------
--global variables
evt_handler = {}
sms_query_handler = {}
sio_data_handler = {}
--initial received sio string
sio_recved_string = ""; 
--initial state is idle
main_state = MAIN_STATE_IDLE;
--last time of sending low voltage sms
sms_last_report_low_voltage_clock = 0;
--count = 0; 
---------------------------------------
--CONFIGURATION SECTION 

SMS_CSCA = "+8613800210500";
SMS_REPORT_PHONE_NUMBER = "15021309668";
SMS_REPORT_INTERVAL = 1 * 60 * 60 * 1000;
SMS_REPORT_MAX_RETRY_COUNT = 10

GPS_MODE_STANDLONE = 1; --standalone
GPS_START_TYPE_CODE = 2; -- code start

--the minimum timer interval of sending low voltage reporting sms
MIN_INTERVAL_OF_REPORTING_LOW_POWER  =  3 * 60 * 1000

--------------------------------------------------------------------------------
--MAIN function starts from here

lua_main();

--MAIN function ends here
--------------------------------------------------------------------------------
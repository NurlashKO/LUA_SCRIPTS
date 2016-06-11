 -------------------------------------------------------------------------------------------------
-- File:				m2m_http.lua
----------------------------------------------------------------------------------------------------



		
----------------------------------------------------------------------------------------------------


----------------------------- Debug utility for Hex Dump -------------------------------
--Basic function definition starts from here
function print_hex(data)
  local add_space = 1 --default 1
  local group_count = 4 --default -1
  local byte_each_line = 16 --default -1
  local add_ascii = 1 --default 0
  local hex_str = string.bin2hex(data);
  --local hex_str = string.bin2hex(data, add_space, group_count, byte_each_line, add_ascii);
  if (hex_str) then
    print(hex_str);
  else
    print("nil");
  end;
end;
--------------------------------------------------------------------------------


------------Https utilities from Simcom to execute a variable lenght Post  -------------------

function sio_recv(timeout)
  local rsp = sio.recv(timeout);
  if (rsp) then
    print("<<<<<<<<<<",rsp);
  end;
end;

function sio_send(cmd)
  print(">>>>>>>>>>", cmd);
  sio.send(cmd);
end;

function sio_recv_contain(expect_result, timeout)
  local find_rst = nil;
  local rsp = nil;
  local start_count = os.clock();
  --print("start_count = "..tostring(start_count).."\r\n");
  while (not find_rst) do
    rsp = sio_recv( 1000);
	if (rsp) then
      --print(rsp);
	end;
    if (rsp) then
      find_rst = string.absfind(rsp,expect_result);
    else
      local cur_count = os.clock();
      --print("cur_count = "..tostring(cur_count).."\r\n");
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          print("time out for receiving expect result\r\n");
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
  --print("start_count = "..tostring(start_count).."\r\n");
  --print("sio_recv_contain2"..expect_result1..expect_result2.."\r\n");
  while (not find_rst) do
    rsp = sio_recv( 1000);
	if (rsp) then
      find_rst = string.absfind(rsp,expect_result1);
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
        if (find_rst) then
          --print("find_rst(2)="..find_rst..expect_result2.."\r\n");
          rst_num = 2;
        end;
      else
        --print(rsp.."find_rst="..find_rst..expect_result1.."\r\n");
      
		rst_num = 1;
      end;
    else
      local cur_count = os.clock();
      --print("cur_count = "..cur_count.."\r\n");
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          print("time out for receiving expect result\r\n");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2"..rsp..tostring(rst_num).."\r\n");
  end
  return rsp , rst_num;
end

--receive result1 or result2 or result3
function sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout)
  local find_rst = nil;
  local rsp = nil;
  local rst_num = -1;
  local start_count = os.clock();
  --print("start_count = "..tostring(start_count).."\r\n");
  while (not find_rst) do
    rsp = sio_recv( 1000);
	if (rsp) then
      --print(rsp);
	  --print_hex(rsp);
	  end;
    if (rsp) then
      find_rst = string.absfind(rsp,expect_result1);
      --print(rsp.."find_rst="..find_rst..expect_result1.."\r\n");
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
        --print("find_rst(2)="..find_rst..expect_result2.."\r\n");
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
      --print("cur_count = "..tostring(cur_count).."\r\n");
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          --print("time out for receiving expect result\r\n");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2"..rsp..tostring(rst_num).."\r\n");
  end
  return rsp , rst_num;
end

function sio_send(cmd)
  print(">>>>>>>>>>>>>>"..cmd.."\r\n");
  sio.send(cmd);
end;

function sio_recv(timeout)
  rsp = sio.recv( timeout);
  if (rsp) then
    print(rsp);
  end;
  return rsp;
end;

function sio_send_and_recv(cmd, expect_result, timeout)
  --print(">>>>>>>>>>>>>>"..cmd);
  sio_send(cmd);
  local rsp = sio_recv_contain(expect_result, timeout);
  return rsp;
end

function sio_send_and_recv2(cmd, expect_result1, expect_result2, timeout)
  --print(">>>>>>>>>>>>>>"..cmd);
  sio_send(cmd);
  local rsp, exp_num = sio_recv_contain2(expect_result1, expect_result2, timeout);
  --print("sio_send_and_recv2"..rsp..tostring(exp_num));
  return rsp, exp_num;
end

function sio_send_and_recv3(cmd, expect_result1, expect_result2, expect_result3, timeout)
  --print(">>>>>>>>>>>>>>"..cmd);
  sio_send( cmd);
  local rsp, exp_num = sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout);
  --print("sio_send_and_recv2"..rsp..tostring(exp_num).."\r\n");
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

function enable_at_echo(enable)
  if (enable) then
	sio_send_and_recv("ATE1\r\n","OK",5000);
  else
    sio_send_and_recv("ATE0\r\n","OK",5000);
  end;
end;

function open_https_session(url, port, httpx)
  -- Get stack and set HTTP=1 or HTTPS=2 type server
  print("open_https_session\r\n");
  local error_code = common_ch.open(0, url, port, httpx);
  print("common_ch.open(), error_code=", error_code, "\r\n");
  if (error_code and (error_code == CCH_RST_OK)) then  
    print("Succeeded in opening HTTPS session\r\n");
    return true;
  else
    print(" Failed open https session\r\n")	
	return false;
  end;
end;

function close_https_session()
  print("close_https_session\r\n");
  local error_code = common_ch.close(0);
  print("common_ch.close(), error_code=", error_code, "\r\n");
  if (error_code and (error_code == CCH_RST_OK)) then  
    print("Succeeded in closing HTTPS session\r\n");
    return true;
  else
    print("ERROR!!! failed to close https session\r\n");
	return false;
  end;
end;

function start_https_protocol_stack()
  print("start_https_protocol_stack\r\n");
  local result = common_ch.start();
  if (not result) then
    print(" Failed stop https session\r\n");
	return false;
  end;
  print("succeeded in starting HTTPS stack\r\n");
  return true;
end;

function stop_https_protocol_stack()
  print("stop_https_protocol_stack\r\n");
  local result = common_ch.stop();
  if (not result) then
    return false;
  end;
  print("succeeded in stoping HTTPS stack\r\n");
  return true;
end;


function check_left_bytes_in_send_buffer()
  --print("check_left_bytes_in_send_buffer\r\n");
  local rsp, idx = sio_send_and_recv2("AT+CHTTPSSEND?\r\n", "\r\n+CHTTPSSEND:", "\r\nERROR\r\n", 5000);
  if (idx ~= 1) then
    print("failed to check https sending buffer state\r\n");
    return nil;
  end;  
  local left_bytes = parse_sio_report_parameter(rsp,"\r\n+CHTTPSSEND:",1,",","\r\n",false);
  if (left_bytes) then
    left_bytes = tonumber(left_bytes);
  end;
  --print("left_bytes="..tostring(left_bytes).."\r\n");
  return left_bytes;
end;

function check_sending_buffer_idle()
  --print("check_sending_buffer_idle\r\n");
  return true;
end;

function send_subpacket_to_server(sub_packet)
  local result = true;
  local cmd;
  print("send_subpacket_to_server\r\n");
  if (not sub_packet or (string.len(sub_packet) == 0)) then
    --print("no sub_packet needs to send, just return true\r\n");
    return true;
  end;
  --print("sub_packet length="..tostring(string.len(sub_packet)).."\r\n");
  --wait for https stack has enough buffer
  local error_code = common_ch.send(0, sub_packet);
  print("common_ch.send, error_code=", error_code, "\r\n");
  if (error_code and (error_code == CCH_RST_OK)) then 
    return true;
  else
    print("ERROR!!! failed to send sub-packet\r\n");
    return false;
  end;
end;

function commit_sending()
  return true;
end;

function send_data_to_server(data)
  print("-------------------------begin function send_data_to_server here-------------------------".."\r\n");
  local result = false;
  if (not data or (string.len(data) == 0)) then
    --print("no data needs to send, just return true\r\n");
    return true;
  end;  
  local total_send_len = 0;
  while (data) do
    local sub_packet;
	if (string.len(data) > 1024) then
	  sub_packet = string.sub(data, 1, 1024);
	  data = string.sub(data, 1025, -1);
	else
	  sub_packet = data;
	  data = nil;
	end;	
	result = send_subpacket_to_server(sub_packet);
	if (not result) then
	  break;
	end;
    total_send_len = total_send_len + string.len(sub_packet);
	--print("****pushed ", total_send_len, " bytes to sending buffer\r\n");
  end;
  if (result) then
    result = commit_sending();--wait final sending result
  end;
  if (result) then
    print("succeeded in sending data to server, totally sent bytes="..tostring(total_send_len).."\r\n");
  else
    print("failed to send data to server\r\n");
  end;
  return result;
end;
-------------------------- End Https utilities --------------------------

------------------------ -Post all files Queued for Cloud in time left this slot --------------------

-- This post all files left in c:\tocloud\ directory - status, images - everything queued if internet down
-- status always posted first, followed by images etc.
-- It should send newest to oldest to uptodate so when internet returns it gets current status and images etc.
-- reading directory stored in  alpha order, "cg_","lg_" followed by "tr_". Lastest in last one based on posix time stamp.
-- So we should send from the end of the group - set "cg_" last item first.
-- overtime it will upload all the old files
-- start the http stack once for a group of files - sames transmission/radio on time

function cch_check_recv_data(timeout)
  if (not timeout) then
    timeout = 0;
  end;
  local start_tick = os.clock();
  while (true) do
    local cached_rx_len = common_ch.get_rx_cache_len(0);
	print("RX cache len = ", cached_rx_len, "\r\n");
	if (cached_rx_len > 0) then
	  return true;
	end;
	local cur_tick = os.clock();
	if ((cur_tick - start_tick)*1000 >= timeout) then
	  break;
	end;
	vmsleep(1000);
  end;
  return false;
end;

function cch_read_all_cached_rcvd_data(timeout)
  while (true) do
	  if (cch_check_recv_data(timeout)) then
	    print("call common_ch.recv()...\r\n");
	    local max_recv_len = 2048;
	    error_code, rcvd_data = common_ch.recv(0, max_recv_len);
	    print("common_ch.recv(), error_code=", error_code, "\r\n");
		if (not error_code or (error_code ~= CCH_RST_OK)) then
		  print("received fail\r\n");
		  break;
		end;
	    if (printdir()) then
	      if (rcvd_data) then
		    print("received data=\r\n");
	        os.printstr(rcvd_data);--this can print string larger than 1024 bytes, and also it can print string including '\0'.
	      end;
	    end;
	  else
	    print("NO RECV event\r\n");
	    break;
	  end;
  end;
end;

function recv_https_response_from_server(timeout)
  print("recv_https_response_from_server\r\n");
  cch_read_all_cached_rcvd_data(timeout);  
end;

function post_single_file_tocloud(dir, fname, url, port, httpx)
  print("post_single_file_tocloud\r\n");
  local result = true;
  local filepath = dir..fname;
  print("begin to read file content:", filepath,"\r\n")
  local filecontent = "";
  local file_total_length = os.filelength(filepath);
  collectgarbage();    
  if (not file_total_length or file_total_length <= 0) then
    print("file length is wrong: ", file_total_length, "\r\n");
    return false;
  end;
  local file = io.open(filepath,"rb");
  if (not file) then
    print("failed to open ", filepath, "\r\n");
    return false;
  end;
  if (not open_https_session(url, port, httpx)) then
    file:close();
	return false;
  end;  
  local first_packet = true;
  local last_packet = true;
  local cnt = nil;
  filelen = 0;
  while (true) do
  --if (true) then
    cnt = file:read(1024);
	if (not cnt) then
	  if (last_packet) then
	    last_packet = false;
	    cnt = "\r\n--AaB03x--\r\n\r\n";
		print("The last packet\r\n");
	  end;
	end;
    if (not cnt) then       
      break;
    else
	  filelen = filelen + string.len(cnt);
	  if (first_packet) then
	    first_packet = false;
	    cnt = "--AaB03x\r\ncontent-disposition: form-data; name=\"f\"\r\n\r\npost_file\r\n--AaB03x\r\ncontent-disposition: form-data; name=\"fname\"\r\n\r\n"..fname.."\r\n--AaB03x\r\ncontent-disposition: form-data; name=\"data\"; filename=\"trap.jpg\"\r\n\r\n"..cnt;
	  end;
      if (not send_data_to_server(cnt)) then
	    print("failed to send subpacket to server, len=", string.len(cnt), "\r\n");
		result = false;
	    break;
	  else	    
	    print("succeeded in sending subpacket to server, len=", string.len(cnt), "\r\n");
		--if received data, now handle it.
		recv_https_response_from_server(nil);
	  end;
    end;
  end;
  file:close();  
  if (result) then
    print("Try to receive HTTPS response\r\n");
	recv_https_response_from_server(10000);
    print("succeeded in sending file content, file length=",filelen," bytes\r\n");
  end;
  if not (close_https_session()) then
  end;
  return result;
end;

function post_queued_files_tocloud (url, port, httpx, apn)
	local start_t = os.clock()
	print ("Start Post Queued Files\r\n")
	sio_send_and_recv ("AT+CGSOCKCONT=1,\"IP\",\""..apn.."\"\r\n", "OK",5000) -- setup PDP context 1
	sio_send_and_recv ("AT+CSOCKSETPN=1\r\n","OK",5000) -- select PDP context 1 for testing
	-- Open stack for HTTP server
    if (start_https_protocol_stack()) then
	
		local dir_list,file_list = os.lsdir ("c:\\tocloud\\")
		for index,fname in pairs(file_list) do
		    local filepath = "c:\\tocloud\\"..fname;
			print("---------------send file", filepath, "---------------\r\n");
			if (not post_single_file_tocloud("c:\\tocloud\\", fname, url, port, httpx)) then
			  print("ERROR!!! failed to send file \"", filepath, "\" to cloud\r\n");
			else
			  print("Succeeded in sending file \"", filepath, "\" to cloud\r\n");
			end;
		end
		
		if stop_https_protocol_stack() then
			print ("Stop Post Queued Stack\r\n")
		else
			print ("ERROR!!! Https Stack failed to stop\r\n")
		end
	end
	
end

function lua_main()
  enable_at_echo(false);
  local count = 0;
  while (true) do
    collectgarbage();    
	count = count + 1;
	print("******************************POST queued files to cloud, times=", count, "******************************\r\n");
    post_queued_files_tocloud(URL, PORT, HTTPX, 10 * 60 * 1000, APN);	
	--vmsleep(30 * 1000);
  end;
  enable_at_echo(true);
end;

COMMON_CH_EVT = 24

CCH_RST_OK = 0;
CCH_RST_ALERTING = 1;
CCH_RST_UNKNOWN_ERROR = 2;
CCH_RST_BUSY = 3;
CCH_RST_PEER_CLOSED = 4;
CCH_RST_TIMEOUT = 5;
CCH_RST_TRANSFER_FAILED = 6;
CCH_RST_MEMORY_ERROR = 7;
CCH_RST_INVALID_PARAMETER = 8;
CCH_RST_NETWORK_ERROR = 9;


CCH_TYPE_UDP = 0
CCH_TYPE_TCP_CLIENT = 1
CCH_TYPE_SSL = 2

--CCH_EVT_TYPE_LOCAL_SESSION_CLOSED = 7;
CCH_EVT_TYPE_NETWORK_CLOSED = 10;
CCH_EVT_TYPE_CCH_STOPED = 11;
CCH_EVT_TYPE_NEW_DATA_RECEIVED = 18;
CCH_EVT_TYPE_NEW_PEER_CLOSED = 19;

printdir(1);
os.printport(3);--use USB-AT port to print data
HTTPX = 2;
URL="180.166.164.118";
PORT = 990;
APN="3gnet"
sio.exclrpt(1);
lua_main();


function cch_wait_recv_event(session_id, timeout)
  local start_tick = os.clock();
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(0);
	if (evt and evt >= 0) then
	  print("waited evt: ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == COMMON_CH_EVT) then
	  local cch_evt_session_id = evt_p1;
	  local cch_evt_id = evt_p2;
	  local cch_evt_err_code = evt_p3;
	  if ((cch_evt_session_id == session_id) and (cch_evt_id == CCH_EVT_TYPE_NEW_DATA_RECEIVED)) then
	    print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	    return true;
      elseif ((cch_evt_session_id == session_id) and (cch_evt_id == CCH_EVT_TYPE_NEW_PEER_CLOSED)) then
	    print("waited event(PEER CLOSED), ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	    return false;
	  end;
	end;
	local cur_tick = os.clock();
	if ((cur_tick - start_tick)*1000 >= timeout) then
	  break;
	end;
	vmsleep(1000);
  end;
  return false;
end;

function cch_read_all_cached_rcvd_data(session_id, timeout)
  while (true) do
	  if (cch_wait_recv_event(session_id, timeout)) then
	    print("call common_ch.recv()...\r\n");
	    local max_recv_len = 2048;
	    error_code, rcvd_data = common_ch.recv(session_id, max_recv_len);
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

function cch_load_ssk_cert_key()
--[[
if the server needs to verify client certificate, then load the client cert, key, ca.
or else, this step is not needed
]]
  local result1 = sslmgr.setca(0, "ca_cert.der");
  local result2 = sslmgr.setcert("client_cert.der", 0);
  local result3 = sslmgr.setkey("client_key.der");
  local result4 = sslmgr.loadck();
  print("cch_load_ssk_cert_key, result=[", result1, ", ", result2, ", ", result3, ", ", result4, "]\r\n");
  return result1 and result2 and result3 and result4;
end;

function send_file_content(session_id, filepath)
  local result = true;
  print("begin to read and send file content:", filepath,"\r\n")
  --local filecontent = "";
  local file = io.open(filepath,"rb");
  if (not file) then
    return false;
  end;
  local cnt = nil;
  filelen = 0;
  local pkt_index = 0;
  while (true) do
  --if (true) then
    cnt = file:read(1024);
    if (not cnt) then       
      break;
    else
      filelen = filelen + string.len(cnt);
      print("test send ", pkt_index, " packets\r\n");
      error_code = common_ch.send(session_id, cnt);
      print("common_ch.send(), error_code=", error_code, "\r\n");
	  if (error_code and (error_code == CCH_RST_OK)) then 
	  else
		result = false;
	    break;
	  end;
	  pkt_index = pkt_index + 1;
    end;
  end;
  file:close();
  if (result) then
    print("succeeded in sending file content, file length=",filelen," bytes\r\n");
  else
    print("failed to send file data\r\n");
  end;
  return result;
end
printdir(1);
collectgarbage();

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



local result;

print("call common_ch.start()...\r\n");
result = common_ch.start();
print("common_ch.start(), result=", result, "\r\n");
if (not result) then
  print("failed to call common_ch.start()\r\n");
  return;
end;
--cch_load_ssk_cert_key();

local error_code;
local session_id = 0; --0 or 1
local peer_address = "180.166.164.118";--this can be domain name or IPv4 address
local peer_port = 990;
local channel_type = CCH_TYPE_SSL;
local bind_port = -1;-- -1 means no bind port
local SEND_FILE = "C:\\2048K.txt";

print("call common_ch.open()...\r\n");
error_code = common_ch.open(session_id, peer_address, peer_port, channel_type, bind_port);
print("common_ch.open(), error_code=", error_code, "\r\n");
if (error_code and (error_code == CCH_RST_OK)) then  
  send_file_content(session_id, SEND_FILE);
  print("call common_ch.close()...\r\n");
  error_code = common_ch.close(session_id);
  print("common_ch.close(), error_code=", error_code, "\r\n");
end;

print("call common_ch.stop()...\r\n");
result = common_ch.stop();
print("common_ch.stop(), result=", result, "\r\n");
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
printdir(1);
collectgarbage();
os.printport(3);--use USB-AT port to print

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
local peer_address = "news.google.co.jp";--this can be domain name or IPv4 address
local peer_port = 443;
local channel_type = CCH_TYPE_SSL;
local bind_port = -1;-- -1 means no bind port

print("call common_ch.open()...\r\n");
error_code = common_ch.open(session_id, peer_address, peer_port, channel_type, bind_port);
print("common_ch.open(), error_code=", error_code, "\r\n");
if (error_code and (error_code == CCH_RST_OK)) then  
  print("call common_ch.send()...\r\n");
  local data = "GET / HTTP/1.1\r\nHost: news.google.co.jp\r\nUser-Agent: SIMCom LUA HTTP User Agent\r\nProxy-Connection: keep-alive\r\nContent-Length: 0\r\n\r\n";
  error_code = common_ch.send(session_id, data);
  print("common_ch.send(), error_code=", error_code, "\r\n");
  if (error_code and (error_code == CCH_RST_OK)) then   
    while (true) do  
	  local timeout = 15000;
	  local max_recv_len = 2048;
	  print("call common_ch.recv(), timeout=", timeout, "...\r\n");
	  error_code, rcvd_data = common_ch.recv(session_id, max_recv_len, timeout);--for timeout parameter, '<=0' means not wait; '> 0' is the timeout milliseconds
	  print("common_ch.recv(), error_code=", error_code, "\r\n");
	  if (not error_code or (error_code ~= CCH_RST_OK)) then
		print("received fail\r\n");
		break;
	  end;
	  if (not rcvd_data or string.len(rcvd_data) == 0) then
	    print("No more data received\r\n");
	    break;
	  end;
	  if (printdir()) then
	    if (rcvd_data) then
		  print("received data=\r\n");
	      os.printstr(rcvd_data);--this can print string larger than 1024 bytes, and also it can print string including '\0'.
	    end;
	  end;
	end;
  end;
  print("call common_ch.close()...\r\n");
  error_code = common_ch.close(session_id);
  print("common_ch.close(), error_code=", error_code, "\r\n");
end;

print("call common_ch.stop()...\r\n");
result = common_ch.stop();
print("common_ch.stop(), result=", result, "\r\n");
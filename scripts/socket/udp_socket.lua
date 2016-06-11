printdir(1);

collectgarbage();
--[[
error code definition
SOCK_RST_SOCK_FAILED and SOCK_RST_NETWORK_FAILED are fatal errors, 
when they happen, the socket cannot be used to transfer data further.
]]
SOCK_RST_OK = 0
SOCK_RST_TIMEOUT = 1
SOCK_RST_BUSY = 2
SOCK_RST_PARAMETER_WRONG = 3
SOCK_RST_SOCK_FAILED = 4
SOCK_RST_NETWORK_FAILED = 5

local result;

local server_address = "180.166.164.118";
local peer_port = 990;

print("opening network...\r\n");
local cid = 1;--0=>use setting of AT+CSOCKSETPN. 1-16=>use self defined cid
local timeout = 30000;--  '<= 0' means wait for ever; '> 0' is the timeout milliseconds
local app_handle = network.open(cid, timeout);--!!! If the PDP for cid is already opened by other app, this will return a reference to the same PDP context.
if (not app_handle) then
  print("faield to open network\r\n");
  return;
end;
print("network.open(), app_handle=", app_handle, "\r\n");

--[[
If the cid parameter is the same as the network.open(), the network.resolve() will use the same PDP activated using network.open(), 
or else the network.resolve() will activate new PDP context by itself.
]]
print("resolving DNS address...\r\n");
local peer_address = network.resolve(server_address, cid);
print("The IP address for ", server_address, " is ", peer_address, "\r\n");

local local_ip_addr = network.local_ip(app_handle);
print("local ip address is ", local_ip_addr, "\r\n");

SOCK_TCP = 0;
SOCK_UDP = 1;

SOCK_WRITE_EVENT = 1
SOCK_READ_EVENT = 2
SOCK_CLOSE_EVENT = 4
SOCK_ACCEPT_EVENT = 8

local socket_fd = socket.create(app_handle, SOCK_UDP);
if (not socket_fd) then
  print("failed to create socket\r\n");
elseif (peer_address) then
  local request = "Hello, this is LUA UDP Test\r\n";
  local timeout = 30000;--  '< 0' means wait for ever; '0' means not wait; '> 0' is the timeout milliseconds
  local err_code, sent_len = socket.sendto(socket_fd, peer_address,peer_port, request, timeout);
  print("socket.sendto ", err_code, ", ", sent_len, "\r\n");
  if (err_code and (err_code == SOCK_RST_OK)) then
	  print("socket.recvfrom()...\r\n");
	  local timeout = 120000;
	  local err_code, from_address, from_port, response = socket.recvfrom(socket_fd, timeout);
	  print("socket.recvfrom() =[", err_code, ",", from_address, ",", from_port, "]\r\n");
	  if ((err_code == SOCK_RST_OK) and response) then
	    if (printdir()) then
	      os.printstr(response);--this can print string larger than 1024 bytes, and also it can print string including '\0'.
		end;
		print("\r\n");
	  end;
  end;
  print("closing socket...\r\n");
  if (not socket.close(socket_fd)) then
    print("failed to close socket\r\n");
  else
    print("close socket succeeded\r\n");
  end;
end;
print("closing network...\r\n");
result = network.close(app_handle);
print("network.close(), result=", result, "\r\n");

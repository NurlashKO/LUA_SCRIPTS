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
print("opening network...\r\n");
local cid = 1;--0=>use setting of AT+CSOCKSETPN. 1-16=>use self defined cid
local timeout = 30000;--  '<= 0' means wait for ever; '> 0' is the timeout milliseconds
local app_handle = network.open(cid, timeout);--!!! If the PDP for cid is already opened by other app, this will return a reference to the same PDP context.
if (not app_handle) then
  print("faield to open network\r\n");
  return;
end;
print("network.open(), app_handle=", app_handle, "\r\n");

local local_ip_addr = network.local_ip(app_handle);
print("local ip address is ", local_ip_addr, "\r\n");

local listening_port = 8080;
local so_backlog = 1;--1 to 3, default 3

SOCK_TCP = 0;
SOCK_UDP = 1;

SOCK_WRITE_EVENT = 1
SOCK_READ_EVENT = 2
SOCK_CLOSE_EVENT = 4
SOCK_ACCEPT_EVENT = 8

local socket_fd = socket.create(app_handle, SOCK_TCP);
if (not socket_fd) then
  print("failed to create socket\r\n");
else
  print("socket_fd=", socket_fd, "\r\n");
  if (not socket.bind(socket_fd, listening_port) or not socket.listen(socket_fd, so_backlog)) then
    print("failed to listen on port ", listening_port, "\r\n");
  else      
    print("listening on \"",local_ip_addr,":",listening_port,"\"...\r\n");
    local timeout = 60000;-- '< 0' means wait for ever; '0' means not wait; '> 0' is the timeout milliseconds
	local err_code, accept_socket, client_ip, client_port = socket.accept(socket_fd, timeout);
	print("socket.accept() = [", err_code, ",", accept_socket, ",", client_ip, ",", client_port, "]\r\n");
	if (err_code == SOCK_RST_OK) then
	  print("the accepted socket fd is ", accept_socket, "\r\n");
	  local timeout = 60000;-- '< 0' means wait for ever; '0' means not wait; '> 0' is the timeout milliseconds
	  print("Waiting request data from client, timeout =", timeout, ", ...\r\n");
	  local err_code, client_req = socket.recv(accept_socket, timeout);
	  print("socket.recv(), err_code=", err_code, "\r\n");
	  if ((err_code == SOCK_RST_OK) and client_req) then
	    socket.keepalive(accept_socket, true);--this depends on AT+CTCPKA command to set KEEP ALIVE interval
	    if (printdir()) then
	      os.printstr(client_req);--this can print string larger than 1024 bytes, and also it can print string including '\0'.
		end;
		print("\r\n");
		local response = "Hello, welecome to connect "..local_ip_addr..":"..listening_port.."\r\n";
        local err_code, sent_len = socket.send(accept_socket, response, timeout);
		print("socket.send ", err_code, ", ", sent_len, "\r\n");
	  else
	    print("failed to call socket.recv\r\n");
	  end;
	  if (not socket.close(accept_socket)) then
        print("failed to close accepted socket\r\n");
      else
        print("close accepted socket succeeded\r\n");
      end;
	elseif (err_code == SOCK_RST_TIMEOUT) then
	  print("failed to accept socket for timeout\r\n");
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
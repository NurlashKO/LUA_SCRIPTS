function service_thread(accept_socket)
  print("service_thread, accept_socket=", accept_socket,", thread index=", thread.index(), "\r\n");
  if (not accept_socket) then
    return;
  end;
  local response = "Welecome!\r\n";
  local err_code, sent_len = socket.send(accept_socket, response, timeout);
  print("socket.send ", err_code, ", ", sent_len, "\r\n");
	
  local timeout = 6000000;-- '< 0' means wait for ever; '0' means not wait; '> 0' is the timeout milliseconds
  print("Waiting request data from client, timeout =", timeout, ", ...\r\n");
  local err_code, client_req = socket.recv(accept_socket, timeout);
  print("socket.recv(), err_code=", err_code, "\r\n");
  if ((err_code == SOCK_RST_OK) and client_req) then
	if (printdir()) then
	  os.printstr(client_req);--this can print string larger than 1024 bytes, and also it can print string including '\0'.
    end;
	print("\r\n");
    local response = "OK, BYE\r\n";
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
  print("Exit service_thread, thread index=", thread.index(), "\r\n");
end;

function wait_accept_event(sockfd, timeout)
  local remote_closed = false;
  print("wait_read_event, sockfd=", sockfd, ", timeout=", timeout, "\r\n");
  local start_tick = os.clock();
  while (true) do
    local cur_tick = os.clock();
	timeout = timeout - (cur_tick - start_tick)*1000;
	if (timeout < 0) then
	  timeout = 0;
	end;
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(timeout);
	if (evt and evt >= 0) then
	  print("waited evt: ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	  collectgarbage();
	end;
    if (evt and evt == SOCKET_EVENT) then
	  local sock_or_net_event = evt_p1;--0=>network event, usually ("LOST NETWORK"); 1=>socket event.
	  local evt_sockfd = evt_p2;
	  local event_mask = evt_p3;
	  if ((sock_or_net_event == 1) and (evt_sockfd == sockfd) and (bit.band(event_mask,SOCK_CLOSE_EVENT) ~= 0)) then
	    --socket closed by remote side
		remote_closed = true;
	    print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	    return false, remote_closed;
      elseif ((sock_or_net_event == 1) and (evt_sockfd == sockfd) and (bit.band(event_mask,SOCK_ACCEPT_EVENT) ~= 0)) then
	    print("waited ACCEPT event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	    return true, remote_closed;
	  end;
	end;
	local cur_tick = os.clock();
	if ((cur_tick - start_tick)*1000 >= timeout) then
	  break;
	end;
  end;
  return false, remote_closed;
end;
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

SOCKET_EVENT = 22

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
    socket.select(socket_fd, SOCK_CLOSE_EVENT);--care for close event
	socket.select(socket_fd, SOCK_ACCEPT_EVENT);--care for accept event, IMPORTANT!!! this will let socket notify ACCEPT event.
    print("listening on \"",local_ip_addr,":",listening_port,"\"...\r\n");
    local timeout = 6000000;-- '< 0' means wait for ever; '0' means not wait; '> 0' is the timeout milliseconds
	while (true) do
	  local got_accept_event = wait_accept_event(socket_fd, timeout);
	  if (got_accept_event) then
	    local err_code, accept_socket, client_ip, client_port = socket.accept(socket_fd, 0);--not wait
		socket.select(socket_fd, SOCK_ACCEPT_EVENT);--care for ACCEPT event set again. must be called after each socket.accept()
	    if (err_code == SOCK_RST_OK) then
	      print("the accepted socket fd is ", accept_socket, "\r\n");
		  local service_thrd = thread.create(service_thread);
		  if (service_thrd) then
		    thread.run(service_thrd, accept_socket);
		  else
		    print("ERROR! Create thread failed\r\n");
		    if (not socket.close(accept_socket)) then
              print("failed to close accepted socket\r\n");
            else
              print("close accepted socket succeeded\r\n");
            end;
		  end;
	    end;
	  end;
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
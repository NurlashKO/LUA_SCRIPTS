function consumer(a, b)
  print("consumer called ", a, " ", b, "\r\n");
  print("thread id=", thread.identity(), "\r\n");
  --thread.setpri(thread.identity(), 3);
  --vmstarttimer(2,2000, 1, nil, 100, 101);
  vmstarttimer(2,2000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(99999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
      print("consumer evt=", evt, ", evt_p1=", evt_p1, ", evt_p2=", evt_p2, " evt_p3=", evt_p3, ", evt_clock=", evt_clock,"\r\n");
	  if (evt == 38) then
	    break;--exit the thread
	  end;
    end;
	--[[if (evt_count >= 10) then
	  break;
	end;]]
  end;
  print("exit consumer\r\n");
end;

function producer(t_consumer, a, b)
  print("producer called ", t_consumer, " ", a, " ", b, "\r\n");
  print("thread id=", thread.identity(), "\r\n");
  for idx = 1, 10, 1 do
    print("producer ", idx, " set evt\r\n");
	thread.setevt(t_consumer, 32, 1, 2, 3);
	thread.sleep(1000);
  end;
  print("exit producer\r\n");
end;

function func3(a, b)  
  print("func3 called ", a, " ", b, "\r\n");
  print("thread id=", thread.identity(), "\r\n");
  for idx = 1, 10, 1 do
    local start_clock = os.clock();
    local rst = thread.enter_cs(1);
	local current_clock = os.clock();
	print("func3 result of enter_cs = ", rst, ", used time = ", (current_clock - start_clock), "\r\n");
	global_value_test = global_value_test + 1;
	rst = thread.leave_cs(1);
	print("func3 result of leave cs=", rst, "\r\n");
    print("func3 ", idx, " running\r\n");
	thread.sleep(1000);
  end;
  print("exit func3\r\n");  
end;

function func4(a, b)  
  print("func4 called ", a, " ", b, "\r\n");
  print("thread id=", thread.identity(), "\r\n");
  for idx = 1, 10, 1 do
    local start_clock = os.clock();
    local rst = thread.enter_cs(1);
	local current_clock = os.clock();
	print("func4 result of enter_cs = ", rst, ", used time = ", (current_clock - start_clock), "\r\n");
	global_value_test = global_value_test + 2;
	rst = thread.leave_cs(1);
	print("func4 result of leave cs=", rst, "\r\n");
    print("func4 ",idx, " ===>");
    rst = sio_send("AT+CSUB\r\n");
	rsp = sio_recv(5000);
	print("func4 here\r\n");
	thread.sleep(1000);
  end;
  print("exit func4\r\n");  
end;

function sio_send(cmd)
  print(">>>>>>>>>>>>>>", cmd);
  result = sio.send(cmd);
  return result;
end;

function sio_recv(timeout)  
  local rsp = sio.recv(timeout);
  if (rsp) then
    print("<<<<<<<<<<<<<<", rsp);
  end;
  return rsp;
end;

function start_threads()
  local t1 = thread.create(consumer);
  local t2 = thread.create(producer);
  local t3 = thread.create(func3);
  local t4 = thread.create(func4);
  thread.run(t1, 2, 3);
  thread.run(t2, t1, 6, 7);
  thread.run(t3, 8,9);
  thread.run(t4, 11,12);
  thread.sleep(6000);
  thread.stop(t3);
  --vmsleep(6000);
  print("main set evt 38 to thread1\r\n");
  thread.setevt(t1, 38, 1, 2, 3);
  --wait for thread 1 to end
  while (thread.running(t1) or thread.running(t2) or thread.running(t3) or thread.running(t4)) do
    thread.sleep(100);
  end;
  print("all sub-threads ended\r\n");
end;

printdir(1);
collectgarbage();

sio_send("ATE0\r\n")
rsp = sio_recv(5000);

global_value_test = 0;
main_id = thread.identity();
print("main_id=", main_id, "\r\n");

start_threads();

sio_send("ATI\r\n")
rsp = sio_recv(5000);
print(rsp);

sio_send("ATE1\r\n")
rsp = sio_recv(5000);
print("exit main thread\r\n");
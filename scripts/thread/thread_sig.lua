function thread1_func()
  thread.enter_cs(0);
  print("thread1_func called\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread1_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  local evt_count = 0;
  
  local all_sigs = 0x1 + 0x2 + 0x4;
  thread.signal_clean(all_sigs);
  while (true) do
    local waited_sigs = thread.signal_wait(all_sigs, 5000);--the waited mask may contain multiple bits, each bit needs to be checked using bit.band()
    if (waited_sigs and waited_sigs > 0) then
	  if (bit.band(waited_sigs, 1) ~= 0) then
	    --process signal 1
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 2) ~= 0) then
	    --process signal 2
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 4) ~= 0) then
	    --process signal 4
		evt_count = evt_count + 1;
	  end;
	  thread.enter_cs(0);
      print("thread1 got signal ", waited_sigs, ",(",evt_count, ")\r\n");
	  thread.leave_cs(0);
	  if (evt_count >= 20) then
	    break;--exit the thread
	  end;
	else
	  thread.enter_cs(0);
	  print("thread1 not received any signal\r\n");
	  thread.leave_cs(0);
    end;
	--[[if (evt_count >= 10) then
	  break;
	end;]]
  end;
  print("exit thread1_func\r\n");
end;

function thread2_func(t_receiver)
  thread.enter_cs(0);
  print("thread2_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread2_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(1,800, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread2 set signal now\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 1);
	else
	  thread.enter_cs(0);
	  print("thread2 not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread2_func\r\n");
end;

function thread3_func(t_receiver)  
  thread.enter_cs(0);
  print("thread3_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread3_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(2,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread3 set signal now\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 4);
	else
	  thread.enter_cs(0);
	  print("thread3 not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread3_func\r\n");
end;

function start_threads()
  local t1 = thread.create(thread1_func);
  local t2 = thread.create(thread2_func);
  local t3 = thread.create(thread3_func);
  
  thread.run(t1);
  while (not thread.running(t1)) do
    vmsleep(10);
  end;
  thread.run(t2, t1);
  thread.run(t3, t1);

  --wait for threads to end
  while (thread.running(t1) or thread.running(t2) or thread.running(t3)) do
    thread.sleep(100);
  end;
  thread.free(t1);
end;

printdir(1);

global_value_test = 0;
main_thread = thread.identity();
thread.enter_cs(0);
print("main_thread=", main_thread, "\r\n");
thread.leave_cs(0);
for i = 1, 1, 1 do
  thread.enter_cs(0);
  print("start thread signal test ", i, "\r\n");
  thread.leave_cs(0);
  start_threads();
end;
thread.enter_cs(0);
print("exit main thread\r\n");
thread.leave_cs(0);
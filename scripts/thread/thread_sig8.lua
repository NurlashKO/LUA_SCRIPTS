function receiver_func()
  thread.enter_cs(0);
  print("receiver_func called\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("receiver_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  local evt_count = 0;
  
  local all_sigs = 1 + 2 + 4 +8 +16 + 32 + 64 + 128;
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
	  if (bit.band(waited_sigs, 8) ~= 0) then
	    --process signal 8
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 16) ~= 0) then
	    --process signal 16
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 32) ~= 0) then
	    --process signal 32
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 64) ~= 0) then
	    --process signal 64
		evt_count = evt_count + 1;
	  end;
	  if (bit.band(waited_sigs, 128) ~= 0) then
	    --process signal 128
		evt_count = evt_count + 1;
	  end;
      
	  thread.enter_cs(0);
      print("receiver_func got signal ", waited_sigs, ",(",evt_count, ")\r\n");
	  thread.leave_cs(0);
	  if (evt_count >= 80) then
	    break;--exit the thread
	  end;
	else
	  thread.enter_cs(0);
	  print("receiver_func not received any signal\r\n");
	  thread.leave_cs(0);
    end;
	--[[if (evt_count >= 10) then
	  break;
	end;]]
  end;
  print("exit receiver_func\r\n");
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
      print("thread2_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 1);
	else
	  thread.enter_cs(0);
	  print("thread3_func not received any event\r\n");
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
      print("thread3_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 2);
	else
	  thread.enter_cs(0);
	  print("thread3_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread3_func\r\n");
end;

function thread4_func(t_receiver)  
  thread.enter_cs(0);
  print("thread4_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread4_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(3,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread4_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 4);
	else
	  thread.enter_cs(0);
	  print("thread4_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread4_func\r\n");
end;

function thread5_func(t_receiver)  
  thread.enter_cs(0);
  print("thread5_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread5_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(4,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread5_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 8);
	else
	  thread.enter_cs(0);
	  print("thread5_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread5_func\r\n");
end;

function thread6_func(t_receiver)  
  thread.enter_cs(0);
  print("thread6_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread6_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(5,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread6_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 16);
	else
	  thread.enter_cs(0);
	  print("thread6_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread6_func\r\n");
end;

function thread7_func(t_receiver)  
  thread.enter_cs(0);
  print("thread7_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread7_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(6,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread7_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 32);
	else
	  thread.enter_cs(0);
	  print("thread7_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread7_func\r\n");
end;

function thread8_func(t_receiver)  
  thread.enter_cs(0);
  print("thread8_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread8_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(7,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread8_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 64);
	else
	  thread.enter_cs(0);
	  print("thread8_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread8_func\r\n");
end;

function thread9_func(t_receiver)  
  thread.enter_cs(0);
  print("thread9_func called ", t_receiver, "\r\n");
  thread.leave_cs(0);
  thread.enter_cs(0);
  print("thread9_func, thread id=", thread.identity(), "\r\n");
  thread.leave_cs(0);
  vmstarttimer(8,1000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  thread.enter_cs(0);
      print("thread9_func set signal now(",evt_count,")\r\n");
	  thread.leave_cs(0);
	  thread.signal_notify(t_receiver, 128);
	else
	  thread.enter_cs(0);
	  print("thread9_func not received any event\r\n");
	  thread.leave_cs(0);
    end;
	if (evt_count >= 10) then
	  break;
	end;
  end;
  print("exit thread9_func\r\n");
end;

function start_threads()
  local t1 = thread.create(receiver_func);
  local t2 = thread.create(thread2_func);
  local t3 = thread.create(thread3_func);
  local t4 = thread.create(thread4_func);
  local t5 = thread.create(thread5_func);
  local t6 = thread.create(thread6_func);
  local t7 = thread.create(thread7_func);
  local t8 = thread.create(thread8_func);
  local t9 = thread.create(thread9_func);
  
  thread.run(t1);
  while (not thread.running(t1)) do
    vmsleep(10);
  end;
  thread.run(t2, t1);
  thread.run(t3, t1);
  thread.run(t4, t1);
  thread.run(t5, t1);
  thread.run(t6, t1);
  thread.run(t7, t1);
  thread.run(t8, t1);
  thread.run(t9, t1);

  --wait for threads to end
  while (thread.running(t1) or thread.running(t2) or thread.running(t3) 
  or thread.running(t4) or thread.running(t5) or thread.running(t6) 
  or thread.running(t7) or thread.running(t8) or thread.running(t9)) do
    thread.sleep(100);
  end;  
end;

printdir(1);
collectgarbage();

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
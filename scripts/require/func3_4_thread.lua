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
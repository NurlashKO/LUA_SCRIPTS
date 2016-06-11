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
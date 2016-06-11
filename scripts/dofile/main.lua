dofile("c:\\sio_util.lua");
dofile("c:\\customer_thread.lua");
dofile("c:\\producer_thread.lua");
dofile("c:\\func3_4_thread.lua");

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
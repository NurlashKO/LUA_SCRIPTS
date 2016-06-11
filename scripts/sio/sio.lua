printdir(1)
--vmsleep(10000)
vmsetpri(3);
cmd = "ATE0\r\n"
sio.send(cmd)
--receive response with 5000 ms time out
rsp = sio.recv(5000)  
print(rsp)

cmd = "ATI\r\n";
--clear sio recv cache
sio.clear()  
sio.send(cmd)
rsp = sio.recv(5000)
print(rsp)
--reportte(rsp)
count = 0;
while (count < 10) do
  count = count + 1;
  cmd = "ATI\r\n";
  sio.send(cmd)
  evt, evt_p1, evt_p2, evt_p3, evt_clock = waitevt(99999);
  print("evt=", evt, ", evt_p1=", evt_p1, "\r\n");
  rsp = sio.recv(5000) 
  print(rsp) 
  --reportte(rsp)
  vmsleep(500)
  sio.clear();
end

cmd = "ATE1\r\n"
sio.send(cmd)
--receive response with 5000 ms time out
rsp = sio.recv(5000)  
print(rsp)
--------------------------------------------------------------------------------
--测试说明
--本脚本测试模块启动后自动运行autorun.lua的功能
--------------------------------------------------------------------------------
--this file should be put in FS as 'c:\autorun.lua'
printdir(1)
--vmsleep(10000)
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

while true do
  cmd = "ATI\r\n";
  sio.send(cmd)
  rsp = sio.recv(5000) 
  print(rsp) 
  vmsleep(2000)
end
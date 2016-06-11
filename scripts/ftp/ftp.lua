--------------------------------------------------------------------------------
--测试说明
--本脚本测试FTP操作函数功能
--1. 在模块/MultiMedia/Picture/下放一个图片normal.jpg
--------------------------------------------------------------------------------
printdir(1)

-------------------------------------------------------------------
--CONFIGURATION SECTION
pdp_apn = "cmnet";
server = "e-device.net";
port = 990;
name = "jin.song";
pass = "123456";
remote_file = "/up_normal.jpg";
uplocal_file = "c:\\Picture\\normal.jpg";
downlocal_file = "c:\\Video\\down_normal.jpg";
passive = 1;
test_put_count = 3;
put_suc_count = 0;
get_suc_count = 0;
--------------------------------------------------------------------

print("---------------------begin test---------------------\r\n");

collectgarbage();
sio.clear();
sio.send("ATE0\r\n")
rsp = sio.recv(5000);
print(rsp);    

cmd = string.format("AT+CGSOCKCONT=1,\"IP\",\"%s\"\r\n",pdp_apn);
print(">>>>>>>>>>>>>>", cmd);
sio.send(cmd);
rsp = sio.recv(5000);
print(rsp);  

  
count = 0;
while (count < test_put_count) do
  count = count+1;
  print("-------------------run count=",count,"\r\n");
  local put_suc = false;
  print("begin testing ftp.simpput(...) function\r\n");
  rst = ftp.simpput(server, port, name, pass, remote_file, uplocal_file, passive);
  
  if (rst ~= 0) then
    print("ftp.simpput failed, rst = ", rst,"\r\n");
  else
    print("ftp.simpput succeeded\r\n");
    put_suc = true;
    put_suc_count = put_suc_count + 1;
  end;
  
  
  if (put_suc) then
    vmsleep(8000);
    print("begin testing ftp.simpget(...) function\r\n");
    rst = ftp.simpget(server, port, name, pass, remote_file, downlocal_file, passive);
    
    if (rst ~= 0) then
      print("ftp.simpget failed, rst = ", rst,"\r\n");
    else
      print("ftp.simpget succeeded\r\n");
      get_suc_count = get_suc_count+1;
    end;	
  end;
  vmsleep(8000);
end;
sio.send("ATE1\r\n")
rsp = sio.recv(5000);
print(rsp);  
print("tested_count: ",count, "\r\nput_suc_count: ", put_suc_count, "\r\nget_suc_count: ", get_suc_count,"\r\n"); 
print("---------------------finished test---------------------\r\n");
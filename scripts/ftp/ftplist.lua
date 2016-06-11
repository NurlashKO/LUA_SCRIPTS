--------------------------------------------------------------------------------
--测试说明
--本脚本测试FTP操作函数功能
--1. 在模块/MultiMedia/Picture/下放一个图片normal.jpg
--------------------------------------------------------------------------------
printdir(1)

-------------------------------------------------------------------
--CONFIGURATION SECTION
pdp_apn = "3gnet";
server = "180.166.164.118";
port = 990;
name = "jin.song";
pass = "123456";
remote_path = "/";
passive = 1;
test_list_count = 1;
list_suc_count = 0;
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
while (count < test_list_count) do
  count = count+1;
  print("-------------------run count=",count,"\r\n");
  local put_suc = false;
  print("begin testing ftp.simplist(...) function\r\n");
  rst, list_data = ftp.simplist(server, port, name, pass, remote_path, passive);
  
  if (rst ~= 0) then
    print("ftp.simplist failed, rst = ", rst,"\r\n");
  else
    print("ftp.simplist succeeded\r\n");
	if (not list_data) then
	  list_data = "";
	end;
	print("list data=(len=", string.len(list_data), ")\r\n");
	print(list_data, "\r\n");
    list_suc_count = list_suc_count + 1;
  end;
end;
sio.send("ATE1\r\n")
rsp = sio.recv(5000);
print(rsp);  
print("tested_count: ",count, "\r\nlist_suc_count: ", list_suc_count,"\r\n"); 
print("---------------------finished test---------------------\r\n");
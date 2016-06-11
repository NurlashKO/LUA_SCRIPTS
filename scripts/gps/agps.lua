--------------------------------------------------------------------------------
--测试说明
--本脚本测试GPS操作函数
--测试AGPS时，注意要先AT+CGSOCKCONT设置APN
--------------------------------------------------------------------------------

function show_gps_mode_string()
  mode=gps.gpsgetmode();
  
  if(mode == 1) then
    print("---current mode is standalone!---\r\n");
  elseif(mode == 2) then
    print("---current mode is MSB!---\r\n");
  elseif(mode == 3) then
    print("---current mode is MSA!---\r\n");
  end;  
  return;
end 

function show_gps_ssl_string()
  ssl=gps.gpsgetssl();

  if(ssl == 0) then
    print("---current ssl is enable!---\r\n");
  elseif(ssl == 1) then
    print("---current ssl is disable!---\r\n");
  end;  
  return;
end 

function show_gps_url_string()
  url=gps.gpsgeturl();
  
  if(url) then
    print("---current url is ", url, "!---\r\n");
  else
    print("---current url is nil!\r\n");
  end;  
  return;
end 

-------------------------------------------------------------------
--CONFIGURATION SECTION
test_coldstart_loop_count = 30;
--------------------------------------------------------------------------------

printdir(1)
print("---------------------GPS begin test---------------------\r\n");
------------MSA模式----------------
g_mode = gps.gpsgetmode();
if(g_mode ~= 3) then
  s_mode = gps.gpssetmode(3);
  if(not s_mode) then
    print("---GPS Mode setting error!---\r\n");
    return;
  end;
end;  
show_gps_mode_string();

vmsleep(1000);
------------设置URL----------------

g_url = gps.gpsgeturl();
equal = string.equal(g_url, "sls1.sirf.com:7276", 1);
if(not equal) then  
  gs_url = gps.gpsseturl("sls1.sirf.com:7276");
end;
show_gps_url_string();

vmsleep(1000);
------------设置SSL----------------
g_ssl = gps.gpsgetssl();
if(g_ssl ~= 0) then
  s_ssl = gps.gpssetssl(0);
  print(s_ssl,"\r\n");
end;  
show_gps_ssl_string();

vmsleep(1000);
------------冷启动----------------
start = gps.gpsstart(2)
if(start == true) then
  print("--------------GPS coldstart success!--------------\r\n")
end;
count = 0;
while (count < test_coldstart_loop_count) do
  count = count+1;
  print("-------------------run count=",count,"-----------\r\n");
  fix = gps.gpsinfo();
  print(fix,"\r\n");
  if(string.len(fix) ~= 0) then
    print("-------------GPS fix success!-------------\r\n\r\n");
    count = 60;
  end;
  vmsleep(1000);
end;
close = gps.gpsclose();
if(close == true) then
  print("-------------GPS colse success!-------------\r\n");
end;

vmsleep(3000);
------------MSB模式----------------
g_mode = gps.gpsgetmode();
if(g_mode ~= 2) then
  s_mode = gps.gpssetmode(2);
  if(not s_mode) then
    print("---GPS Mode setting error!---\r\n");
    return;
  end;
end;  
show_gps_mode_string();

vmsleep(1000);
------------冷启动----------------
start = gps.gpsstart(2)
if(start == true) then
  print("--------------GPS coldstart success!--------------\r\n")
end;
count = 0;
while (count < test_coldstart_loop_count) do
  count = count+1;
  print("-------------------run count=",count,"-----------\r\n");
  fix = gps.gpsinfo();
  print(fix,"\r\n");
  vmsleep(1000);
end;
close = gps.gpsclose();
if(close == true) then
  print("-------------GPS colse success!-------------\r\n");
end;
print("---------------------GPS finished test---------------------\r\n");
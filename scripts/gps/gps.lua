--------------------------------------------------------------------------------
--测试说明
--本脚本测试GPS操作函数
--冷启动运行60秒，热启动运行30秒
--------------------------------------------------------------------------------
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

-------------------------------------------------------------------
--CONFIGURATION SECTION
test_coldstart_loop_count = 60;
test_hotstart_loop_count = 30;

printdir(1)
print("---------------------GPS begin test---------------------\r\n");
------------STANDALONE模式----------------
g_mode = gps.gpsgetmode();
if(g_mode ~= 1) then
  s_mode = gps.gpssetmode(1);
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
  print(fix,"\r\n","\r\n");
  vmsleep(1000);
end;
close = gps.gpsclose();
if(close == true) then
  print("-------------GPS colse success!-------------\r\n");
end;

print("\r\n-------------------waiting 10s for hotstart--------------------\r\n\r\n");
vmsleep(10000);

------------热启动----------------
start = gps.gpsstart(1);
if(start == true) then
  print("-------------GPS hotstart success!-------------\r\n")
end;
count = 0;
while (count < test_hotstart_loop_count) do
  count = count+1;
  print("-------------------run count=",count,"-----------\r\n");
  fix = gps.gpsinfo()
  print(fix,"\r\n","\r\n")
  vmsleep(1000)
end;
close = gps.gpsclose()
if(close == true) then
  print("-------------GPS colse success!-------------\r\n");
end;
print("---------------------GPS finished test---------------------\r\n");
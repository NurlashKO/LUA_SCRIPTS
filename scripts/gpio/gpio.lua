--------------------------------------------------------------------------------
--测试说明
--本脚本测试GPIO操作函数
--------------------------------------------------------------------------------
-------------------------------------------------------------------
--CONFIGURATION SECTION
test_loop_count = 3;
--------------------------------------------------------------------------------
printdir(1)
print("---------------------begin test---------------------\r\n");
count = 0;
while (count < test_loop_count) do
  count = count+1;
  print("-------------------run count=",count,"\r\n");
  gio = gpio.getv(2);
  print(gio,"\r\n");
  rst = gpio.setv(2,0);
  print(rst,"\r\n");
  rst = gpio.settrigtype(0,1);
  print(rst,"\r\n");
  rst = gpio.setdrt(5,1);
  print(rst,"\r\n");
end;
print("---------------------finished test---------------------\r\n");
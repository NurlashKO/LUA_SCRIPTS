--------------------------------------------------------------------------------
--测试说明
--本脚本测试event操作功能，event相关函数主要用于以后的扩展，用于处理模块内部产生的事件
--------------------------------------------------------------------------------
printdir(1)

--set event 8 with priority 100(the highest)
setevtpri(8,100);
--set event 9 with priority 0(the lowest)
setevtpri(9,0);
clearevts();
setevt(31,1,2,3);
setevt(31,4,5,6);
setevt(31,7,8,9);
evt, param1, param2, param3 = waitevt();
print(evt,"( ", param1, " ", param2, " ", param3, "\r\n");
evt, param1, param2, param3 = waitevt(0);
print(evt,"( ", param1, " ", param2, " ", param3, "\r\n");
evt, param1, param2, param3 = waitevt(0);
print(evt,"( ", param1, " ", param2, " ", param3, "\r\n");
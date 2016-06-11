--------------------------------------------------------------------------------
--测试说明
--本脚本测试os库的os.data(), os.time()和os.clock()函数功能
--------------------------------------------------------------------------------
printdir(1)

rsp = os.date();
print("os.date()=", rsp,"\r\n");

cur_time = os.time();
print("os.time()=", cur_time,"\r\n");

rsp = os.clock();
print("os.clock()=", rsp,"\r\n");

dt = os.date("*t");
print("os.date(\"*t\")= ",dt.year, "-", dt.month, "-", dt.day, " ", dt.hour, ":", dt.min, ":", dt.sec, "\t", dt.wday, " wdays,\t", dt.yday, " ydays\r\n");

rsp = os.date("!%c");
print("os.date(\"!%c\")= ", rsp,"\r\n");

rsp = os.date("!%c", cur_time);
print("os.date(\"!%c\",", cur_time, ")= ", rsp,"\r\n");

rsp = os.date("%c", cur_time);
print("os.date(\"%c\",", cur_time, ")= ", rsp,"\r\n");

dt = os.date("*t", cur_time);
print("os.date(\"*t\",", cur_time, ")= ", dt.year, "-", dt.month, "-", dt.day, " ", dt.hour, ":", dt.min, ":", dt.sec, "\t", dt.wday, " wdays,\t", dt.yday, " ydays\r\n");

rsp = os.time({year=dt.year,month=dt.month,day=dt.day,hour=dt.hour,min=dt.min,sec=dt.sec}) ;
print("os.time({year=",dt.year,",month=",dt.month,",day=",dt.day,",hour=",dt.hour,",min=",dt.min,",sec=",dt.sec,"}) = ", rsp,"\r\n");

dt = os.date("!*t");
print("os.date(\"!*t\")= ",dt.year, "-", dt.month, "-", dt.day, " ", dt.hour, ":", dt.min, ":", dt.sec, "\t", dt.wday, " wdays,\t", dt.yday, " ydays\r\n");

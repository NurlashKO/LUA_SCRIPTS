printdir(1)

--[[
for each thread, it may has up to 10 event filters.
]]

local stat_evt, evt_count, stat_evt_p1, filter_index, max_allow_count, replace_oldest, filter_evt, filter_evt_p1;

max_allow_count = 2;
replace_oldest = true;
filter_evt = 31;
filter_evt_p1 = 4;
filter_index = thread.addevtfilter(max_allow_count, replace_oldest, filter_evt,filter_evt_p1, nil, nil);
print("filter_index=", filter_index, "\r\n");

filter_evt = 5;
max_allow_count = 1;
filter_index = thread.addevtfilter(max_allow_count, replace_oldest, filter_evt);
print("filter_index=", filter_index, "\r\n");


-------------------------------------------------------------------------
--set event 8 with priority 100(the highest)
setevtpri(8,100);

--set event 9 with priority 0(the lowest)
setevtpri(9,0);
clearevts();
setevt(31,1,2,3);
setevt(5,7,8,9);
setevt(31,4,5,6);
setevt(5,7,7,9);
setevt(32,7,8,9);
setevt(31,7,8,9);
setevt(5,6,7,9);
setevt(31,4,8,7);
setevt(5,7,3,2);
setevt(31,4,7,7);
-------------------------------------------------------------------------
stat_evt = 5;
evt_count = getevtcount(stat_evt);
print("evt_count[", stat_evt, "]=", evt_count, "\r\n");

stat_evt = 31;
evt_count = getevtcount(stat_evt);
print("evt_count[", stat_evt, "]=", evt_count, "\r\n");

stat_evt = 31;
stat_evt_p1 = 4;
evt_count = getevtcount(stat_evt, stat_evt_p1);
print("evt_count[", stat_evt, ",", stat_evt_p1, "]=", evt_count, "\r\n");


stat_evt = 31;
stat_evt_p1 = 4;
print("delete event[",stat_evt,",",stat_evt_p1,"]\r\n");
deleteevt(1, stat_evt, stat_evt_p1, nil, nil);
evt_count = getevtcount(stat_evt, stat_evt_p1);
print("evt_count[", stat_evt, ",", stat_evt_p1, "]=", evt_count, "\r\n");

evt_count = getevtcount(stat_evt);
print("evt_count[", stat_evt, "]=", evt_count, "\r\n");

evt_count = getevtcount();
print("total evt_count=", evt_count, "\r\n");


evt, param1, param2, param3 = waitevt();
print(evt,"( ", param1, " ", param2, " ", param3, ")\r\n");
evt, param1, param2, param3 = waitevt(0);
print(evt,"( ", param1, " ", param2, " ", param3, ")\r\n");
evt, param1, param2, param3 = waitevt(0);
print(evt,"( ", param1, " ", param2, " ", param3, ")\r\n");

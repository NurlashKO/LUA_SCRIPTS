printdir(1);

local result = network.set_dns_timeout_param(0, 30000, 5);--network retry open times = 0(maximum is 3), network open timeout is 30 seconds, maximum DNS query times is 5

--[[
local cid = 2;
print("resolve dns with cid=", cid, "\r\n");
local ip_address = network.resolve("www.baidu.com", cid);
print("resolve addr=", ip_address, "\r\n");

cid = 1;
print("resolve dns with cid=", cid, "\r\n");
ip_address = network.resolve("www.baidu.com", cid);
print("resolve addr=", ip_address, "\r\n");

cid = 0;--default 0 means using AT+CSOCKSETPN setting.
print("resolve dns with cid=", cid, "\r\n");
ip_address = network.resolve("www.baidu.com", cid);
print("resolve addr=", ip_address, "\r\n");
]]

local cid = 1;--0=>use setting of AT+CSOCKSETPN. 1-16=>use self defined cid
local timeout = 30000;--  '<= 0' means wait for ever; '> 0' is the timeout milliseconds
local app_handle = network.open(cid, timeout);--!!! If the PDP for cid is already opened by other app, this will return a reference to the same PDP context.
if (not app_handle) then
  print("faield to open network\r\n");
  return;
end;
--[[
If the cid parameter is the same as the network.open(), the network.resolve() will use the same PDP activated using network.open(), 
or else the network.resolve() will activate new PDP context by itself.
]]
print("resolve dns with cid=", cid, "\r\n");
ip_address = network.resolve("www.baidu.com", cid);
print("resolve addr=", ip_address, "\r\n");

----------------------------------------------------
--TEST DNS SERVER ADDRESS QUERY AND CHANGE DNS SERVER ADDRESS
local primary_dns_address = network.primary_dns(app_handle);
print("Primary DNS address is ", primary_dns_address, "\r\n");

local secondary_dns_address = network.secondary_dns(app_handle);
print("Secondary DNS address is ", secondary_dns_address, "\r\n");

result = network.change_primary_dns(app_handle, "210.22.84.3");
print("Change primary DNS address, result=", result, "\r\n");

result = network.change_secondary_dns(app_handle, "210.22.70.3");
print("Change secondary DNS address, result=", result, "\r\n");

primary_dns_address = network.primary_dns(app_handle);
print("After change, primary DNS address is ", primary_dns_address, "\r\n");

secondary_dns_address = network.secondary_dns(app_handle);
print("After change, secondary DNS address is ", secondary_dns_address, "\r\n");
----------------------------------------------------

--[[
If the cid parameter is the same as the network.open(), the network.resolve() will use the same PDP activated using network.open(), 
or else the network.resolve() will activate new PDP context by itself.
]]
print("resolve dns with cid=", cid, "\r\n");
ip_address = network.resolve("www.baidu.com", cid);
print("resolve addr=", ip_address, "\r\n");

print("closing network...\r\n");
result = network.close(app_handle);
print("network.close(), result=", result, "\r\n");
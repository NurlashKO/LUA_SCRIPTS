printdir(1);
print("power off now...");
vmsleep(100);

local bforce = false;--when using bforce=true, the module does not notify network of powering off/reset, this is not correct power off/reset in 3GPP test.
os.do_poweroff(bforce);
while (true) do
  print("hello\r\n");
  vmsleep(2000);
end;

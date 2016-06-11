function collect_garbage_thread()
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(1000);--check memory every 1 second
	local curmem = getcurmem();
	print("current mem = ", curmem, " bytes\r\n");
	if (curmem >= 1 * 1024 * 1024) then
	  collectgarbage();
	  curmem = getcurmem();
	  print("After collecting, current mem = ", curmem, " bytes\r\n");
	end;
  end;
end;

printdir(1);
os.printport(3);
local collect_task = thread.create(collect_garbage_thread);
thread.run(collect_task);
while (thread.running(collect_task)) do
  thread.sleep(100);
end;
print("Exit main program\r\n");
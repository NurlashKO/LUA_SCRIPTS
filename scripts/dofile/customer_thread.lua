function consumer(a, b)
  print("consumer called ", a, " ", b, "\r\n");
  print("thread id=", thread.identity(), "\r\n");
  --thread.setpri(thread.identity(), 3);
  vmstarttimer(2,2000, 1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(99999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
      print("consumer evt=", evt, ", evt_p1=", evt_p1, ", evt_p2=", evt_p2, " evt_p3=", evt_p3, ", evt_clock=", evt_clock,"\r\n");
	  if (evt == 38) then
	    break;--exit the thread
	  end;
    end;
	--[[if (evt_count >= 10) then
	  break;
	end;]]
  end;
  print("exit consumer\r\n");
end;
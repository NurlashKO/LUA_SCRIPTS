function usb_test_main()
  local trace_string = "===>USB EVENT:\r\n";
  printdir(1);
  vmstarttimer(1, 5000, 1);
  while ( true ) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = waitevt(9999999);
	if (evt >= 0) then
	  --print("evt=", evt, ", evt_p1=", evt_p1, ", evt_p2=", evt_p2, " evt_p3=", evt_p3, ", evt_clock=", evt_clock,"\r\n");
	  if (evt == 3) then -- usb
	    local evt_string = "EVT: "..evt..", p1="..evt_p1..", p2="..evt_p2..", p3="..evt_p3..", clk="..evt_clock.."\r\n";
		trace_string = trace_string..evt_string;
	  elseif (evt == 28) then
	    if (get_usb_mode() == 3) then
	      print(trace_string, "<===\r\n");
		end;
	  end;
	end;	
  end;	
end;

usb_test_main();
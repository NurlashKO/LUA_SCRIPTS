function reset_external_mcu()
  gpio.setdrt(1);
  gpio.setv(0);
end;
printdir(1)
--const value
TIMER_EVENT = 28
OUT_CMD_EVENT = 31

HEART_BEAT_TIMEOUT = 1 * 60 * 1000;
vmstarttimer(0, HEART_BEAT_TIMEOUT);
while ( true ) do
  evt, evt_param1, evt_param2, evt_param3 = waitevt(15000);
  if (evt >= 0) then
    count = count + 1;
    print("(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
    if ( evt == OUT_CMD_EVENT ) then
	  vmstoptimer(0);
      sendtoport(evt_param1, "This is the confirm\r\n");
	  vmstarttimer(0, HEART_BEAT_TIMEOUT);
	elseif ( (evt == TIMER_EVENT) and (evt_param1 == 0) ) then
	  reset_external_mcu();
    end;
  end;
end;

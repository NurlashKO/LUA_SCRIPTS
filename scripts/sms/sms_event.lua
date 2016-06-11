printdir(1);
collectgarbage();

SMS_EVENT_ID = 26

SMS_EVT_P1_CMTI = 0
SMS_EVT_P1_CDSI = 1

SMS_EVT_P2_ME = 0
SMS_EVT_P2_SM = 1

local result;

result = sms.ready();
print("sms.ready() = ", result, "\r\n");
if (not result) then
  print("SMS not ready now\r\n");
  return;
end;

print("Setting to get +CMTI/+CSDI\r\n");
sms.set_cnmi(2,1)

print("Wait +CMTI or +CDSI now...\r\n");
while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == SMS_EVENT_ID) then
	  local rpt_type = evt_p1;
	  local storage = evt_p2;
	  local index = evt_p3;
      if (rpt_type == SMS_EVT_P1_CMTI) then
	    print("Got CMTI:", ", storage=", storage, ", index=", index, "\r\n");
	  elseif (rpt_type == SMS_EVT_P1_CDSI) then
	    print("Got CDSI:", ", storage=", storage, ", index=", index, "\r\n");
	  end;
	  break;
    end;
end;
function test_nmea_with_filter(filter)
  print("test_nmea_with_filter, filter=", filter, "\r\n");
  gps.gpsstart(1);
  local recv_count = 0;
  nmea.open(filter);
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
	local curmem = getcurmem();
	if (curmem >= 1 * 1024 * 1024) then
	  collectgarbage();
	end;
    if (evt and evt == NMEA_EVENT) then
      local nmea_data = nmea.recv(0);
	  if (nmea_data) then
	    recv_count = recv_count + 1;
	    print("nmea_data, len=", string.len(nmea_data), "\r\n");
	    print(nmea_data);
	    if (recv_count >= 20) then
	      break;
	    end;
	  end;
    end;
  end;
  nmea.close();
  gps.gpsclose();
  print("test_nmea_with_filter, end\r\n");
end;

printdir(1)

NMEA_EVENT = 35

NMEA_FTR_GGA = 1
NMEA_FTR_RMC = 2
NMEA_FTR_GSV = 4
NMEA_FTR_GSA = 8
NMEA_FTR_VTG = 16
NMEA_FTR_PSTIS = 32

NMEA_FTR_ALL = NMEA_FTR_GGA + NMEA_FTR_RMC + NMEA_FTR_GSV + NMEA_FTR_GSA + NMEA_FTR_VTG + NMEA_FTR_PSTIS;

local filter = NMEA_FTR_GGA + NMEA_FTR_RMC;

test_nmea_with_filter(filter);

filter = NMEA_FTR_RMC;
test_nmea_with_filter(filter);

filter = NMEA_FTR_GSA + NMEA_FTR_VTG + NMEA_FTR_PSTIS;
test_nmea_with_filter(filter);

filter = NMEA_FTR_ALL;
test_nmea_with_filter(filter);
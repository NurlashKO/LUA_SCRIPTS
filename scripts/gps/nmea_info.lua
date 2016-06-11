--[[the nmea.getinfo() is a standalone function, 
it has no relation with nmea.open, nmea.close, nmea.recv, nmea.clear]]

function test_nmea_info_with_filter(filter)
  print("test_nmea_info_with_filter, filter=", filter, "\r\n");
  vmstarttimer(1,1000, 1);
  gps.gpsstart(1);
  local evt_count = 0;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(999999);
    if (evt and evt >= 0) then
      evt_count = evt_count + 1;
	  local nmea_info = nmea.getinfo(filter);
      print("nmea_info = \r\n", nmea_info, "\r\n");
	  if (evt_count >= 20) then
	    break;
	  end;
	end;
  end;
  gps.gpsclose();
  vmstoptimer(1);
  print("test_nmea_info_with_filter, end\r\n");
end;

printdir(1)

NMEA_FTR_GGA = 1
NMEA_FTR_RMC = 2
NMEA_FTR_GSV = 4
NMEA_FTR_GSA = 8
NMEA_FTR_VTG = 16
NMEA_FTR_PSTIS = 32

NMEA_FTR_ALL = NMEA_FTR_GGA + NMEA_FTR_RMC + NMEA_FTR_GSV + NMEA_FTR_GSA + NMEA_FTR_VTG + NMEA_FTR_PSTIS;


local filter = NMEA_FTR_GGA + NMEA_FTR_RMC;

test_nmea_info_with_filter(filter);

filter = NMEA_FTR_RMC;
test_nmea_info_with_filter(filter);

filter = NMEA_FTR_GSA + NMEA_FTR_VTG + NMEA_FTR_PSTIS;
test_nmea_info_with_filter(filter);

filter = NMEA_FTR_ALL;
test_nmea_info_with_filter(filter);
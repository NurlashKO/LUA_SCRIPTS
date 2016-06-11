printdir(1)

--const value
GPIO_EVENT  = 0
UART_EVENT  = 1
KEYPAD_EVENT = 2
USB_EVENT = 3
AUDIO_EVENT = 4
TIMER_EVENT = 28
SIO_RCVD_EVENT = 29

--test at+autocsq=1 for sio event
test_sio_event = false;

if (test_sio_event) then
  sio.send("AT+AUTOCSQ=1\r\n");
  rsp = sio.recv(5000);
  print(rsp);
end;

--the minimum value of the second parameter for vmstarttimer(...) is 20ms
vmstarttimer(0,1000);
vmstarttimer(1,2000);
--only generate 1 timer event for timer id 2
vmstarttimer(2,1500,0);
--vmstarttimer(3,5);

count = 0;
while ( true ) do
  if (count >= 20) then
    break;
  end;
  evt, evt_param = waitevt(15000);
  if (evt >= 0) then
    count = count + 1;
    print("\r\n----(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
    if ( evt == TIMER_EVENT ) then
      print("\r\ntimer event occured, timer_id=",evt_param,"\r\n");
    elseif (evt == SIO_RCVD_EVENT) then
      rsp = sio.recv(5000);
      if (rsp) then
        print("\r\nsio event occured: ", rsp,"\r\n");
      end;
    end;
  end;
end;

vmstoptimer(0);
vmstoptimer(1);
vmstoptimer(2);
--vmstoptimer(3);

if (test_sio_event) then
  sio.send("AT+AUTOCSQ=0\r\n");
  rsp = sio.recv(5000);
  print(rsp);
end;
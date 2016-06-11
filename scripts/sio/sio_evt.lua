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
test_autocsq_event = true;

if (test_autocsq_event) then
  sio.send("AT+AUTOCSQ=1\r\n");
  rsp = sio.recv(5000);
  print(rsp);
end;

count = 0;
while ( true ) do
  if (count >= 5) then
    break;
  end;
  evt, evt_param = waitevt(99999999);
  if (evt >= 0) then
    count = count + 1;
    print("(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
    if ( evt == SIO_RCVD_EVENT ) then
      rsp = sio.recv(0);
      if (rsp) then
        print("received rsp: ", rsp);
      end;
    end;
  end;
end;

if (test_autocsq_event) then
  sio.send("AT+AUTOCSQ=0\r\n");
  rsp = sio.recv(5000);
  print(rsp);
end;
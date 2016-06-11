--EXTERNAL<======>ATCTL<======>SIO<======>INNER AT PARSER

--supported port for atctl.setport(...)
ATCTL_UART_PORT  = 1
ATCTL_MODEM_PORT = 2
ATCTL_USBAT_PORT = 3
--  -1 is used to release the port
ATCTL_INVALID_PORT = -1

SIO_EVENT = 29
AT_CTL_EVENT = 30

sio.exclrpt(1);
atctl.setport(ATCTL_USBAT_PORT)
atctl.send("Please input any AT command.\r\n");

count = 0
while (true) do  
  evt, evt_param = waitevt(15000);
  if (evt >= 0) then
    print("occured event=",evt,"\r\n");
    if ( evt == AT_CTL_EVENT ) then
      data = atctl.recv(5000);
      if (data) then
        count = count + 1;
        sio.send(data);
      end;
    elseif ( evt == SIO_EVENT ) then
      data = sio.recv(5000);
	  print("data=", data,"\r\n");
      atctl.send(data);
    end;
  end;
end;
atctl.setport(ATCTL_INVALID_PORT);
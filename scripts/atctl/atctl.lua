--supported port for atctl.setport(...)
ATCTL_UART_PORT  = 1
ATCTL_MODEM_PORT = 2
ATCTL_USBAT_PORT = 3
--  -1 is used to release the port
ATCTL_INVALID_PORT = -1

printdir(1)
--ATTENTION: at+catr and atctl.setport SHOULDN'T be set to the same port, or else the unsolidated result may be sent to the ATCTL port.
atctl.setport(ATCTL_USBAT_PORT)
atctl.send("\r\nplease press any key in the atctl port\r\n");
count = 0;
while (true) do  
  if (count > 5) then
    break;
  end;
  data = atctl.recv(15000);
  if (data) then
    count = count + 1;
    atctl.send("received data from external port:"..data.."\r\n");
  end;
end;
atctl.setport(ATCTL_INVALID_PORT);
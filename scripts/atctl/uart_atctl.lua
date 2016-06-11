--supported port for atctl.setport(...)
ATCTL_UART_PORT  = 1
ATCTL_MODEM_PORT = 2
ATCTL_USBAT_PORT = 3
--  -1 is used to release the port
ATCTL_INVALID_PORT = -1

AT_CTL_EVENT = 30

printdir(1)
os.printport(3);
print("Please press any key in the atctl port\r\n");
--ATTENTION: at+catr and atctl.setport SHOULDN'T set the same port, or else the unsolidated result may be sent to the ATCTL port.
atctl.setport(ATCTL_UART_PORT)

count = 0;
while (true) do  
  if (count > 5) then
    break;
  end;
  evt, evt_param = waitevt(15000);
  if (evt >= 0) then    
    print("\r\n----(count=", count, ")", os.clock(), " event = ", evt, "\r\n");
    if ( evt == AT_CTL_EVENT ) then
      data = atctl.recv(5000);
      if (data) then
        count = count + 1;
        atctl.send("received data from external port:"..data.."\r\n");
        --print cannot be traced to the port used by atctl.setport(...)
        print("---this is reported by print----\r\n");
      end;
    end;
  end;
end;
atctl.setport(ATCTL_INVALID_PORT);
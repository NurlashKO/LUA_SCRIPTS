printdir(1);

--[[
port:
1->uart
2->usb modem
3->usb at
]]

os.printport(3);
print("print from USB-AT port now\r\n");

os.printport(2);
print("print from USB-MODEM port now\r\n");

os.printport(0);
print("print from all port now\r\n");

--os.printport(1);
--print("print from UART port now\r\n");

os.printstr("by default, os.printstr() to os.printport()\r\n");--print from the set port using os.printport()
os.printstr("os.printstr() to USB-AT port now\r\n", 3);--print to USB-AT
os.printstr("os.printstr() to USB-MODEM port now\r\n", 2);--print to USB-MODEM
--os.printstr("os.printstr() to UART port now\r\n", 1);--print to UART
os.printstr("os.printstr() to all now\r\n", 3);--print to UART

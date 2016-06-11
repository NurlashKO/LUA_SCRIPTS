printdir(1);

local reg_status, lac, cell_id = net.creg();
if (lac) then
  lac = string.format("%X", lac);
end;
if (cell_id) then
  cell_id = string.format("%X", cell_id);
end;
print("net.creg()=", reg_status, ",", lac, ",", cell_id, "\r\n");

reg_status, lac, cell_id = net.cgreg();
if (lac) then
  lac = string.format("%X", lac);
end;
if (cell_id) then
  cell_id = string.format("%X", cell_id);
end;
print("net.cgreg()=", reg_status, ",", lac, ",", cell_id, "\r\n");

CNTI_NONE = 0
CNTI_GSM = 1
CNTI_GPRS = 2
CNTI_EGPRS = 3
CNTI_UMTS = 4
CNTI_HSDPA = 5
CNTI_HSUPA = 6
CNTI_HSPA = 7

local cnti_value = net.cnti();
print("net.cnti()=", cnti_value, "\r\n");

local csq = net.csq();
print("net.csq()=", csq, "\r\n");
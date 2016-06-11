function get_pb_dev_info(pb_dev)
  print("get_pb_dev_info, pb_dev=", pb_dev, "\r\n");
  local pb_dev_info = phonebook.info(pb_dev);--get current phone book setting
  if (not pb_dev_info) then
    print("failed to get phonebook information\r\n");
    return;
  end;
  print("pb_dev_info={\r\n");
  print("  dev=", pb_dev_info.storage, "\r\n");
  print("  used=", pb_dev_info.used, "\r\n");
  print("  max=", pb_dev_info.max, "\r\n");
  print("}\r\n");
end;

function write_pb_item(storage, index, phone_number, name)
  --the name field of phonebook.write() depends on the setting AT+CSCS, usually, it is the same as calling AT+CPBW.
  print("write_pb_item, storage=", storage, ", index=", index, ", phone_number=", phone_number, ", name=", name, "\r\n");
  local result = phonebook.write(storage, index, phone_number, name);--if index is nil, write to the first empty slot.
  print("phonebook.write, result=", result, "\r\n");
end;

function read_pb_item(storage, start_index, end_index)
  print("read_pb_item, storage=", storage, ", start_index=", start_index, ", end_index=", end_index, "\r\n");
  local item_list = phonebook.read(storage, start_index, end_index);
  if (not item_list) then
    print("failed to read pb item\r\n");
	return;
  end;
  print("item_list={\r\n");
  if (printdir()) then
    os.printstr(item_list);
  end;
  print("}\r\n");
end;

function findname_pb_item(storage, name, match_type, case_sensitive)
  print("findname_pb_item, storage=", storage, ", name=", name, ", match_type=", match_type, ",case_sensitive=", case_sensitive, "\r\n");
  --!!!ATTENTION: The phonebook.findphone()/phonebook.findname cannot be used in multiple threads concurrently.
  local item_list = phonebook.findname(storage, name, match_type, case_sensitive);
  if (not item_list) then
    print("failed to find pb item using name\r\n");
	return;
  end;
  print("item_list={\r\n");
  if (printdir()) then
    os.printstr(item_list);
  end;
  print("}\r\n");
end;

function findphone_pb_item(storage, phone_num, match_type)
  print("findphone_pb_item, storage=", storage, ", phone_num=", phone_num, ", match_type=", match_type, "\r\n");
  --!!!ATTENTION: The phonebook.findphone()/phonebook.findname cannot be used in multiple threads concurrently.
  local item_list = phonebook.findphone(storage, phone_num, match_type);
  if (not item_list) then
    print("failed to find pb item using phone number\r\n");
	return;
  end;
  print("item_list={\r\n");
  if (printdir()) then
    os.printstr(item_list);
  end;
  print("}\r\n");
end;

printdir(1);

CSCS_IRA=0
CSCS_GSM=1
CSCS_UCS2=2

PB_DEV_DC = 0;
PB_DEV_MC = 1;
PB_DEV_RC = 2;
PB_DEV_SM = 3;
PB_DEV_ME = 4;
PB_DEV_FD = 5;
PB_DEV_ON = 6;
PB_DEV_LD = 7;
PB_DEV_EN = 8;
PB_DEV_SN = 9;

if (not phonebook.ready()) then
  print("phonebook not ready\r\n");
  return;
end;

os.set_cscs(CSCS_IRA);

for dev = PB_DEV_DC, PB_DEV_SN, 1 do
  get_pb_dev_info(dev);
end;

local test_write_dev = PB_DEV_ME;
write_pb_item(test_write_dev, 1, "10086", "china mobile");
write_pb_item(test_write_dev, nil, "10010", "china unicom");
write_pb_item(test_write_dev, 3, "10000", "china telecom");
write_pb_item(test_write_dev, nil, "10011", "china unicom");
write_pb_item(PB_DEV_SM, nil, "+8618652845698", "songjin");
write_pb_item(PB_DEV_SM, nil, "15021309668", "my old phone");

local test_read_dev = PB_DEV_SM;
read_pb_item(test_read_dev, 1, 1);
read_pb_item(test_read_dev, 1, 3);
read_pb_item(test_read_dev, 1, 100);
read_pb_item(test_read_dev, 1, 500);

FINDNAME_MATCH_TYPE_CONTAIN = 0
FINDNAME_MATCH_TYPE_EXACT = 1
FINDNAME_MATCH_TYPE_STARTWITH = 2

local test_findname_dev = PB_DEV_SM;
local match_type = FINDNAME_MATCH_TYPE_CONTAIN;--default
local case_sensitive = false;
findname_pb_item(test_findname_dev, "u");--default match_type = 0:"CONTAIN"; case_sentive = true
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
case_sensitive = true;
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
match_type = FINDNAME_MATCH_TYPE_EXACT;
case_sensitive = false;
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china mobile", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china unicom", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china telecom", match_type, case_sensitive);
case_sensitive = true;
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china mobile", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "CHiNA unicom", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china telecom", match_type, case_sensitive);
match_type = FINDNAME_MATCH_TYPE_STARTWITH;
case_sensitive = false;
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "CHINA mobile", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "CHINA unicom", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china telecom", match_type, case_sensitive);
case_sensitive = true;
findname_pb_item(test_findname_dev, "u", match_type, case_sensitive);
findname_pb_item(test_findname_dev, nil, match_type, case_sensitive);
findname_pb_item(test_findname_dev, "chi", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "CHINA mobile", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china unicom", match_type, case_sensitive);
findname_pb_item(test_findname_dev, "china telecom", match_type, case_sensitive);

FINDPHONE_MATCH_TYPE_CONTAIN = 0
FINDPHONE_MATCH_TYPE_EXACT = 1
FINDPHONE_MATCH_TYPE_STARTWITH = 2
FINDPHONE_MATCH_TYPE_MATCH_INTELLIGENT = 3

local test_findphone_dev = PB_DEV_SM;
local match_type = FINDPHONE_MATCH_TYPE_CONTAIN;--default
findphone_pb_item(test_findphone_dev, "10");--default match_type = 0:"CONTAIN"
findphone_pb_item(test_findphone_dev, "1", match_type);
findphone_pb_item(test_findphone_dev, nil, match_type);
findphone_pb_item(test_findphone_dev, "1001", match_type);
findphone_pb_item(test_findphone_dev, "", match_type);
match_type = FINDPHONE_MATCH_TYPE_EXACT;
findphone_pb_item(test_findphone_dev, "10", match_type);
findphone_pb_item(test_findphone_dev, nil, match_type);
findphone_pb_item(test_findphone_dev, "1001", match_type);
findphone_pb_item(test_findphone_dev, "", match_type);
findphone_pb_item(test_findphone_dev, "10086", match_type);
findphone_pb_item(test_findphone_dev, "10010", match_type);
findphone_pb_item(test_findphone_dev, "10000", match_type);
match_type = FINDPHONE_MATCH_TYPE_STARTWITH;
findphone_pb_item(test_findphone_dev, "10", match_type);
findphone_pb_item(test_findphone_dev, nil, match_type);
findphone_pb_item(test_findphone_dev, "1001", match_type);
findphone_pb_item(test_findphone_dev, "", match_type);
findphone_pb_item(test_findphone_dev, "10086", match_type);
findphone_pb_item(test_findphone_dev, "10010", match_type);
findphone_pb_item(test_findphone_dev, "10000", match_type);
match_type = FINDPHONE_MATCH_TYPE_MATCH_INTELLIGENT;
findphone_pb_item(PB_DEV_SM, "18652845698", match_type);
findphone_pb_item(PB_DEV_SM, "+8618652845698", match_type);
findphone_pb_item(PB_DEV_SM, "+8615021309668", match_type);

local test_delete_dev = PB_DEV_ME;
write_pb_item(test_delete_dev, 1);--delete the first item


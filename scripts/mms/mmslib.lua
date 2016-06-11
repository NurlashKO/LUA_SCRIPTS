function print_hex(data)
  local add_space = 1 --default 1
  local group_count = 4 --default -1
  local byte_each_line = 16 --default -1
  local add_ascii = 1 --default 0
  local hex_str = string.bin2hex(data);
  --local hex_str = string.bin2hex(data, add_space, group_count, byte_each_line, add_ascii);
  if (hex_str) then
    print(hex_str.."\r\n");
  else
    print("nil\r\n");
  end;
end;

function sio_recv_contain(expect_result, timeout)
  local find_rst = nil;
  local rsp = nil;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  while (not find_rst) do
    rsp = sio.recv(1000); 
    --print(rsp);   
    if (rsp) then
      find_rst = string.find(rsp,expect_result);
    else      
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          print("time out for receiving expect result");
          break;
        end;
      end;
    end;
  end
  return rsp;
end

function get_timestamp()
  local dt = os.date("*t");
  local str_time = string.format("%04d-%02d-%02d %02d:%02d:%02d", dt.year, dt.month, dt.day, dt.hour, dt.min, dt.sec);
  return str_time;
end;

function mms_get_location_in_wap_push(mms_wap_push_msg)
  local mms_wap_push_hdr_pos = string.find(mms_wap_push_msg,"+WAP_PUSH_MMS:");
  if (mms_wap_push_hdr_pos) then
    local mms_wap_push_msg_len = string.len(mms_wap_push_msg);
    mms_wap_push_msg = string.sub(mms_wap_push_msg,mms_wap_push_hdr_pos,mms_wap_push_msg_len);
    local mms_wap_push_location_pos = string.find(mms_wap_push_msg,"http://");
    if (mms_wap_push_location_pos) then
      mms_wap_push_msg = string.sub(mms_wap_push_msg,mms_wap_push_location_pos,mms_wap_push_msg_len);
      local mms_wap_push_location_quota_pos = string.find(mms_wap_push_msg,"\"");
      if (mms_wap_push_location_quota_pos) then
        local mms_notify_location = string.sub(mms_wap_push_msg,1,mms_wap_push_location_quota_pos-1);
        print("succeeded in parsing mms wap push url:",mms_notify_location);
        return mms_notify_location;
      end;
    end;
  end;
  print("failed to parse mms_notify_location");
  return nil;
end;

function mms_receive_wap_push_rpt(timeout)
  local rsp = sio_recv_contain("+WAP_PUSH_MMS:",timeout);
  print(rsp);
  if (rsp) then
    return mms_get_location_in_wap_push(rsp);
  end;
  return nil;
end;

printdir(1)

--------------------------------------------------------
self_phone_number = "18621693950";
accquired = mms.accquire();--accquire mms library
if (not accquired) then
  print("failed to accquire mms library");
  return;
end;
print("succeeded in accquiring mms library");

rst = mms.set_mmsc("http://mmsc.myuni.com.cn");
--rst = mms.set_mmsc("http://mmsc.monternet.com");
if (not rst) then
  print("failed to set mmsc");
  return;
end;

local mmsc = mms.get_mmsc();
if (not mmsc) then
  print("failed to get mmsc");
  return;
end;
print("mmsc=", mmsc, "\r\n");

protocol_http = 1;
protocol_wap = 0;
rst = mms.set_protocol(protocol_http, "10.0.0.172", 80);
if (not rst) then
  print("failed to set mmsc proxy");
  return;
end;

local protocol, proxy, port = mms.get_protocol();
if (not protocol) then
  print("failed to get mmsc proxy");
  return;
end;
print("protocol=", protocol, ", proxy=", proxy, ", port=", port, "\r\n");

rst = mms.set_edit(1);
if (not rst) then
  print("failed to set mms edit state");
  return;
end;

rst = mms.set_title("test title");
if (not rst) then
  print("failed to set mms title");
  return;
end;

local convert_utf8_to_unicode = true;
local title = mms.get_title(convert_utf8_to_unicode);
if (not title) then
  print("failed to get mms title");
  return;
end;
print("ucs2 title=");
print_hex(title);

convert_utf8_to_unicode = false;
title = mms.get_title(convert_utf8_to_unicode);
if (not title) then
  print("failed to get mms title");
  return;
end;
print("utf8, title=", title, "\r\n");


local dest_is_receipt = 0;
local dest_is_cc = 1;
local dest_is_bcc = 2;

rst = mms.add_receipt("15021309668", dest_is_receipt);
if (not rst) then
  print("failed to set add receipt for mms");
  return;
end;
print("succeeded in adding receipt 15021309668\r\n");

rst = mms.add_receipt(self_phone_number, dest_is_receipt);
if (not rst) then
  print("failed to set add receipt for mms");
  return;
end;
print("succeeded in adding receipt "..self_phone_number.."\r\n");

receipts = mms.get_receipts(dest_is_receipt);
if (not receipts) then
  print("failed to get receipts for mms");
  return;
end;
for idx = 1, table.maxn(receipts), 1 do
  local receipt = receipts[idx];
  if (receipt) then
    print("receipts[", idx, "]=", receipt, "\r\n");
  end;
end;
rst = mms.delete_receipt("15021309668", dest_is_receipt);
if (not rst) then
  print("failed to set delete receipt 15021309668 for mms");
  return;
end;
print("succeeded in deleting receipt 15021309668\r\n");

dt = mms.get_delivery_date();
if (not dt) then
  print("failed to get delivery date for mms");
  return;
end;
print("delivery_date = ", dt.year, "-", dt.month, "-", dt.day, " ", dt.hour, ":", dt.min, ":", dt.sec, "\r\n");
--[[
rst = mms.attach_file("c:\\t2.txt");
if (rst ~= 0) then
  print("failed to set add attachment t2.txt for mms");
  return;
end;
print("succeeded in adding attachment t2.txt\r\n");
]]
source_type_title = 0;
source_type_image = 1;
source_type_text = 2;
source_type_audio = 3;
source_type_video = 4;
rst = mms.attach_from_memory(source_type_text, "t3.txt", "this is my test\r\nline2 test");
if (rst ~= 0) then
  print("failed to set add attachment t3.txt from memory for mms");
  return;
end;
print("succeeded in adding attachment t3.txt from memory\r\n");

rst = mms.attach_file("c:\\MyDir\\6k.jpg");
if (rst ~= 0) then
  print("failed to set add attachment 6k.jpg for mms");
  return;
end;
print("succeeded in adding attachment 6k.jpg\r\n");

rst = mms.attach_file("c:\\MyDir\\Water lilies.jpg");
if (rst ~= 0) then
  print("failed to add attachment 'Water lilies.jpg' for mms");
else
  print("succeeded in adding attachment 'Water lilies.jpg'\r\n");
end;


rst = mms.attach_file("c:\\cpbf.txt");
if (rst ~= 0) then
  print("failed to set add attachment cpbf.txt for mms");
else
  print("succeeded in adding attachment 6k.jpg\r\n");
end;


local attachment_count = mms.get_attachment_count();
if (not attachment_count) then
  print("failed to get attachment count for mms");
  return;
end;
print("succeeded in getting attachment count: ", attachment_count, "\r\n");

for idx = 0, mms.get_attachment_count()-1, 1 do
  attachment_name, content_type, attachment_size = mms.get_attachment_info(idx);
  if (not attachment_name) then
    print("failed to get attachment info[", idx, "]\r\n");
  end;
  print("attachment[", idx, "], name=", attachment_name, ", content_type = ", content_type, ", size=", attachment_size, "\r\n");
end;

content = mms.read_attachment(0);
if (not content) then
  print("failed to read attachment content for mms");
  return;
end;
print("attachment content length = ", string.len(content), "\r\n");

rst = mms.save(0, 2);
if (rst ~= 0) then
  print("failed to save mms");
  return;
end;
print("succeeded in saving mms\r\n");

rst = mms.load(0);
if (rst ~= 0) then
  print("failed to load mms");
  return;
end;
print("succeeded in loading mms\r\n");

local cur_date = os.date("*t");
local str_time = string.format("%04d%02d%02d%02d%02d%02d", cur_date.year, cur_date.month, cur_date.day, cur_date.hour, cur_date.min, cur_date.sec);
rst = mms.save_attachment(1, "c:\\MyDir\\"..str_time.."txt");
if (rst ~= 0) then
  print("failed to save attachment");
  return;  
end;
print("succeeded in saving attachment\r\n");

print("sending mms...\r\n");
rst = mms.send();
if (rst ~= 0) then
  print("failed to send mms\r\n");
  return;
end;
print("succeeded in sending mms\r\n");

rst = mms.set_edit(0);
if (not rst) then
  print("failed to set mms edit state");
  return;
end;
print("waiting mms notification...\r\n");
local location = mms_receive_wap_push_rpt(180000);
print("location=",location,"\r\n");
if (location) then
  print("recv mms("..location..")...\r\n");
  rst = mms.recv(location);
  if (rst ~= 0) then
    print("failed to recv mms\r\n");
    return;
  end;
  print("succeeded in recving mms\r\n");
else
  print("failed to receive MMS WAP PUSH notification\r\n");
  return;
end;

dt = mms.get_delivery_date();
if (not dt) then
  print("failed to get delivery date for mms");
  return;
end;
print("delivery_date = ", dt.year, "-", dt.month, "-", dt.day, " ", dt.hour, ":", dt.min, ":", dt.sec, "\r\n");

convert_utf8_to_unicode = true;
local title = mms.get_title(convert_utf8_to_unicode);
if (not title) then
  print("failed to get mms title");
  return;
end;
print("ucs2 title=");
print_hex(title);

convert_utf8_to_unicode = false;
title = mms.get_title(convert_utf8_to_unicode);
if (not title) then
  print("failed to get mms title");
  return;
end;
print("utf8, title=", title, "\r\n");

receipts = mms.get_receipts(dest_is_receipt);
if (not receipts) then
  print("failed to get receipts for mms");
  return;
end;

for idx = 0, mms.get_attachment_count()-1, 1 do
  attachment_name, content_type, attachment_size = mms.get_attachment_info(idx);
  if (not attachment_name) then
    print("failed to get attachment info[", idx, "]\r\n");
  end;
  print("attachment[", idx, "], name=", attachment_name, ", content_type = ", content_type, ", size=", attachment_size, "\r\n");
end;

mms.release();--release mms library


printdir(1)
collectgarbage();

local zipfile = "C:\\myfile.zip";
--local password = nil;
local password = "123456";
local output_dir = "C:";  --"C:\\";

local rst;
local zip_handle = miniunz.openzip(zipfile);
if (not zip_handle) then
  print("failed ot open zipfile ", zipfile, "\r\n");
  return;
end;
print("miniunz.openzip, zip_handle = ", zip_handle, "\r\n");

local entry_count = miniunz.number_entry(zip_handle);
print("miniunz.number_entry=", entry_count, "\r\n");

local entry_index = 0;
while (true) do
  local filename, filesize, crypted = miniunz.get_current_entry_info(zip_handle);
  if (filename) then
    print("entry[", entry_index, "]={", filename, ",",filesize," bytes,is_crypted=",crypted,"}\r\n");
  else
    print("failed to get entry[",entry_index, "] infoformation\r\n");
  end;
  rst = miniunz.extract_current_file(zip_handle, password, output_dir);
  print("miniunz.extract_current_file, rst=", rst, "\r\n");
  if (not miniunz.goto_next_entry(zip_handle)) then
    print("No next entry exist\r\n");
    break;
  end;
  entry_index = entry_index + 1;
end;

rst = miniunz.closezip(zip_handle);
print("miniunz.closezip, result = ", rst, "\r\n");

printdir(1)
collectgarbage();

local zipfile = "C:\\myfile.zip";
local file1 = "C:\\1.log";
local file2 = "C:\\1024B_ASCII.txt";
local file3 = "C:\\mytest.jpg";
local file4 = "C:\\500K.txt";
--local password = nil;
local password = "123456";
local compress_level = -1;
local exclude_path = 1;

local rst;
local zip_handle = minizip.openzip(zipfile, 0);
if (not zip_handle) then
  print("failed ot open zipfile ", zipfile, "\r\n");
  return;
end;
print("minizip.openzip, zip_handle = ", zip_handle, "\r\n");

rst = minizip.addfile(zip_handle, file1, password, compress_level, exclude_path);
print("minizip.addfile(",file1,"), result = ", rst, "\r\n");

rst = minizip.addfile(zip_handle, file2, password, compress_level, exclude_path);
print("minizip.addfile(",file2,"), result = ", rst, "\r\n");

rst = minizip.closezip(zip_handle);
print("minizip.closezip, result = ", rst, "\r\n");

print("append new files to zip\r\n");
zip_handle = minizip.openzip(zipfile, 2);
if (not zip_handle) then
  print("failed ot open zipfile ", zipfile, "\r\n");
  return;
end;
print("minizip.openzip, zip_handle = ", zip_handle, "\r\n");

rst = minizip.addfile(zip_handle, file3, password, compress_level, exclude_path);
print("minizip.addfile(",file3,"), result = ", rst, "\r\n");

rst = minizip.addfile(zip_handle, file4, password, compress_level, exclude_path);
print("minizip.addfile(",file4,"), result = ", rst, "\r\n");

rst = minizip.closezip(zip_handle);
print("minizip.closezip, result = ", rst, "\r\n");

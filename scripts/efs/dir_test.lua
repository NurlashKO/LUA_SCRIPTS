printdir(1);
local dir_list, file_list = os.lsdir("C:\\*.*");

if (dir_list) then
  for idx = 1, table.maxn(dir_list), 1 do
    local item = dir_list[idx];
	if (item)  then
	  print("dir_list[", idx, "]=", item, "\r\n");
	end;
  end;
end;
if (file_list) then
  for idx = 1, table.maxn(file_list), 1 do
    local item = file_list[idx];
	if (item)  then
	  print("file_list[", idx, "]=", item, "\r\n");
	end;
  end;
end;

rst = os.mkdir("C:\\testdir");
if (not rst) then
  print("failed to mkdir\r\n");
else
  print("succeeded in calling mkdir\r\n");
end;

rst = os.rmdir("C:\\testdir");
if (not rst) then
  print("failed to rmdir\r\n");
else
  print("succeeded in calling rmdir\r\n");
end;
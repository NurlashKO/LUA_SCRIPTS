function tohex(s)
   return (s:gsub(".", function (x)
			 return ("%02X"):format(x:byte())
		      end))
end

function cal_hash_value(filepath, hash)
  --print("begin to read file content:", filepath,"\r\n")
  local file = io.open(filepath,"r");
  assert(file)
  local foo = hash:init();
  local cnt = nil;
  filelen = 0;
  while (true) do
  --if (true) then
    cnt = file:read(1024);
    if (not cnt) then       
      break;
    else
	  foo:update(cnt);
      filelen = filelen + string.len(cnt);
      --print("read cnt suc, total_len\t=",filelen,"\r\n");
    end;
    vmsleep(0);
  end;
  file:close();
  --print("finished reading file content, total_len\t=",filelen,"\r\n");
  local bing = foo:final();
  return bing;
end


printdir(1)

local filepath = "c:\\myfile.zip";
local md5_value = cal_hash_value(filepath, md5);
if (md5_value) then
  print("md5 value[",filepath,"] = ", tohex(md5_value), "\r\n");
else
  print("failed to calcualte md5 value\r\n");
end;

local sha1_value = cal_hash_value(filepath, sha1);
if (sha1_value) then
  print("sha1 value[",filepath,"] = ", tohex(sha1_value), "\r\n");
else
  print("failed to calcualte sha1 value\r\n");
end;

if (true) then
  return;
end;

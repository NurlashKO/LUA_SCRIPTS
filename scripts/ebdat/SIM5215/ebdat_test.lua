printdir(1);

if (not ebdat.ready) then
  print("EBDAT for LUA API module not ready, just return\r\n");
  return;
end;

local errno;
local api_no;
local sub_api_no;

api_no = 0;
sub_api_no = 0;
errno = ebdat.callapi(api_no,sub_api_no, nil, nil, nil, nil, nil, nil, "Test My Str1\r\n", nil, nil);
print("ebdat.callapi, result=", errno, "\r\n");

api_no = 1;
sub_api_no = 0;
errno = ebdat.callapi(api_no,sub_api_no, nil, nil, nil, nil, nil, nil, "Test My Str2\r\n", nil, nil);
print("ebdat.callapi, result=", errno, "\r\n");

api_no = 1;
sub_api_no = 1;
errno = ebdat.callapi(api_no,sub_api_no, nil, nil, nil, nil, nil, nil, "Test My Str3\r\n", nil, nil);
print("ebdat.callapi, result=", errno, "\r\n");

api_no = 2;
sub_api_no = 0;
errno, p1, p2, p3, p4, p5, p6, str1, str2, str3 = ebdat.callapi(api_no,sub_api_no, nil, nil, nil, nil, nil, nil, "Test My Str4\r\n", nil, nil);
print("ebdat.callapi, result=", errno, ", str1=\"", str1, "\", str2=\"", "\"\r\n");

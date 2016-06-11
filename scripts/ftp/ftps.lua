printdir(1);

FTPS_RST_OK = 0;
FTPS_RST_SSL_ALERT = 1;
FTPS_RST_UNKNOWN_ERROR = 2;
FTPS_RST_BUSY = 3;
FTPS_RST_SERVER_CLOSED = 4;
FTPS_RST_TIMEOUT = 5;
FTPS_RST_TRANSFER_FAILED = 6;
FTPS_RST_MEMORY_ERROR = 7;
FTPS_RST_INVALID_PARAM = 8;
FTPS_RST_REJ_BY_SERVER = 9;
FTPS_RST_NETWORK_ERROR = 10;

local result, error_code;

local server = "180.166.164.118";--this can be domain name or IP address
local port = 990;
local name = "jin.song";
local pass = "123456";
local remote_path = "/";
local server_type = 2; -- 0=FTP, 1=Explicit FTPS(Auth SSL), 2=Explicit FTPS(Auth TLS), 3=Implicit SSL/TLS

local download_remote_file = "/5120.txt";
local download_local_file = "C:\\my_downloaded_5120.txt";

local upload_remote_file = "/upload_5120.txt";
local upload_local_file = "C:\\my_downloaded_5120.txt";

local test_mk_rm_dir = "/mytestdir";

local test_cwd_dir = "/testmy";

collectgarbage();
print("call ftps.start()...\r\n");
result = ftps.start();
print("ftps.start() = ", result, "\r\n");
if (not result) then
  print("failed to call ftps.start()\r\n");
  return;
end;
print("call ftps.login()...\r\n");
error_code = ftps.login(server_type, server, port, name, pass);
print("ftps.login() = ", error_code, "\r\n");
if (error_code and (error_code == FTPS_RST_OK)) then 

  print("call ftps.list()...\r\n");
  error_code, list_data = ftps.list("/");
  print("ftps.list() = ", error_code, "\r\n");
  if (error_code and (error_code == FTPS_RST_OK)) then 
    if (list_data and printdir()) then
	  print("LIST DATA:\r\n");
	  os.printstr(list_data);
	end;
  end;  
  
  print("call ftps.getfile(\""..download_remote_file.."\")...\r\n");
  local rest_size = 0;
  error_code = ftps.getfile(download_remote_file, download_local_file, rest_size);
  print("ftps.getfile() = ", error_code, "\r\n");
  
  
  print("call ftps.putfile(\""..upload_remote_file.."\")...\r\n");
  local rest_size = 0;
  error_code = ftps.putfile(upload_remote_file, upload_local_file, rest_size);
  print("ftps.putfile() = ", error_code, "\r\n");  
  
  
  print("call ftps.size()\r\n");
  error_code, f_bytes = ftps.size(download_remote_file);
  print("ftps.size() = ", error_code, ",", f_bytes, "\r\n");
  
  print("call ftps.mkdir()\r\n");
  error_code = ftps.mkdir(test_mk_rm_dir);
  print("ftps.mkdir() = ", error_code, "\r\n");
  
  print("call ftps.rmdir()\r\n");
  error_code = ftps.rmdir(test_mk_rm_dir);
  print("ftps.rmdir() = ", error_code, "\r\n");
  
  print("call ftps.dele()\r\n");
  error_code = ftps.dele(upload_remote_file);
  print("ftps.dele() = ", error_code, "\r\n");
  
  print("call ftps.cwd()\r\n");
  error_code = ftps.cwd(test_cwd_dir);
  print("ftps.cwd() = ", error_code, "\r\n");
  
  print("call ftps.pwd()\r\n");
  error_code, pwd = ftps.pwd();
  print("ftps.pwd() = ", error_code, ",", pwd, "\r\n");
  
  print("call ftps.logout()...\r\n");
  error_code = ftps.logout();
  print("ftps.logout() = ", error_code, "\r\n");
end;

print("call ftps.stop()...\r\n");
result = ftps.stop();
print("ftps.stop(), result=", result, "\r\n");
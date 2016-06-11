--------------------------------------------------------------------------------
--测试说明
--本脚本测试彩信创建、发送和接收功能
--1. 在模块/MultiMedia/Picture/下放两个图片 efs_f1.jpg和normal.jpg
--2. 在"CONFIGURATION SECTION"部分修改相关配置变量
--------------------------------------------------------------------------------
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

--receive result1 or result2
function sio_recv_contain2(expect_result1, expect_result2, timeout)
  local find_rst = nil;
  local rsp = nil;
  local rst_num = -1;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  --print("sio_recv_contain2",expect_result1, expect_result2);
  while (not find_rst) do
    rsp = sio.recv(1000);    
    if (rsp) then
      find_rst = string.find(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.find(rsp,expect_result2);
        --print("find_rst(2)=",find_rst, expect_result2);
        if (find_rst) then
          rst_num = 2;
        end;
      else
        rst_num = 1;
      end;
    else
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          print("time out for receiving expect result");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2", rsp, rst_num);
  end
  return rsp , rst_num;
end

--receive result1 or result2 or result3
function sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout)
  local find_rst = nil;
  local rsp = nil;
  local rst_num = -1;
  local start_count = os.clock();
  --print("start_count = ", start_count);
  while (not find_rst) do
    rsp = sio.recv(1000);    
    if (rsp) then
      find_rst = string.find(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.find(rsp,expect_result2);
        --print("find_rst(2)=",find_rst, expect_result2);
        if (not find_rst) then
          find_rst = string.find(rsp,expect_result3);
          if (find_rst) then
            rst_num = 3;
          end;
        else
          rst_num = 2;
        end;
      else
        rst_num = 1;
      end;
    else
      local cur_count = os.clock();
      --print("cur_count = ", cur_count);
      if (timeout and (timeout > 0)) then
        if (((cur_count - start_count)*1000) > timeout) then
          print("time out for receiving expect result");
          break;
        end;
      end;
    end
    --print("sio_recv_contain2", rsp, rst_num);
  end
  return rsp , rst_num;
end

function sio_send_and_recv(cmd, expect_result, timeout)
  print(">>>>>>>>>>>>>>", cmd);
  sio.send(cmd);
  local rsp = sio_recv_contain(expect_result, timeout);
  return rsp;
end

function sio_send_and_recv2(cmd, expect_result1, expect_result2, timeout)
  print(">>>>>>>>>>>>>>", cmd);
  sio.send(cmd);
  local rsp, exp_num = sio_recv_contain2(expect_result1, expect_result2, timeout);
  --print("sio_send_and_recv2",rsp, exp_num);
  return rsp, exp_num;
end

function sio_send_and_recv3(cmd, expect_result1, expect_result2, expect_result3, timeout)
  print(">>>>>>>>>>>>>>", cmd);
  sio.send(cmd);
  local rsp, exp_num = sio_recv_contain3(expect_result1, expect_result2, expect_result3, timeout);
  --print("sio_send_and_recv2",rsp, exp_num);
  return rsp, exp_num;
end

function sio_send_file_content(filepath)
  print("begin to send file content:", filepath,"\r\n")
  file = io.open(filepath,"r");
  assert(file)
  local cnt = nil;
  filelen = 0;
  while (true) do
    cnt = file:read(1024);
    if (not cnt) then
      break;
    end;
    filelen = filelen + string.len(cnt);
    print("read cnt suc, total_len\t=",filelen,"\r\n");
    sio.send(cnt);
    vmsleep(0);
  end;
  file:close();
  print("finished reading file content, total_len\t=",filelen,"\r\n");
end


--local lmms_wap_push_msg = "\r\n+WAP_PUSH_MMS: \"15001844675\",\"RROpJGJVyjeA\",\"http://211.136.112.84/RROpJGJVyjeA\",\"09/03/17,17:14:41+32\",0,13338";
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
print("---------------------begin test---------------------");
--connect COM9
--comport = 9;

-------------------------------------------------------------------
--CONFIGURATION SECTION
pdp_apn = "cmwap";
mmsc = "mmsc.monternet.com";
--protocol, 0=wap, 1=tcp
mms_gateway_protocol = 1;
mms_gateway_ip_addr = "10.0.0.172";
mms_gateway_ip_port = 80;
mms_gateway_wap_addr = "10.0.0.172";
mms_gateway_wap_port = 9201;
--mms_gateway_port = 9201;
--the file to download on EFS(using at+cmmsdown="file",1,"...")
efsdownfile = "efs_f1.jpg";
--the file to download on PC(simulated)(using at+cmmsdown="pic",...,"...")
filepath="c:\\Picture\\normal.jpg";
--the receipt(at+cmmsrecp=...)
mms_receipt = "15821668763";
--send mms to self? (if true, the script will try to receive the wap push report after sending mms successfully)
send_mms_to_self = true;
--test sending and receiving mms?(if false, sending function is not tested)
test_mms_send = true;
--times of test sending and receiving mms
test_mms_send_count = 10;
send_suc_count = 0;
recv_suc_count = 0;
--------------------------------------------------------------------

mms_gateway_ip = mms_gateway_ip_addr;
mms_gateway_port = mms_gateway_ip_port;

if (mms_gateway_protocol == 0) then
  mms_gateway_ip = mms_gateway_wap_addr;
  mms_gateway_port = mms_gateway_wap_port;
end;
--suc = sio.connect(comport);
suc = true;
if (suc) then  
  --vmsleep(3000);
  sio.clear();
  local rsp = sio_send_and_recv("ATE0\r\n","\r\nOK\r\n", 5000)
  print(rsp);  
  if (not rsp) then
    return;
  end;
  
  --test for receiving OK or +CME ERROR
  cmd = string.format("AT+CGSOCKCONT=1,\"IP\",\"%s\"\r\n",pdp_apn);
  local rsp, exp_num = sio_send_and_recv2(cmd,"\r\nOK\r\n","\r\nERROR\r\n", 5000);
  print(exp_num, rsp);  
  --only OK is accepted
  if (exp_num ~= 1) then
    print("Failed to set cgsockcont\r\n");
    return;
  end;
  
  --test for receiving OK or +CME ERROR or ERROR
  cmd = string.format("AT+CMMSCURL=\"%s\"\r\n",mmsc);
  local rsp, exp_num = sio_send_and_recv3(cmd,"\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n", 5000);
  print(exp_num, rsp);  
  --only OK is accepted
  if (exp_num ~= 1) then
    print("Failed to set mmsc\r\n");
    return;
  end;
  
  --test for receiving OK or +CME ERROR or ERROR
  cmd = string.format("AT+CMMSPROTO=%d,\"%s\",%d\r\n",mms_gateway_protocol, mms_gateway_ip, mms_gateway_port);
  local rsp, exp_num = sio_send_and_recv3(cmd,"\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n", 5000);
  print(exp_num, rsp);  
  --only OK is accepted
  if (exp_num ~= 1) then
    print("Failed to set mms protocol\r\n");
    return;
  end; 
  
  count = 0;
  while (count < test_mms_send_count) do
    count = count + 1;
    print("-------------------run count=",count,"\r\n");
    sio.clear();
    rsp = sio_send_and_recv("AT+CMMSEDIT=1\r\n","\r\nOK\r\n", 5000);
    print(rsp); 
    
    rsp = sio_send_and_recv("AT+CMMSDOWN=\"title\",10\r\n",">", 5000);
    print(rsp);
    sio.send("test title");
    --receive OK
    rsp, exp_num = sio_recv_contain3("\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n",5000);
    if (exp_num ~= 1) then
      print("Faile to down text", rsp,"\r\n");
      return;
    end;  
    
    rsp = sio_send_and_recv("AT+CMMSDOWN=\"text\",10,\"t1.txt\"\r\n",">", 5000);
    print(rsp);
    sio.send("test xyzrt");
    --receive OK
    rsp, exp_num = sio_recv_contain3("\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n",5000);
    if (exp_num ~= 1) then
      print("Faile to down text", rsp,"\r\n");
      return;
    end;
    print(rsp);  
    
    cmd = string.format("AT+CMMSDOWN=\"file\",1,\"%s\"\r\n",efsdownfile);
    rsp, exp_num = sio_send_and_recv2(cmd,"\r\nOK\r\n","+CME ERROR", 15000);
    if (exp_num ~= 1) then
      print("Failed to down efs file", rsp,"\r\n");
      --return;
    end;
    print(rsp);  
    
    if (true) then
      fname = pathtofilename(filepath);
      flen  = os.filelength(filepath);
      if (flen <= 0) then
        print("Invalid file length\r\n");
      end;
      cmd = string.format("AT+CMMSDOWN=\"pic\",%d,\"%s\"\r\n", flen, fname);
      rsp = sio_send_and_recv(cmd,">");
      print(rsp);
      sio_send_file_content(filepath);
      --receive OK
      rsp, exp_num = sio_recv_contain3("\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n",5000);
      if (exp_num ~= 1) then
        print("Faile to down pic", rsp,"\r\n");
        return;
      end;
      print(rsp); 
    end;     
    
    cmd = string.format("AT+CMMSRECP=\"%s\"\r\n",mms_receipt);
    rsp, exp_num = sio_send_and_recv3(cmd,"\r\nOK\r\n","+CME ERROR","\r\nERROR\r\n",5000);
    if (exp_num ~= 1) then
      print("Failed to set mms receipt", rsp);
      return;
    end;
    print(rsp);
    --vmsleep(4000);
    rsp = sio_send_and_recv("AT+CMMSVIEW\r\n","\r\nOK\r\n", 5000);
    print(rsp);
    print("\r\n");
    if (test_mms_send) then      
      local send_suc = false;
      local rsp, exp_num = sio_send_and_recv3("AT+CMMSSEND\r\n","+CMMSSEND: 0","+CMMSSEND:","+CME ERROR", 180000);
      print(rsp, exp_num);
      if (exp_num == 1) then
        print(rsp, "\r\nSucceeded in sending mms\r\n");
        send_suc = true;
        send_suc_count = send_suc_count+1;
      else
        print(rsp, "\r\nFailed to send mms\r\n");
      end; 
      
      if (send_suc and send_mms_to_self) then
        local recv_suc = false;
        print("begin to get mms wap push report...");
        local location = mms_receive_wap_push_rpt(180000);
        print("location=",location,"\r\n");
        if (location) then
          rsp = sio_send_and_recv("AT+CMMSEDIT=0\r\n","\r\nOK\r\n", 5000);
          print(rsp);
          cmd = string.format("AT+CMMSRECV=\"%s\"\r\n",location);
          local rsp, exp_num = sio_send_and_recv3(cmd,"+CMMSRECV: 0","+CMMSRECV:","+CME ERROR", 180000);
          if (exp_num == 1) then
            print(rsp, "\r\nSucceeded in receiving mms\r\n");
            recv_suc_count = recv_suc_count+1;
            recv_suc = true;
          else
            print(rsp, "\r\nFailed to receive mms\r\n");
          end; 
          if (recv_suc) then
            rsp = sio_send_and_recv("AT+CMMSVIEW\r\n","\r\nOK\r\n", 5000);
            print(rsp,"\r\n");
            rsp = sio_send_and_recv("AT+CMMSSAVE=0\r\n","\r\nOK\r\n", 5000);
            print(rsp);
          end;
        end;
      end;  
    end;
  end;
  --sio.close();  
  
end;
local rsp = sio_send_and_recv("ATE1\r\n","\r\nOK\r\n", 5000)
print(rsp);
print("tested_count: ",count, "\r\nsend_suc_count: ", send_suc_count, "\r\nrecv_suc_count: ", recv_suc_count,"\r\n"); 
print("---------------------finished test---------------------\r\n");
--------------------------------------------------------------------------------
--测试说明
--本脚本测试SMS创建、发送和接收功能

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
      find_rst = string.absfind(rsp,expect_result);
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
      find_rst = string.absfind(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
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
      find_rst = string.absfind(rsp,expect_result1);
      --print(rsp, "find_rst=",find_rst, expect_result1);
      if (not find_rst) then
        find_rst = string.absfind(rsp,expect_result2);
        --print("find_rst(2)=",find_rst, expect_result2);
        if (not find_rst) then
          find_rst = string.absfind(rsp,expect_result3);
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

function init_sms_configuration_info(cmgf, cnmi_p1, cnmi_p2, csca)
  local cmd = string.format("at+cmgf=%d\r\n",cmgf);
  local rsp =sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set cmgf\r\n");
    return false;
  end;
  
  cmd = string.format("at+cnmi=%d,%d\r\n",cnmi_p1, cnmi_p2);
  rsp = sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set cnmi\r\n");
    return false;
  end;
  
  cmd = string.format("at+csca=\"%s\"\r\n",csca);
  rsp = sio_send_and_recv(cmd,"OK", 5000)
  
  if (rsp == nil) then
    print("Failed to set csca\r\n");
    return false;
  end;
  print("Succeeded in setting sms configuration\r\n");
  return true;
end;

function send_sms_with_text_data(dest_no, content, delimiter, max_retry)
  local rsp = nil;
  local exp_num = -1;
  local cmd = nil;
  local array = {};
  local array_item_idx = 1;
  if ((not content) or (string.len(content) == 0)) then
    print("empty sms content, just send it\r\n");
    return send_sms_with_array(dest_no, {}, max_retry);
  end;
  local idx = 1;
  idx = string.absfind(content, delimiter, idx);
  while (idx) do
    local item = "";
    --print("idx=", idx, "\r\n");
    if (idx > 1) then
      item = string.sub(content, 1, idx-1);
    elseif (idx == 1) then
      item = "";
    end;
    --print("item=", item,"\r\n");
    array[array_item_idx] = item;
    array_item_idx = array_item_idx + 1;
    if ((idx + string.len(delimiter) - 1) == string.len(content)) then
      content = "";
      break;
    end;
    --print("----content=", content, "\r\n");
    content = string.sub(content, idx + string.len(delimiter), string.len(content));
    --print("content=", content, "\r\n");
    idx = string.absfind(content, delimiter, idx);
    --vmsleep(3000);
  end;
  if (content and (string.len(content) > 0)) then
    --print("item=", content,"\r\n");
    array[array_item_idx] = content;
    array_item_idx = array_item_idx + 1;
    content = "";
  end;
  --print("dest_no=", dest_no, "\r\n");
  --for idx, cmd in pairs(array) do
      --print("cmd=", cmd, "\r\n");
  --end;
  return send_sms_with_array(dest_no, array, max_retry);
end;

function send_sms_with_array(dest_no, content, max_retry)
  local rsp = nil;
  local exp_num = -1;
  local cmd = nil;
  local retry_count = 0;
  --print("begin to send sms\r\n");
  while (true) do
    cmd = string.format("at+cmgs=\"%s\"\r\n", dest_no);
    rsp, exp_num  = sio_send_and_recv3(cmd,">", "+CME ERROR", "+CMS ERROR",5000);
    if (exp_num == 1) then   
      if (content) then
        local prev_cmd = "";
        local line_idx = 0;
        for idx, cmd in pairs(content) do
          line_idx = line_idx + 1;
          if (line_idx > 1) then
            rsp = sio_send_and_recv(prev_cmd .. "\r",">", 5000);
          end;
          prev_cmd = cmd;
        end;
        if (prev_cmd and (string.len(prev_cmd) > 0)) then
          rsp = sio.send(prev_cmd);
        end;
      end;         
      rsp, exp_num = sio_send_and_recv3("\26","OK","+CMGS", "+CMS ERROR", 60000);
      if (rsp and ((exp_num == 1) or (exp_num == 2))) then
        return true;
      end;
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
      
    else
      if (max_retry and (retry_count < max_retry)) then
        retry_count = retry_count + 1;
      else
        return false;
      end;
    end;
  end;
  return false;
end;

printdir(1)

rsp =sio_send_and_recv("ate0\r\n","OK", 5000)
print(rsp)

init_sms_configuration_info(1, 1, 2, "+8613800210500");

rsp = nil;
print("begin to send sms\r\n");

test_phone_no = "15821668763";
local sms_content;

sms_content = nil;
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "";
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "my line1\r\n\r\nmy line2\r\nmy line3\r\nmyline4";
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "my line1\r\nmy line2\r\nmy line3\r\nmyline4";
send_sms_with_text_data(test_phone_no, sms_content,"\r\n",3);

sms_content = "test my line1";
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "my line1\rmy line2\rmy line3\rmyline4\r";
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "test my line1\r";
send_sms_with_text_data(test_phone_no, sms_content,"\r",3);

sms_content = "test my line111\ntest my line112";
send_sms_with_text_data(test_phone_no, sms_content,"\n",3);

sms_content = {
  "test line1",
  "test line2",
  "test line3",
  "test line4",
  "test line5"
};

rsp = send_sms_with_array(test_phone_no, sms_content, 3);
print("\r\nrsp=",rsp, "\r\n");
 
rsp =sio_send_and_recv("ate1\r\n","OK", 5000)
print(rsp)

sio.clear();
 

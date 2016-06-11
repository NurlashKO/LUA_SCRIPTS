function print_cpms_info(cpms_info)
  if (not cpms_info) then
    print("cpms information is nil\r\n");
    return;
  end;
  print("cpms information={\r\n");
  print("    {\r\n");
  print("        mem1_store=", cpms_info.mem1_store, "\r\n");
  print("        mem1_used=", cpms_info.mem1_used, "\r\n");
  print("        mem1_max=", cpms_info.mem1_max, "\r\n");
  print("    }\r\n");
  print("    {\r\n");
  print("        mem2_store=", cpms_info.mem2_store, "\r\n");
  print("        mem2_used=", cpms_info.mem2_used, "\r\n");
  print("        mem2_max=", cpms_info.mem2_max, "\r\n");
  print("    }\r\n");
  print("    {\r\n");
  print("        mem3_store=", cpms_info.mem3_store, "\r\n");
  print("        mem3_used=", cpms_info.mem3_used, "\r\n");
  print("        mem3_max=", cpms_info.mem3_max, "\r\n");
  print("    }\r\n");
  print("}\r\n");
end;

function query_cpms_info()
  print("query_cpms_info\r\n");
  local cpms_info = sms.cpms();
  print_cpms_info(cpms_info);
  return cpms_info;
end;

function change_cpms(mem1, mem2, mem3)
  print("change_cpms, mem1=", mem1, ", mem2=", mem2, ", mem3=", mem3, "\r\n");
  local cpms_info = sms.cpms(mem1, mem2, mem3);
  print_cpms_info(cpms_info);
  return cpms_info;
end;

function test_cpms()
  print("-------test cpms-------\r\n");
  CPMS_MEM_STORE_ME = 0;
  CPMS_MEM_STORE_MT = 1;
  CPMS_MEM_STORE_SM = 2;
  CPMS_MEM_STORE_SR = 3;

  if (not query_cpms_info()) then
   print("failed to query cpms information\r\n");
   return;
  end;

  if (not change_cpms(CPMS_MEM_STORE_ME, CPMS_MEM_STORE_SM, CPMS_MEM_STORE_SM)) then
   print("failed to change cpms\r\n");
   return;
  end;

  if (not change_cpms(nil, nil, CPMS_MEM_STORE_ME)) then
   print("failed to change cpms\r\n");
   return;
  end;

  if (not change_cpms(CPMS_MEM_STORE_SM, CPMS_MEM_STORE_ME)) then
   print("failed to change cpms\r\n");
   return;
  end;

  if (not change_cpms(CPMS_MEM_STORE_ME)) then
   print("failed to change cpms\r\n");
   return;
  end;
end;

function print_csmp_info(csmp_info)
  if (not csmp_info) then
    print("csmp information is nil\r\n");
    return;
  end;
  print("csmp information={\r\n");
  print("    fo=", csmp_info.fo, "\r\n");
  print("    vp=", csmp_info.vp, "\r\n");
  print("    pid=", csmp_info.pid, "\r\n");
  print("    dcs=", csmp_info.dcs, "\r\n");
  print("}\r\n");
end;

function query_csmp_info()
  print("query_csmp_info\r\n");
  local csmp_info = sms.get_csmp();
  print_csmp_info(csmp_info);
  return csmp_info;
end;

function change_csmp(fo, vp, pid, dcs)
  print("change_csmp, fo=", fo, ", vp=", vp, ", pid=", pid, ", dcs=", dcs, "\r\n");
  local result = sms.set_csmp(fo, vp, pid, dcs);
  print("sms.set_csmp(), result=", result, "\r\n");
  return result;
end;

function test_csmp()
  print("-------test csmp-------\r\n");
  if (not query_csmp_info()) then
   print("csmp information is nil\r\n");
   return;
  end;

  if (not change_csmp(17, 20, 0, 8)) then
   print("failed to change csmp\r\n");
   return;
  end;

  if (not query_csmp_info()) then
   print("csmp information is nil\r\n");
   return;
  end;

  if (not change_csmp(17, 14, 0, 0)) then
   print("failed to change csmp\r\n");
   return;
  end;

  if (not query_csmp_info()) then
   print("csmp information is nil\r\n");
   return;
  end;

  if (not change_csmp(17, 20)) then
   print("failed to change csmp\r\n");
   return;
  end;

  if (not query_csmp_info()) then
   print("csmp information is nil\r\n");
   return;
  end;

  if (not change_csmp(nil, nil, nil, 8)) then
   print("failed to change csmp\r\n");
   return;
  end;

  if (not query_csmp_info()) then
   print("csmp information is nil\r\n");
   return;
  end;
end;

function print_cnmi_info(cnmi_info)
  if (not cnmi_info) then
    print("cnmi information is nil\r\n");
    return;
  end;
  print("cnmi information={\r\n");
  print("    mode=", cnmi_info.mode, "\r\n");
  print("    mt=", cnmi_info.mt, "\r\n");
  print("    bm=", cnmi_info.bm, "\r\n");
  print("    ds=", cnmi_info.ds, "\r\n");
  print("    bfr=", cnmi_info.bfr, "\r\n");
  print("}\r\n");
end;

function query_cnmi_info()
  print("query_cnmi_info\r\n");
  local cnmi_info = sms.get_cnmi();
  print_cnmi_info(cnmi_info);
  return cnmi_info;
end;

function change_cnmi(mode, mt, bm, ds, bfr)
  print("change_cnmi, mode=", mode, ", mt=", mt, ", bm=", bm, ", ds=", ds, ", bfr=", bfr,"\r\n");
  local result = sms.set_cnmi(mode, mt, bm, ds, bfr);
  print("sms.set_cnmi(), result=", result, "\r\n");
  return result;
end;

function test_cnmi()
  if (not query_cnmi_info()) then
   print("cnmi information is nil\r\n");
   return;
  end;
  if (not change_cnmi(1,2,nil,nil,nil)) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_cnmi_info()) then
   print("cnmi information is nil\r\n");
   return;
  end;
  if (not change_cnmi(2,1,2,nil,nil)) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_cnmi_info()) then
   print("cnmi information is nil\r\n");
   return;
  end;
  if (not change_cnmi(2,1,2,0,0)) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_cnmi_info()) then
   print("cnmi information is nil\r\n");
   return;
  end;
  if (not change_cnmi(2,1,2,2,0)) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_cnmi_info()) then
   print("cnmi information is nil\r\n");
   return;
  end;
end;

function print_csca_info(csca_info)
  if (not csca_info) then
    print("csca information is nil\r\n");
    return;
  end;
  print("csca = \"", csca_info, "\"\r\n");
end;

function query_csca_info()
  print("query_csca_info\r\n");
  local csca_info = sms.get_csca();
  print_csca_info(csca_info);
  return csca_info;
end;

function change_csca(new_csca)
  print("change_csca, csca=", new_csca,"\r\n");
  local result = sms.set_csca(new_csca);
  print("sms.set_csca(), result=", result, "\r\n");
  return result;
end;

function test_csca()
  local current_csca = query_csca_info();
  if (not current_csca) then
   print("current csca information is nil\r\n");
   return;
  end;  
  if (not change_csca("+8613010314500")) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_csca_info()) then
   print("csca information is nil\r\n");
   return;
  end;
  if (not change_csca("+8618652845698")) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_csca_info()) then
   print("csca information is nil\r\n");
   return;
  end;
  if (not change_csca(current_csca)) then
   print("failed to change cnmi\r\n");
   return;
  end;
  if (not query_csca_info()) then
   print("csca information is nil\r\n");
   return;
  end;
end;

function test_read()
  local csdh_val = sms.get_csdh();
  print("current csdh = ", csdh_val, "\r\n");
  if (not sms.set_csdh(1)) then
    print("failed to set csdh value\r\n");
  end;
  local msg_index, rst, sms_content;
  msg_index = 1;
  sms.set_cmgf(1);
  rst, sms_content = sms.read(msg_index);--just read, without modify the tag from "UNREAD" to "READ"
  print("sms.read[", msg_index, "]=", rst, "\r\n");
  if (not sms_content) then
   print("sms_content is nil\r\n");
   return;
  end; 
  print("TEXT sms_content=\r\n", sms_content, "\r\n");  
  sms.set_cmgf(0);
  rst, sms_content = sms.read(msg_index);--just read, without modify the tag from "UNREAD" to "READ"
  print("sms.read[", msg_index, "]=", rst, "\r\n");
  if (not sms_content) then
   print("sms_content is nil\r\n");
   return;
  end; 
  print("PDU sms_content=\r\n", sms_content, "\r\n");  
  msg_index = 2;
  sms.set_cmgf(1);
  rst, sms_content = sms.read(msg_index);--just read, without modify the tag from "UNREAD" to "READ"
  print("sms.read[", msg_index, "]=", rst, "\r\n");
  if (not sms_content) then
   print("sms_content is nil\r\n");
   return;
  end; 
  print("TEXT sms_content=\r\n", sms_content, "\r\n"); 
  sms.set_cmgf(0);
  rst, sms_content = sms.read(msg_index);--just read, without modify the tag from "UNREAD" to "READ"
  print("sms.read[", msg_index, "]=", rst, "\r\n");
  if (not sms_content) then
   print("sms_content is nil\r\n");
   return;
  end; 
  print("PDU sms_content=\r\n", sms_content, "\r\n"); 
end;

function test_modify_tag()
  local msg_index, rst;
  msg_index = 1;
  rst, sms_content = sms.modify_tag(msg_index);--equals to AT+CMGMT
  print("sms.modify_tag[", msg_index, "]=", rst, "\r\n");
  
  msg_index = 2;
  rst = sms.modify_tag(msg_index);--equals to AT+CMGMT
  print("sms.modify_tag[", msg_index, "]=", rst, "\r\n");
end;


function test_delete()
  SMS_DELETE_FLAG_NONE = 0--default, sms.delete(msg_index, 0) equals to sms.delete(msg_index)
  SMS_DELETE_FLAG_READ = 1
  SMS_DELETE_FLAG_UNREAD = 2
  SMS_DELETE_FLAG_SENT = 4
  SMS_DELETE_FLAG_UNSENT = 8
  SMS_DELETE_FLAG_SENT_ST_NOT_RECEIVED = 16
  SMS_DELETE_FLAG_ALL = 0xFF
  --bitwise or operation <delflag>
  --SMS_DELETE_FLAG_READ + SMS_DELETE_FLAG_UNREAD + SMS_DELETE_FLAG_SENT + SMS_DELETE_FLAG_UNSENT + SMS_DELETE_FLAG_SENT_ST_NOT_RECEIVED
  
  local msg_index, delflag, rst;
  msg_index = 1;
  rst = sms.delete(msg_index);
  print("sms.delete[", msg_index, "]=", rst, "\r\n");
  delflag = SMS_DELETE_FLAG_READ + SMS_DELETE_FLAG_UNSENT;
  rst = sms.delete(0, delflag);
  print("sms.delete[0,", delflag, "]=", rst, "\r\n");
  delflag = SMS_DELETE_FLAG_ALL;
  rst = sms.delete(0, delflag);
  print("sms.delete[0,", delflag, "]=", rst, "\r\n");
end;

function test_write()
  SMS_WRITE_FLAG_READ = 1
  SMS_WRITE_FLAG_UNREAD = 2
  SMS_WRITE_FLAG_SENT = 3
  SMS_WRITE_FLAG_UNSENT = 4
  SMS_WRITE_FLAG_SENT_ST_NOT_RECEIVED = 5
   
  local msg_index, msg_content, rst, stat, suc, msg_ref_or_err_cause;
  local msg_ref, total_sm, seq_num;
  -----------------------------WRITE TXT SMS--------------------------------------
  print("write single IRA sms\r\n");
  local dest_phone_number = "18652845698";
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(1);
  sms.set_csmp(17, 14, 0, 0);
  msg_content = "test content1";   
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content);--write single sms, default is "UNSENT"
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  msg_content = "test content UNSENT";
  stat = SMS_WRITE_FLAG_UNSENT;
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write single sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  msg_content = "test content SENT";
  stat = SMS_WRITE_FLAG_SENT;
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write single sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  msg_content = "test content READ";
  stat = SMS_WRITE_FLAG_READ;
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write single sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  msg_content = "test content UNREAD";
  stat = SMS_WRITE_FLAG_UNREAD;
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write single sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------write long IRA sms-----------
  print("write long IRA sms\r\n");
  os.set_cscs(CSCS_IRA);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "test content UNSEND(1/2)";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "test content UNSEND(2/2)";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------write single UCS2 sms-----------
  print("write single UCS2 sms\r\n");
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_content = "003000310032003300340035003600370038";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write single sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------write long UCS2 sms-----------
  print("write long UCS2 sms\r\n");  
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "9650523665F695F45230FF0C5F5550CF505C6B62";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "5F5550CF8D8565F6";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------------------------WRITE PDU SMS--------------------------------------
  print("write single PDU sms\r\n");
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(0);
  msg_content = "0001000a819914799704000003c8701a";
  local send_len = 15;--similiar to AT+CMGW=15 in PDU mode
  suc, msg_ref_or_err_cause = sms.write(send_len, msg_content);--write single sms
  print("PDU sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
end;

function test_send()
  local msg_content, rst, suc, msg_ref_or_err_cause;
  local msg_ref, total_sm, seq_num;
  -----------------------------WRITE TXT SMS--------------------------------------
  print("send single IRA sms\r\n");
  local dest_phone_number = "18652845698";
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(1);
  sms.set_csmp(17, 14, 0, 0);
  msg_content = "test content single sms";   
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content);--send single sms, default is "UNSENT"
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------send long IRA sms-----------
  print("send long IRA sms\r\n");  
  os.set_cscs(CSCS_IRA);
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "test IRA content(1/2)";
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content, msg_ref, seq_num, total_sm);--send long sms
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "test IRA content(2/2)";
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content, msg_ref, seq_num, total_sm);--send long sms
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------send single UCS2 sms-----------
  print("send single UCS2 sms\r\n");
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  msg_content = "003000310032003300340035003600370038";
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content);--send single sms
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------send long UCS2 sms-----------
  print("send long UCS2 sms\r\n");
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "9650523665F695F45230FF0C5F5550CF505C6B62";
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content, msg_ref, seq_num, total_sm);--send long sms
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "5F5550CF8D8565F6";
  suc, msg_ref_or_err_cause = sms.send(dest_phone_number, msg_content, msg_ref, seq_num, total_sm);--send long sms
  print("sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------------------------SEND PDU SMS--------------------------------------
  print("send single PDU sms\r\n");
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(0);
  msg_content = "0001000a819914799704000003c8701a";
  local send_len = 15;--similiar to AT+CMGS=15 in PDU mode
  suc, msg_ref_or_err_cause = sms.send(send_len, msg_content);--send PDU sms
  print("PDU sms.send=", suc, ",", msg_ref_or_err_cause, "\r\n");
end;

function test_cmss()
  SMS_WRITE_FLAG_READ = 1
  SMS_WRITE_FLAG_UNREAD = 2
  SMS_WRITE_FLAG_SENT = 3
  SMS_WRITE_FLAG_UNSENT = 4
  SMS_WRITE_FLAG_SENT_ST_NOT_RECEIVED = 5
   
  local msg_index, msg_content, rst, stat, suc, msg_ref_or_err_cause;
  local msg_ref, total_sm, seq_num;
  -----------------------------WRITE TXT SMS--------------------------------------
  print("write single IRA sms\r\n");
  local dest_phone_number = "18652845698";
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(1);
  sms.set_csmp(17, 14, 0, 0);
  msg_content = "test content1";   
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content);--write single sms, default is "UNSENT"
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
 
  -----------write long IRA sms-----------
  print("write long IRA sms\r\n");
  os.set_cscs(CSCS_IRA);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "test content UNSEND(1/2)";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "test content UNSEND(2/2)";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------write single UCS2 sms-----------
  print("write single UCS2 sms\r\n");
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_content = "003000310032003300340035003600370038";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------write long UCS2 sms-----------
  print("write long UCS2 sms\r\n");  
  os.set_cscs(CSCS_UCS2);
  sms.set_csmp(17, 14, 0, 8);
  stat = SMS_WRITE_FLAG_UNSENT;
  msg_ref = sms.get_next_msg_ref();
  total_sm = 2;
  seq_num = 1;
  msg_content = "9650523665F695F45230FF0C5F5550CF505C6B62";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
  total_sm = 2;
  seq_num = 2;
  msg_content = "5F5550CF8D8565F6";
  suc, msg_ref_or_err_cause = sms.write(dest_phone_number, msg_content, stat, msg_ref, seq_num, total_sm);--write long sms
  print("sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
  -----------------------------WRITE PDU SMS--------------------------------------
  print("write single PDU sms\r\n");
  os.set_cscs(CSCS_IRA);
  sms.set_cmgf(0);
  msg_content = "0001000a819914799704000003c8701a";
  local send_len = 15;--similiar to AT+CMGW=15 in PDU mode
  suc, msg_ref_or_err_cause = sms.write(send_len, msg_content);--write single sms
  print("PDU sms.write=", suc, ",", msg_ref_or_err_cause, "\r\n");
  if (not suc) then
    print("failed to write sms\r\n");
    return;
  end;
  suc, msg_ref_or_err_cause = sms.cmss(msg_ref_or_err_cause);
  print("sms.cmss=", suc, ",", msg_ref_or_err_cause, "\r\n");
end;

printdir(1);
collectgarbage();

CSCS_IRA=0
CSCS_GSM=1
CSCS_UCS2=2

local result;

result = sms.ready();
print("sms.ready() = ", result, "\r\n");
if (not result) then
  print("SMS not ready now\r\n");
  return;
end;
--------------------------------------------------------------------------------------------
test_cpms();
--------------------------------------------------------------------------------------------
test_csmp();
--------------------------------------------------------------------------------------------
test_cnmi();
--------------------------------------------------------------------------------------------
test_csca();
--------------------------------------------------------------------------------------------
test_read();
--------------------------------------------------------------------------------------------
test_modify_tag();
--------------------------------------------------------------------------------------------
test_delete();
--------------------------------------------------------------------------------------------
test_write();
--------------------------------------------------------------------------------------------
test_send();
--------------------------------------------------------------------------------------------
test_cmss();

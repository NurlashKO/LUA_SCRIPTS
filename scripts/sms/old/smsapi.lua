printdir(1)

--------------------------------------------------------
--modify sms tag test
rst  = sms.modify_tag(3);--equal AT+CMGMT
print("sms modify msg tag, rst=", rst, "\r\n");

--------------------------------------------------------
--read sms test
rst, sms_cnt = sms.read_msg(1);
print("sms read msg 1, rst=", rst, ", sms_cnt=", sms_cnt, "\r\n");
--[[
rst, sms_cnt = sms.read_msg(15);
print("sms read msg 15, rst=", rst, ", sms_cnt=", sms_cnt, "\r\n");]]

--------------------------------------------------------
--CMGF test
cmgf = sms.get_cmgf();

print("current cmgf=", cmgf, "\r\n");

if (cmgf == 0) then
  cmgf = 1;
else
  cmgf = 0;
end;

sms.set_cmgf(cmgf);

cmgf = sms.get_cmgf();

print("current cmgf=", cmgf, "\r\n");


if (cmgf == 0) then
  cmgf = 1;
else
  cmgf = 0;
end;

sms.set_cmgf(cmgf);

cmgf = sms.get_cmgf();

print("current cmgf=", cmgf, "\r\n");

--------------------------------------------------------
--CSCS test

l_cscs = os.get_cscs();

print("current cscs=", l_cscs, "\r\n");

os.set_cscs(2);

l_cscs = os.get_cscs();

print("current cscs=", l_cscs, "\r\n");

os.set_cscs(1);

l_cscs = os.get_cscs();

print("current cscs=", l_cscs, "\r\n");


--------------------------------------------------------
CSCS_IRA=0
CSCS_GSM=1
CSCS_UCS2=2

--------------------------------------------------------
--convert charset test
in_str = "this is a test";
out_str = sms.convert_chset(in_str, CSCS_IRA, CSCS_UCS2);
print("UCS2= ", out_str, "\r\n");
out_str = sms.convert_chset(in_str, CSCS_IRA, CSCS_HEX);
print("HEX= ", out_str, "\r\n");
out_str = sms.convert_chset(in_str, CSCS_IRA, CSCS_GSM);
print("GSM= ", out_str, "\r\n");

--------------------------------------------------------
--result cause code of sms.send_txtmsg and sms.write_txtmsg
ERR_CODE_CMS_NONE = 0
ERR_CODE_CMS_ME_FAILURE = 300
ERR_CODE_CMS_SERVICE_RESERVED = 301
ERR_CODE_CMS_OP_NOT_ALLOWED = 302
ERR_CODE_CMS_OP_NOT_SUPPORTED = 303
ERR_CODE_CMS_INVALID_PDU_PARAM = 304
ERR_CODE_CMS_INVALID_TXT_PARAM = 305
ERR_CODE_CMS_SIM_NOT_INSERTED = 310
ERR_CODE_CMS_SIM_PIN_REQ = 311
ERR_CODE_CMS_PHSIM_PIN_REQ = 312
ERR_CODE_CMS_SIM_FAILURE = 313
ERR_CODE_CMS_SIM_BUSY = 314
ERR_CODE_CMS_SIM_WRONG = 315
ERR_CODE_CMS_SIM_PUK_REQ = 316
ERR_CODE_CMS_SIM_PIN2_REQ = 317
ERR_CODE_CMS_SIM_PUK2_REQ = 318
ERR_CODE_CMS_MEM_FAILURE = 320
ERR_CODE_CMS_INVALID_INDEX = 321
ERR_CODE_CMS_MEM_FULL = 322
ERR_CODE_CMS_SCA_ADDR_UNKNOWN = 330
ERR_CODE_CMS_NO_SERVICE = 331
ERR_CODE_CMS_NETWORK_TIMEOUT = 332
ERR_CODE_CMS_CNMA_NOT_EXP = 340
ERR_CODE_CMS_BUFFER_OVERFLOW = 341
ERR_CODE_CMS_MSG_SIZE_TOO_BIG = 342
ERR_CODE_CMS_WAITING_CNMA_ACK = 343
ERR_CODE_CMS_UNKNOWN_ERR = 500
ERR_CODE_CMS_SMS_MODULE_BUSY = 900


--------------------------------------------------------
--send sms test, long sms with 2 packets
test_send_sms = false;


dest_addr = "15021309668";
toda = "";
sms_data = "9650523665F695F45230FF0C5F5550CF505C6B62";
cscs = CSCS_UCS2;
msg_ref = sms.get_next_msg_ref();
total_sm = 2;
seq_num = 1;
fo = 17;
dcs = 8;
pid = 0;
vp = "";
local suc, msg_ref_or_err_cause;
print("new msg_ref=", msg_ref, "\r\n");

if (test_send_sms) then
  suc, msg_ref_or_err_cause = sms.send_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
  print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");
end;
total_sm = 2;
seq_num = 2;
sms_data = "5F5550CF8D8565F6";
if (test_send_sms) then
  suc, msg_ref_or_err_cause = sms.send_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
  print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");
end;
--------------------------------------------------------
--send ASCII text sms
os.set_cscs(0);
dest_addr = "14255334129";
toda = "";
sms_data = "Its a good day";
cscs = CSCS_IRA;
msg_ref = sms.get_next_msg_ref();
total_sm = 2;
seq_num = 1;
fo = 17;
dcs = 0;
pid = 0;
vp = "";
local suc, msg_ref_or_err_cause;
print("new msg_ref=", msg_ref, "\r\n");
suc, msg_ref_or_err_cause = sms.send_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");
total_sm = 2;
seq_num = 2;
sms_data = "Its not a good day";
suc, msg_ref_or_err_cause = sms.send_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");


--------------------------------------------------------
--write sms test, long sms with 2 packets
test_write_sms = false;


dest_addr = "15021309668";
toda = "";
sms_data = "9650523665F695F45230FF0C5F5550CF505C6B62";
cscs = CSCS_UCS2;
msg_ref = sms.get_next_msg_ref();
total_sm = 2;
seq_num = 1;
fo = 17;
dcs = 8;
pid = 0;
vp = "";
local suc, msg_ref_or_err_cause;
print("new msg_ref=", msg_ref, "\r\n");
if (test_write_sms) then
  suc, msg_ref_or_err_cause = sms.write_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
  print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");
end;
total_sm = 2;
seq_num = 2;
sms_data = "5F5550CF8D8565F6";

if (test_write_sms) then
  suc, msg_ref_or_err_cause = sms.write_txtmsg(dest_addr, toda, sms_data, cscs, msg_ref, total_sm, seq_num, fo, dcs, pid, vp);
  print("suc=", suc, ", msg_ref_or_err_cause=", msg_ref_or_err_cause, "\r\n");
end;



--------------------------------------------------------
--test decoding sms pdu
SMS_FMT_GW_PP =6

SMS_TPDU_TYPE_DELIVER = 0
SMS_TPDU_TYPE_DELIVER_REPORT_ACK = 1
SMS_TPDU_TYPE_DELIVER_REPORT_ERROR = 2
SMS_TPDU_TYPE_SUBMIT = 3
SMS_TPDU_TYPE_SUBMIT_REPORT_ACK = 4
SMS_TPDU_TYPE_SUBMIT_REPORT_ERROR = 5
SMS_TPDU_TYPE_STATUS_REPORT = 6
SMS_TPDU_TYPE_COMMAND = 7

--[[
at+cmgf=1
OK
at+cmgr=6
+CMGR: 2,"",18
0891683110304105F011640B815120319066F80000A704F4F29C0E

OK

at+cmgr=7
+CMGR: 2,"",27
0891683110304105F011640B818106120070F20000A70E74747A0E4ACF416110BD3CA703

OK

+CMT: "",24
0891683108200105F0040D91683106614508F5000011219161822223044F6A9008

]]
local sms_data_len = 24;
local cmgr_data = "0891683108200105F0040D91683106614508F5000011219161822223044F6A9008";
local sca_address = string.sub(cmgr_data, 1, string.len(cmgr_data) - sms_data_len*2);
print("sca_address=", sca_address, "\r\n");
raw_sms_data = string.sub(cmgr_data, -(sms_data_len*2));
print("sms_data = ", raw_sms_data, "\r\n");
raw_sms_data = string.hex2bin(raw_sms_data);
tpdu_type = SMS_TPDU_TYPE_DELIVER;
print("len of raw_sms_data is ", string.len(raw_sms_data), "\r\n");

print("use IRA to decode\r\n");
dcs, oa, toa, vp, fo, pid, msg_ref, seq_num, total_sm, unpacked_sms_data, discharge_time, status, command = sms.decode_pdumsg(raw_sms_data, SMS_FMT_GW_PP, tpdu_type, CSCS_IRA);

print("dcs = ", dcs, "\r\n");
print("oa = ", oa, "\r\n");
print("toa = ", toa, "\r\n");
print("vp = ", vp, "\r\n");
print("fo = ", fo, "\r\n");
print("pid = ", pid, "\r\n");
print("msg_ref = ", msg_ref, "\r\n");
print("seq_num = ", seq_num, "\r\n");
print("total_sm = ", total_sm, "\r\n");
print("unpacked_sms_data = ", unpacked_sms_data, "\r\n");
print("discharge_time = ", discharge_time, "\r\n");
print("status = ", status, "\r\n");
print("command = ", command, "\r\n");

print("use UCS2 to decode\r\n");
dcs, oa, toa, vp, fo, pid, msg_ref, seq_num, total_sm, unpacked_sms_data, discharge_time, status, command = sms.decode_pdumsg(raw_sms_data, SMS_FMT_GW_PP, tpdu_type, CSCS_UCS2);

print("dcs = ", dcs, "\r\n");
print("oa = ", oa, "\r\n");
print("toa = ", toa, "\r\n");
print("vp = ", vp, "\r\n");
print("fo = ", fo, "\r\n");
print("pid = ", pid, "\r\n");
print("msg_ref = ", msg_ref, "\r\n");
print("seq_num = ", seq_num, "\r\n");
print("total_sm = ", total_sm, "\r\n");
print("unpacked_sms_data = ", unpacked_sms_data, "\r\n");
print("discharge_time = ", discharge_time, "\r\n");
print("status = ", status, "\r\n");
print("command = ", command, "\r\n");


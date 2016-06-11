function handle_received_sio_data(hdr_idx)
  --print("hdr_idx=",hdr_idx,"\r\n");
  if (hdr_idx == SIO_OK_RECVED) then
    --received OK
    return string.len(sio_rpt_hdr[0]);
  elseif (hdr_idx == SIO_ERROR_RECVED) then
    --received ERROR
    return string.len(sio_rpt_hdr[1]);
  elseif (hdr_idx == SIO_CME_ERROR_RECVED) then
    --received +CME ERROR
    --return...
  elseif (hdr_idx == SIO_CMMSSEND_RECVED) then
    --received +CMMSSEND
    if (string.startwith(sio_recved_string,"\r\n+CMMSSEND: 0\r\n")) then
      --succeeded in sending mms
      main_state = 0;
      return string.len("\r\n+CMMSSEND: 0\r\n");
    else
      --Failed in sending mms, find the "\r\n" after +CMMSSEND:
      local end_pos = string.absfind(sio_recved_string,"\r\n",3);
      if (end_pos) then
        return end_pos;
      end;
    end;
  elseif (hdr_idx == SIO_CMMSRECV_RECVED) then
    --received +CMMSRECV
    if (string.startwith(sio_recved_string,"\r\n+CMMSRECV: 0\r\n")) then
      --succeeded in sending mms
      main_state = 0;
      return string.len("\r\n+CMMSRECV: 0\r\n");
    else
      --Failed in sending mms, find the "\r\n" after +CMMSRECV:
      local end_pos = string.absfind(sio_recved_string,"\r\n",3);
      if (end_pos) then
        return end_pos + 1;
      end;
    end;
  elseif (hdr_idx == SIO_WAP_PUSH_MMS_RECVED) then
    --received +WAP_PUSH_MMS
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    if (end_pos) then
      return end_pos + 1;
    end;
  elseif (hdr_idx == SIO_CSQ_RECVED) then
    --received +CSQ:
    --print("received +CSQ\r\n");
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    print("end_pos=",end_pos,"\r\n");
    if (end_pos) then
      return end_pos + 1;
    end;
  elseif (hdr_idx == SIO_CPIN_RECVED) then
    --received +CPIN:
    local end_pos = string.absfind(sio_recved_string,"\r\n",3);
    if (end_pos) then
      return end_pos + 1;
    end;
  end;
  return 0;
end;
-----------------------------------
--all possible sio report data headers
--const value
SIO_OK_RECVED            = 0
SIO_ERROR_RECVED         = 1
SIO_CME_ERROR_RECVED     = 2
SIO_CMMSSEND_RECVED      = 3
SIO_CMMSRECV_RECVED      = 4
SIO_WAP_PUSH_MMS_RECVED  = 5
SIO_CSQ_RECVED           = 6
SIO_CPIN_RECVED          = 7

sio_rpt_hdr = {};
sio_rpt_hdr[SIO_OK_RECVED]           = "\r\nOK\r\n";
sio_rpt_hdr[SIO_ERROR_RECVED]        = "\r\nERROR\r\n";
sio_rpt_hdr[SIO_CME_ERROR_RECVED]    = "\r\n+CME ERROR:";
sio_rpt_hdr[SIO_CMMSSEND_RECVED]     = "\r\n+CMMSSEND:";
sio_rpt_hdr[SIO_CMMSRECV_RECVED]     = "\r\n+CMMSRECV:";
sio_rpt_hdr[SIO_WAP_PUSH_MMS_RECVED] = "\r\n+WAP_PUSH_MMS:";
sio_rpt_hdr[SIO_CSQ_RECVED]          = "\r\n+CSQ:";
sio_rpt_hdr[SIO_CPIN_RECVED]         = "\r\n+CPIN:";
-----------------------------------

-----------------------------------
--main state enum of this script
--0 = idle
MAIN_STATE_IDLE           = 0
--1 = verifing pin
MAIN_STATE_VERIFY_PIN     = 1
--2 = sending mms
MAIN_STATE_SEND_MMS       = 2
--3 = receiving mms
MAIN_STATE_RECV_MMS       = 3
--4 = dialing
MAIN_STATE_DIAL           = 4
--5 = sending sms
MAIN_STATE_SEND_SMS       = 5

--initial state is idle
main_state = MAIN_STATE_IDLE;
-----------------------------------

sio_recved_string = "";

printdir(1);
sio.send("ATE0\r\n");
sio.recv(5000);
sio.clear();
while(true)do
  local found_matched_hdr_idx = -1;
  local rsp = sio.recv(5000);

  sio_recved_string = string.concat(sio_recved_string,rsp);
  print(" sio_recved_string.len=",string.len(sio_recved_string),"\r\n");
  if (string.len(sio_recved_string) > 0) then
    for idx, val in pairs(sio_rpt_hdr) do
      --print("val=",val,"\r\n");
      if (string.startwith(sio_recved_string,val)) then
        found_matched_hdr_idx = idx;
        print("found idx=", idx, "\r\n");
        break;
      end;
    end;
  end;
  --handle the found hdr
  if (found_matched_hdr_idx >= 0) then
    local used_len = handle_received_sio_data(found_matched_hdr_idx);
    if (used_len == string.len(sio_recved_string)) then
      sio_recved_string = "";
    elseif (used_len > 0) then
      sio_recved_string = string.sub(sio_recved_string,used_len+1,string.len(sio_recved_string));
    end;
  elseif (string.len(sio_recved_string) > 0) then
    sio_recved_string = string.sub(sio_recved_string,2,string.len(sio_recved_string));
  end;
end;
function trace_call_list()
  print("call voice_call.list()...\r\n");
  local call_list = voice_call.list();
  if (call_list) then
    print("call_list=\r\n{\r\n", call_list, "}\r\n");
  else
   print("no call list got\r\n");
  end;
end;

function test_mo_call(phone_num)
  local call_id;
  local result;
  local call_list;
  local call_ss_mask = VOICE_CALL_SS_MASK_NONE;
  --local call_ss_mask = VOICE_CALL_SS_MASK_SUPRESS_CLIR;
  print("call voice_call.initiate()...");
  --call_id = voice_call.initiate(phone_num);
  call_id = voice_call.initiate(phone_num, call_ss_mask);
  if (not call_id) then
    print("failed to initiate voice call\r\n");
    return;
  end;
  print("call_id = ", call_id, "\r\n");

  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == CALL_EVENT_ID and call_id == evt_p2) then
      if (evt_p1 == CALL_STATE_ACTIVE) then
	    print("call connected\r\n");
	    break;
	  elseif (evt_p1 == CALL_STATE_DIALING) then
	    print("call dialing\r\n");
	  elseif (evt_p1 == CALL_STATE_ALERTING) then
	    print("call alerting\r\n");
	  elseif (evt_p1 == CALL_STATE_DISCONNECTED) then
	    print("call disconnected\r\n");
	    return;
	  end;
	  trace_call_list();
    end;
  end;
  local state = voice_call.state(call_id);
  print("call state[", call_id, "]=", state, "\r\n");
  
  print("call voice_call.send_dtmf(123456#)...\r\n");
  result = voice_call.send_dtmf(call_id, "123456#");--maximum 28 dtmf codes in string
  print("voice_call.send_dtmf, result=", result, "\r\n");
  
  print("call voice_call.send_dtmf(*)...\r\n");
  result = voice_call.send_dtmf(call_id, "*");--maximum 28 dtmf codes in string
  print("voice_call.send_dtmf, result=", result, "\r\n");
  
  print("please send five dtmf codes...\r\n");
	local rx_dtmf_count = 0;
	while (true) do
      local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	  if (evt ~= -1) then
	    print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	  end;
      if (evt and evt == CALL_EVENT_ID) then	    
		if (evt_p1 == CALL_RX_DTMF) then
		  rx_dtmf_count = rx_dtmf_count + 1;
		  local dtmf_code = evt_p2;
		  print(string.format("receive DTMF '%c'\r\n", dtmf_code));
		  if (rx_dtmf_count >= 5) then
		    break;
		  end;
		else
		  trace_call_list();
	      if (evt_p1 == CALL_STATE_DISCONNECTED) then
	        print("call disconnected\r\n");
		    return;
	      end;	  
		end;
      end;
    end;

  print("call voice_call.hangup()...\r\n");
  result = voice_call.hangup(call_id);--if no parameter input, end all calls: voice_call.huangup(nil)
  if (not result) then
    print("failed to end call\r\n");
    return;
  end;

  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == CALL_EVENT_ID  and call_id == evt_p2) then
	  trace_call_list();
	  if (evt_p1 == CALL_STATE_DISCONNECTED) then
	    print("call disconnected\r\n");
		break;
	  end;	  
    end;
  end;

  print("succeeded in ending call\r\n");
end;

function test_mt_call()
  print("please call this module\r\n");
  local has_call_inciming = false;
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == CALL_EVENT_ID) then
	  trace_call_list();
	  if (evt_p1 == CALL_STATE_INCOMING or evt_p1 == CALL_STATE_WAITING) then
	    print("call incoming\r\n");
		has_call_inciming = true;
		break;
	  end;	  
    end;
  end;
  if (has_call_inciming) then
    print("call voice.answer()...\r\n");
	local answered_calls = voice_call.answer();--answer all incoming calls. voice_call.answer(call_id) can be used to answer the call with call_id parameter.
	if (answered_calls) then
	  for idx = 1, table.maxn(answered_calls), 1 do
	    print("call[", answered_calls[idx], "] answered\rn");
	  end;
	else
	  print("failed to answer call\r\n");
	end;
	
	print("please send five dtmf codes...\r\n");
	local rx_dtmf_count = 0;
	while (true) do
      local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	  if (evt ~= -1) then
	    print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	  end;
      if (evt and evt == CALL_EVENT_ID) then	    
		if (evt_p1 == CALL_RX_DTMF) then
		  rx_dtmf_count = rx_dtmf_count + 1;
		  local dtmf_code = evt_p2;
		  print(string.format("receive DTMF '%c'\r\n", dtmf_code));
		  if (rx_dtmf_count >= 5) then
		    break;
		  end;
		else
		  trace_call_list();
	      if (evt_p1 == CALL_STATE_DISCONNECTED) then
	        print("call disconnected\r\n");
		    return;
	      end;	  
		end;
      end;
    end;
	print("call voice_call.hangup()...\r\n");
    result = voice_call.hangup();--if no parameter input, end all calls
    if (not result) then
      print("failed to end call\r\n");
      return;
    end;

    while (true) do
      local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	  if (evt ~= -1) then
	    print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	  end;
      if (evt and evt == CALL_EVENT_ID) then
	    trace_call_list();
	    if (evt_p1 == CALL_STATE_DISCONNECTED) then
	      print("call disconnected\r\n");
		  break;
	    end;	  
      end;
    end;

    print("succeeded in ending call\r\n");
  end;
end;

function test_mo_call_with_chld(phone_num)
  local call_id;
  local result;
  local call_list;
  print("call voice_call.initiate()...");
  call_id = voice_call.initiate(phone_num);
  if (not call_id) then
    print("failed to initiate voice call\r\n");
    return;
  end;
  print("call_id = ", call_id, "\r\n");

  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == CALL_EVENT_ID and call_id == evt_p2) then
      if (evt_p1 == CALL_STATE_ACTIVE) then
	    print("call connected\r\n");
	    break;
	  elseif (evt_p1 == CALL_STATE_DIALING) then
	    print("call dialing\r\n");
	  elseif (evt_p1 == CALL_STATE_ALERTING) then
	    print("call alerting\r\n");
	  elseif (evt_p1 == CALL_STATE_DISCONNECTED) then
	    print("call disconnected\r\n");
	    return;
	  end;
	  trace_call_list();
    end;
  end;
  local state = voice_call.state(call_id);
  print("call state[", call_id, "]=", state, "\r\n");
  
  local seq_no = voice_call.id2seq(call_id);--get the <idX> in AT+CLCC
  print("voice_call.id2seq(", call_id, ")=", seq_no,"\r\n");
  
  local converted_call_id = voice_call.seq2id(seq_no);--get the inner call id using <idX> in AT+CLCC
  print("voice_call.seq2id(", seq_no, ")=", converted_call_id,"\r\n");
  
  vmsleep(2000);

  print("call voice_call.chld(1 or 1x)...\r\n");
  --result = voice_call.chld(CALL_CHLD_CMD_1);
  result = voice_call.chld(CALL_CHLD_CMD_1X, call_id);
  if (not result) then
    print("Error! failed to end call using AT+CHLD\r\n");	
  end;

  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p2, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == CALL_EVENT_ID  and call_id == evt_p2) then
	  trace_call_list();
	  if (evt_p1 == CALL_STATE_DISCONNECTED) then
	    print("call disconnected\r\n");
		break;
	  end;	  
    end;
  end;

  print("succeeded in ending call\r\n");
end;

printdir(1);
----------------------------------------------------------
--for the 2nd parameter of voice_call.initiate(), default 0
VOICE_CALL_SS_MASK_NONE = 0;--default
VOICE_CALL_SS_MASK_ENABLE_CCUG = 4 --enable ccug
VOICE_CALL_SS_MASK_DISABLE_CCUG = 8 --disable ccug
VOICE_CALL_SS_MASK_ACTIVE_CLIR = 16--show calling number to called party
VOICE_CALL_SS_MASK_SUPRESS_CLIR = 32--hide calling number to called party

----------------------------------------------------------
CALL_EVENT_ID = 21;

CALL_STATE_ACTIVE = 0;
CALL_STATE_HELD = 1;
CALL_STATE_DIALING = 2;
CALL_STATE_ALERTING = 3;
CALL_STATE_INCOMING = 4;
CALL_STATE_WAITING = 5;
CALL_STATE_DISCONNECTED = 6;
CALL_RX_DTMF = 250;
----------------------------------------------------------
CALL_CHLD_CMD_0 = 0
CALL_CHLD_CMD_1 = 1
CALL_CHLD_CMD_1X = 2
CALL_CHLD_CMD_2 = 3
CALL_CHLD_CMD_2X = 4
CALL_CHLD_CMD_3 = 5
CALL_CHLD_CMD_4 = 6
--[[
for voice_call.chld(chld_cmd, call_id), usage:
voice_call.chld(CALL_CHLD_CMD_0)
voice_call.chld(CALL_CHLD_CMD_1)
voice_call.chld(CALL_CHLD_CMD_1X, call_id)
voice_call.chld(CALL_CHLD_CMD_2)
voice_call.chld(CALL_CHLD_CMD_2X, call_id)
voice_call.chld(CALL_CHLD_CMD_3)
voice_call.chld(CALL_CHLD_CMD_4)
]]
----------------------------------------------------------
test_mo_call("18652845698");
test_mt_call();
test_mo_call_with_chld("10010");
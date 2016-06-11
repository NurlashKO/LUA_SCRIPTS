function trace_pin_status()
  local info = pin.remain_info();
  if (not info) then
    print("failed to get PIN remain information\r\n");
    return;
  end;
  print("PIN1 left retry=", info.pin1_left_retries, ", left unblock retries=", info.pin1_left_unblock_retries, ", status=", info.pin1_status, "\r\n");
  print("PIN2 left retry=", info.pin2_left_retries, ", left unblock retries=", info.pin2_left_unblock_retries, ", status=", info.pin1_status, "\r\n");
end;

function verify_pin(pin_id, pin_code)
  local result = pin.verify(pin_id, pin_code);
  if (not result) then
    print("failed to verify pin,", pin_id, "\r\n");
  else
    print("succeeded in verifing pin\r\n");
  end;
end;

function change_pin(pin_id, old_pin_code, new_pin_code)
  print("call change pin...\r\n");
  local result = pin.change(pin_id, old_pin_code, new_pin_code);
  if (not result) then
    print("failed to change pin,", pin_id, "\r\n");
  else
    print("succeeded in changing pin\r\n");
  end;
end;

function unblock_pin(pin_id, puk_code, new_pin_code)
  local result = pin.unblock(pin_id, puk_code, new_pin_code);
  if (not result) then
    print("failed to unblock pin,", pin_id, "\r\n");
  else
    print("succeeded in unblocking pin\r\n");
  end;
end;

function enable_pin(pin_id, pin_code, enable)
  local result = pin.enable(pin_id, pin_code, enable);
  if (not result) then
    print("failed to call pin.eanble,", pin_id, "\r\n");
  else
    print("succeeded in calling pin.enable\r\n");
  end;
end;

printdir(1);

PIN_STATUS_NOT_INITIALIZED = 0;
PIN_STATUS_ENABLED_NOT_VERIFIED = 1;
PIN_STATUS_ENABLED_VERIFIED = 2;
PIN_STATUS_DISABLED = 3;
PIN_STATUS_BLOCKED = 4;
PIN_STATUS_PERM_BLOCKED = 5;
PIN_STATUS_UNBLOCKED = 5;
PIN_STATUS_CHANGED = 6;

PIN1_ID = 0
PIN2_ID = 1

trace_pin_status();

verify_pin(PIN1_ID, "2345");--test wrong pin
trace_pin_status();


verify_pin(PIN1_ID, "1234");--test correct pin
trace_pin_status();

change_pin(PIN1_ID, "1234", "4321");
trace_pin_status();


change_pin(PIN1_ID, "4321", "1234");
trace_pin_status();

unblock_pin(PIN1_ID, "81236219", "1234");
trace_pin_status();

enable_pin(PIN1_ID, "1234", false);
trace_pin_status();
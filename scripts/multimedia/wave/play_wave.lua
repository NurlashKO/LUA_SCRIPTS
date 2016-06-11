printdir(1)

MULTIMEDIA_EVENT_ID = 36

EVT_P1_WAVE = 0

WAVE_STATE_STOP = 0
WAVE_STATE_PLAY = 1

WAVE_PLAY_TO_LOCAL = 1
WAVE_PLAY_TO_REMOTE = 2 -- play wave file to remote in voice call.

function play_wav_wait_stop(wav_path)
  local result;
  result = multimedia.play_wav(wav_path, WAVE_PLAY_TO_LOCAL);
  print("multimedia.play_wav(), result=", result, "\r\n");

  if (not result) then
    return;
  end;

  local state = multimedia.wav_state();
  print("wave state=", state, "\r\n");

  print("Wait WAVE event now...\r\n");
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p3, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == MULTIMEDIA_EVENT_ID and evt_p1 == EVT_P1_WAVE) then
	  local wav_state = evt_p2;
	  if (wav_state == WAVE_STATE_PLAY) then
	    print("wave playing now...\r\n");
      elseif (wav_state == WAVE_STATE_STOP) then
	    print("wave stopped now...\r\n");
		break;
	  end;
    end;
  end;
end;

function play_wav_500_ms(wav_path)
  local result;
  result = multimedia.play_wav(wav_path, WAVE_PLAY_TO_LOCAL);
  print("multimedia.play_wav(), result=", result, "\r\n");

  if (not result) then
    return;
  end;

  local state = multimedia.wav_state();
  print("wave state=", state, "\r\n");
  
  print("wait 500 ms\r\n");
  vmsleep(500);
  result = multimedia.stop_wav();
  print("multimedia.stop_wav=", result, "\r\n");
  print("Wait WAVE event now...\r\n");
  while (true) do
    local evt, evt_p1, evt_p2, evt_p3, evt_clock = thread.waitevt(15000);
	if (evt ~= -1) then
	  print("waited event, ", evt, ", ", evt_p1, ", ", evt_p2, ", ", evt_p3, ", ", evt_clock, "\r\n");
	end;
    if (evt and evt == MULTIMEDIA_EVENT_ID and evt_p1 == EVT_P1_WAVE) then
	  local wav_state = evt_p2;
	  if (wav_state == WAVE_STATE_PLAY) then
      elseif (wav_state == WAVE_STATE_STOP) then
	    print("wave stopped now...\r\n");
		break;
	  end;
    end;
  end;
end;

--ONLY 8KHZ 16bit wave format file is supported. When using WAVE playing API, the AT+CODEC must be set to NB-AMR only(WB-AMR cannot work).

play_wav_wait_stop("C:\\test.wav");
play_wav_500_ms("C:\\test.wav");
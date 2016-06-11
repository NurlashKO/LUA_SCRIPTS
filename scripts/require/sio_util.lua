function sio_send(cmd)
  print(">>>>>>>>>>>>>>", cmd);
  result = sio.send(cmd);
  return result;
end;

function sio_recv(timeout)  
  local rsp = sio.recv(timeout);
  if (rsp) then
    print("<<<<<<<<<<<<<<", rsp);
  end;
  return rsp;
end;

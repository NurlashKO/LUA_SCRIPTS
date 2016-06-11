printdir(1)

print("---------------------begin test---------------------\r\n");

vmsetpri(1)
count = 0;
while (count < 10) do
  count = count + 1;
  print("+CMYPRIORITY: ",vmgetpri(),"(low)","\r\n");
  vmsleep(500);
end;

vmsetpri(2)
count = 0;
while (count < 10) do
  count = count + 1;
  print("+CMYPRIORITY: ",vmgetpri(),"(medium)","\r\n");
  vmsleep(500);
end;

vmsetpri(3)
count = 0;
while (count < 10) do
  count = count + 1;
  print("+CMYPRIORITY: ",vmgetpri(),"(high)","\r\n");
  vmsleep(500);
end;

print("---------------------finished test---------------------\r\n");
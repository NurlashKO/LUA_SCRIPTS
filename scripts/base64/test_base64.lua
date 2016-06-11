-- test base64 library

printdir(1);
print(base64.version)
print"\r\n"

function test(s)
 local a=base64.encode(s)
 local b=base64.decode(a)
 print(string.len(s)," ", b==s," ", a," ", s, "\r\n")
 assert(b==s)
end

for i=0,9 do
 local s=string.sub("Lua-scripting-language",1,i)
 test(s)
end

function test(p)
 print("testing prefix "..string.len(p), "\r\n")
 for i=0,255 do
  local s=p..string.char(i)
  local a=base64.encode(s)
  local b=base64.decode(a)
  assert(b==s,i)
 end
end

print""
test""
test"x"
test"xy"
test"xyz"

print""
s="Lua-scripting-language"
a=base64.encode(s)
b=base64.decode(a)
print("RST1 ", a," ", b," ", string.len(b), "\r\n")

a=base64.encode(s)
a=string.gsub(a,"[A-Z]","?")
b=base64.decode(a)
print("RST2 ", a," ", b, "\r\n")

a=base64.encode(s)
a=string.gsub(a,"[a-z]","?")
b=base64.decode(a)
print("RST3 ", a," ", b, "\r\n")

a=base64.encode(s)
a=string.gsub(a,"[A-Z]","=")
b=base64.decode(a)
print("RST4 ", a," ", b," ", string.len(b), "\r\n")

a=base64.encode(s)
a=string.gsub(a,"[a-z]","=")
b=base64.decode(a)
print("RST5 ", a," ", b," ", string.len(b), "\r\n")

print"\r\n"
print(base64.version, "\r\n")

-- eof

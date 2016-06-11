-- test ascii85 library

printdir(1);
print(ascii85.version, "\r\n")
print"\r\n"

function test(s)
 --print""
 --print(string.len(s),s)
 local a=ascii85.encode(s)
 --print(string.len(a),a)
 local b=ascii85.decode(a)
 --print(string.len(b),b)
 print(string.len(s)," ", b==s," ", a,s, " ", "\r\n")
 assert(b==s)
end

for i=0,13 do
 local s=string.sub("Lua-scripting-language",1,i)
 test(s)
end

function test(p)
 print("testing prefix "..string.len(p), "\r\n")
 for i=0,255 do
  local s=p..string.char(i)
  local a=ascii85.encode(s)
  local b=ascii85.decode(a)
  assert(b==s,i)
 end
end

print"\r\n"
test""
test"x"
test"xy"
test"xyz"

print"\r\n"
print(ascii85.version)

-- eof

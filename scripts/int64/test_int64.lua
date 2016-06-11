-- test int64 library

------------------------------------------------------------------------------
printdir(1);
print(int64.version, "\r\n")

local function testing(...)
	print("------\r\n", ...)
end

testing("min and max values\r\m")
print("min"," ", int64.min, "\r\n")
print("max"," ", int64.max, "\r\n")
assert(int64.min==-int64.max-1)

z=int64.new(2)
z=z^63-1
assert(z==int64.max)
z=-z
z=z-1
assert(z==int64.min)

function test(b)
	testing("powers of ",b)
	b=int64.new(b)
	local z=int64.new(1)
	for i=0,100 do
		--print(i,z,b^i)
		assert(z==b^i)
		z=b*z
	end
end

test(2)
test(3)

testing"factorials"
print("\r\n");

F={
[1]="1",
[2]="2",
[3]="6",
[4]="24",
[5]="120",
[6]="720",
[7]="5040",
[8]="40320",
[9]="362880",
[10]="3628800",
[11]="39916800",
[12]="479001600",
[13]="6227020800",
[14]="87178291200",
[15]="1307674368000",
[16]="20922789888000",
[17]="355687428096000",
[18]="6402373705728000",
[19]="121645100408832000",
[20]="2432902008176640000",
[21]="51090942171709440000",
[22]="1124000727777607680000",
[23]="25852016738884976640000",
[24]="620448401733239439360000",
[25]="15511210043330985984000000",
}
z=int64.new(1)
f=1
for i=1,25 do
	z=z*i
	f=f*i
	s=int64.tonumber(z)
	print(i," ", z," ", f," ", f==int64.tonumber(z)," ", int64.__tostring(z)==F[i], "\r\n")
	--print(i,int64.new(F[i]))
end

print(int64.version, "\r\n")

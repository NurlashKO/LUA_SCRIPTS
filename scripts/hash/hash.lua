function tohex(s)
   return (s:gsub(".", function (x)
			 return ("%02x"):format(x:byte())
		      end))
end

printdir(1)

print "MD5:\r\n"

print "9e107d9d372bb6826bd81d3542a419d6 <-- Correct\r\n"
print(tohex(md5.sum "The quick brown fox jumps over the lazy dog"),"\r\n")

foo = md5.init()
foo:update "The quick brown fox jumps over the lazy dog"
bing = foo:final()
print(tohex(bing))

print "\nSHA1:\r\n"

print "2fd4e1c67a2d28fced849ee1bb76e7391b93eb12 <-- Correct\r\n"
print(tohex(sha1.sum "The quick brown fox jumps over the lazy dog"),"\r\n")
foo = sha1.init()
foo:update "The quick brown fox jumps over the lazy dog"
bing = foo:final()
print(tohex(bing))

print "\nSHA256:\r\n"

print(tohex(sha256.sum "The quick brown fox jumps over the lazy dog"),"\r\n")

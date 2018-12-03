local inp = assert(io.open("input","r"))
local device_freq = 0
for freq in inp:lines() do
  device_freq = device_freq + (tonumber(freq))
end
inp:close()
print('final device_freq', device_freq)

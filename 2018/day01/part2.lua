local inp = assert(io.open("input","r"))
local freq_list = {}

for freq in inp:lines() do
  freq_list[#freq_list+1]= (tonumber(freq))
end
inp:close()


local device_freq = 0
local all_freq = {}
local loop = true
repeat
  for i, freq in ipairs(freq_list) do
    if all_freq[device_freq] then
      loop = false
      break
    else
      all_freq[device_freq] = true
    end
    device_freq = device_freq + freq
  end
until not loop

print('first freq to be reached twice', device_freq)


local function updatecount(w, twice, three)
  local arrw = {}
  local tw, th = false, false
  for c in w:gmatch('.') do
    arrw[c] = (arrw[c] or 0) + 1
  end
  for c, count in pairs(arrw) do
    if count == 2 and not tw then
      tw = true
      twice = twice + 1
    elseif count == 3 and not th then
      th = true
      three = three + 1
    end
  end
  return twice, three
end

local inp = assert(io.open("input","r"))
local twice, three = 0, 0
for w in inp:lines() do
  twice, three = updatecount(w, twice, three)
end
inp:close()

print('numbers having letters which appear twice',twice)
print('numbers having letters which appear three',three)
print('checksum',twice * three)
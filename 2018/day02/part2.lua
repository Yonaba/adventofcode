
local function compare(w1, w2)
  local c1, c2
  local diff, set = 0, {}
  for i = 1, #w1 do
    c1 = w1:sub(i,i)
    c2 = w2:sub(i,i)
    if c1 ~= c2 then 
      diff = diff + 1
    else
      set[#set+1] = c1
    end
  end
  return diff, set
end

local inp = assert(io.open("input","r"))
local IDs = {}
for id in inp:lines() do
  IDs[#IDs + 1] = id
end
inp:close()

local diff, cur_diff = math.huge, math.huge
local letters, cur_letters
for i = 1, #IDs-1 do
  for j = i+1, #IDs do 
    cur_diff, cur_letters = compare(IDs[i], IDs[j])
    if cur_diff < diff then
      diff = cur_diff
      letters = cur_letters
    end
  end
end

print('smallest difference', diff)
print('letters : ', table.concat(letters))
local function tonumbers(...)
  local args = {...}
  for k, v in ipairs(args) do
    args[k] = tonumber(v)
  end
  return unpack(args)
end

local function parse_claim(line)
  return line:match('^#(%d+)%s@%s(%d+),(%d+):%s(%d+)x(%d+)')
end

local function overlaps(a, b)
  local x1, y1, w1, h1 = a.x, a.y, a.w, a.h
  local x2, y2, w2, h2 = b.x, b.y, b.w, b.h
  return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1
end

local function test_claim(claim_id, claims)
  for i in pairs(claims) do
    if i ~= claim_id and overlaps(claims[claim_id], claims[i]) then
      return false
    end
  end
  return true
end

local claims = {}
local inp = assert(io.open("input", "r"), "could not open input")

for line in inp:lines() do
  local id, x, y, w, h = parse_claim(line)
  id, x, y, w, h = tonumbers(id, x, y, w, h)
  claims[id] = {x = x+1, y = y+1, w = w, h = h}
end

inp:close()

for i in ipairs(claims) do
  local test = test_claim(i, claims)
  if test then
    print("The non-overlapping claim is : #"..i)
  end
end
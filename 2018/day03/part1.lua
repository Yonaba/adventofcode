
local function parse_claim(line)
  return line:match('^#(%d+)%s@%s(%d+),(%d+):%s(%d+)x(%d+)')
end

local function register_claim(x, y, w, h, claims)
  for cx = x+1, x+w do
    if not claims[cx] then claims[cx] = {} end
    for cy = y+1, y+h do
      claims[cx][cy] = (claims[cx][cy] or 0) + 1
    end
  end
end

local function count(claims, limit)
  local n = 0
  for x, cx in pairs(claims) do
    for y, v in pairs(cx) do
      if v >= limit then n = n + 1 end
    end
  end
  return n
end


local claims = {}
local inp = assert(io.open("input", "r"), "could not open input")

for line in inp:lines() do
  local _, x, y, w, h = parse_claim(line)
  register_claim(x, y, w, h, claims)
end

inp:close()
print("Number of nodes >= 2", count(claims, 2))
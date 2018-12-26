local function sameType(chain)
  local u, v = chain:match("(%w)(%w)")
  return (u:lower() == v:lower())
end

local function oppositePolarity(chain)
  return (chain:match("%u%U") or chain:match("%U%u"))
end

local inp = assert(io.open("input", "r"), "could not open input")
local polymer = inp:read("*a")
inp:close()

polymer = polymer:sub(1,#polymer-1)
local n, i = #polymer, 0
local chain, react

repeat
  i = i + 1
  chain = polymer:sub(i,i+1)
  react = sameType(chain) and oppositePolarity(chain)
  if react then
    polymer = polymer:sub(1,i-1)..polymer:sub(i+2,n)
    i = i-2 < 0 and 0 or i-2
    n = #polymer
  end
until (i == n-1)

print("units remaining after full reaction", #polymer)
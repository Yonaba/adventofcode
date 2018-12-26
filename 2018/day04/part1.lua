local function parse_guard_id(line)
  local id = line:match('Guard #(%d+) begins shift')
  if id then return tonumber(id) end
end

local function parse_asleep(line)
  return not not (line:match('falls asleep'))
end

local function parse_wakeup(line)
  return not not (line:match('wakes up'))
end

local function parse_minute(line)
  return line:match(':(%d%d)')
end

local function highest_count(t)
  local f = {}
  for k, v in ipairs(t) do
    if not f[v] then f[v] = 1 
    else f[v] = f[v] + 1 
    end
  end
  local max_count, max_value = 0
  for value, count in pairs(f) do
    if count > max_count then
      max_count = count
      max_value = value
    end
  end
  return max_value
end

local inp = assert(io.open("input", "r"), "could not open input")
local logs = {}
for line in inp:lines() do
 logs[#logs + 1] = line
end
inp:close()

table.sort(logs)

local cur_id, asleep_time, wakeup_time
local guards = {}
for i, log in ipairs(logs) do
  local minute = parse_minute(log)
  local id = parse_guard_id(log)
  if id then
    if not guards[id] then guards[id] = {time = 0, minutes = {}} end
    cur_id = id
    asleep_time, wakeup_time = nil, nil
  end
  if parse_asleep(log) then
    asleep_time = minute
  elseif parse_wakeup(log) then
    wakeup_time = minute
    guards[cur_id].time = guards[cur_id].time + (wakeup_time - asleep_time)
    for i = asleep_time, wakeup_time - 1 do
      table.insert(guards[cur_id].minutes, i)
    end
  end
end

local highest_sleep, id_sleep = 0
for id in pairs(guards) do
  if guards[id].time > highest_sleep then
    highest_sleep = guards[id].time
    id_sleep = id
  end
end

print("Guard who slept the most minutes", id_sleep)
print("Minute he slept the most", highest_count(guards[id_sleep].minutes))
print("Answer", id_sleep * highest_count(guards[id_sleep].minutes))
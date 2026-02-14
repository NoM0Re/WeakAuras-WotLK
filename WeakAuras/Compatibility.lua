local ipairs = ipairs
local pairs = pairs
local ceil, floor = math.ceil, math.floor
local tRemove = table.remove
local tInsert = table.insert

local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

function noop() end

function ipairs_reverse(table)
  local function Enumerator(table, index)
    index = index - 1
    local value = table[index]
    if value ~= nil then
      return index, value
    end
  end
  return Enumerator, table, #table + 1
end

function tDeleteItem(tbl, item)
  local size = #tbl
  local index = size
  while index > 0 do
    if item == tbl[index] then
      tRemove(tbl, index)
    end
    index = index - 1
  end
  return size - #tbl
end

function tContains(tbl, item)
  for k, v in pairs(tbl) do
    if item == v then
      return true
    end
  end
  return false
end

function tInvert(tbl)
  local inverted = {}
  for k, v in pairs(tbl) do
    inverted[v] = k
  end
  return inverted
end

function Round(value)
  if value < 0.0 then
    return ceil(value - 0.5)
  end
  return floor(value + 0.5)
end

function tIndexOf(tbl, item)
  for i, v in ipairs(tbl) do
    if item == v then
      return i
    end
  end
end

function TableHasAnyEntries(tbl)
  return next(tbl) ~= nil
end

function tAppendAll(table, addedArray)
  for i, element in ipairs(addedArray) do
    tInsert(table, element)
  end
end

function MergeTable(destination, source)
  for k, v in pairs(source) do
    destination[k] = v
  end
end

function tCompare(lhsTable, rhsTable, depth)
  depth = depth or 1
  for key, value in pairs(lhsTable) do
    if type(value) == "table" then
      local rhsValue = rhsTable[key]
      if type(rhsValue) ~= "table" then
        return false
      end
      if depth > 1 then
        if not tCompare(value, rhsValue, depth - 1) then
          return false
        end
      end
    elseif value ~= rhsTable[key] then
      return false
    end
  end

  for key, value in pairs(rhsTable) do
    if lhsTable[key] == nil then
      return false
    end
  end

  return true
end

function IsInGroup()
  return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

function IsInRaid()
  return GetNumRaidMembers() > 0
end

function GetNumSubgroupMembers()
  return GetNumPartyMembers()
end

function GetNumGroupMembers()
  return IsInRaid() and GetNumRaidMembers() or GetNumPartyMembers()
end

RAID_CLASS_COLORS.HUNTER.colorStr = "ffabd473"
RAID_CLASS_COLORS.WARLOCK.colorStr = "ff8788ee"
RAID_CLASS_COLORS.PRIEST.colorStr = "ffffffff"
RAID_CLASS_COLORS.PALADIN.colorStr = "fff58cba"
RAID_CLASS_COLORS.MAGE.colorStr = "ff3fc7eb"
RAID_CLASS_COLORS.ROGUE.colorStr = "fffff569"
RAID_CLASS_COLORS.DRUID.colorStr = "ffff7d0a"
RAID_CLASS_COLORS.SHAMAN.colorStr = "ff0070de"
RAID_CLASS_COLORS.WARRIOR.colorStr = "ffc79c6e"
RAID_CLASS_COLORS.DEATHKNIGHT.colorStr = "ffc41f3b"

function WrapTextInColorCode(text, colorHexString)
  return ("|c%s%s|r"):format(colorHexString, text)
end

function CreateTextureMarkup(file, fileWidth, fileHeight, width, height, left, right, top, bottom, xOffset, yOffset)
  return ("|T%s:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d|t"):format(
    file,
    height,
    width,
    xOffset or 0,
    yOffset or 0,
    fileWidth,
    fileHeight,
    left * fileWidth,
    right * fileWidth,
    top * fileHeight,
    bottom * fileHeight
  )
end

function Clamp(value, min, max)
  if value > max then
    return max
  elseif value < min then
    return min
  end
  return value
end

-- This section is mostly used by Private.SmoothStatusBarMixin
function Lerp(startValue, endValue, amount)
  return (1 - amount) * startValue + amount * endValue
end

function Saturate(value)
  return Clamp(value, 0, 1)
end

local TARGET_FRAME_PER_SEC = 60.0
function DeltaLerp(startValue, endValue, amount, timeSec)
  return Lerp(startValue, endValue, Saturate(amount * timeSec * TARGET_FRAME_PER_SEC))
end

function FrameDeltaLerp(startValue, endValue, amount, elapsed)
  return DeltaLerp(startValue, endValue, amount, elapsed)
end

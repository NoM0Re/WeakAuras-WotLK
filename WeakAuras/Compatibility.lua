local AddonName = ...
local Private = select(2, ...)

local ipairs = ipairs
local pairs = pairs
local next = next
local select = select
local unpack = unpack
local type = type
local ceil = math.ceil
local floor = math.floor
local tInsert = table.insert

local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

local TARGET_FRAME_PER_SEC = 60.0

local function noop() end

local function SafePack(...)
  local tbl = { ... }
  tbl.n = select("#", ...)
  return tbl
end

local function SafeUnpack(tbl, startIndex)
  return unpack(tbl, startIndex or 1, tbl.n)
end

local function ipairs_reverse(tbl)
  local function Enumerator(tbl, index)
    index = index - 1
    local value = tbl[index]
    if value ~= nil then
      return index, value
    end
  end
  return Enumerator, tbl, #tbl + 1
end

local function Mixin(object, ...)
  for i = 1, select("#", ...) do
    local mixin = select(i, ...)
    for k, v in pairs(mixin) do
      object[k] = v
    end
  end
  return object
end

local function CreateFromMixins(...)
  return Mixin({}, ...)
end

local function MergeTable(destination, source)
  for k, v in pairs(source) do
    destination[k] = v
  end
end

local function tInvert(tbl)
  local inverted = {}
  for k, v in pairs(tbl) do
    inverted[v] = k
  end
  return inverted
end

local function tIndexOf(tbl, item)
  for i, v in ipairs(tbl) do
    if item == v then
      return i
    end
  end
end

local function TableHasAnyEntries(tbl)
  return next(tbl) ~= nil
end

local function tAppendAll(tbl, addedArray)
  for i, element in ipairs(addedArray) do
    tInsert(tbl, element)
  end
end

local function tCompare(lhsTable, rhsTable, depth)
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

  for key in pairs(rhsTable) do
    if lhsTable[key] == nil then
      return false
    end
  end

  return true
end

local function Round(value)
  if value < 0.0 then
    return ceil(value - 0.5)
  end
  return floor(value + 0.5)
end

local function IsInGroup()
  return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

local function IsInRaid()
  return GetNumRaidMembers() > 0
end

local function GetNumSubgroupMembers()
  return GetNumPartyMembers()
end

local function GetNumGroupMembers()
  return IsInRaid() and GetNumRaidMembers() or GetNumPartyMembers()
end

local function WrapTextInColorCode(text, colorHexString)
  return ("|c%s%s|r"):format(colorHexString, text)
end

local function CreateTextureMarkup(file, fileWidth, fileHeight, width, height, left, right, top, bottom, xOffset, yOffset)
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

local function Clamp(value, min, max)
  if value > max then
    return max
  elseif value < min then
    return min
  end
  return value
end

local function Lerp(startValue, endValue, amount)
  return (1 - amount) * startValue + amount * endValue
end

local function Saturate(value)
  return Clamp(value, 0, 1)
end

local function DeltaLerp(startValue, endValue, amount, timeSec)
  return Lerp(startValue, endValue, Saturate(amount * timeSec * TARGET_FRAME_PER_SEC))
end

local function FrameDeltaLerp(startValue, endValue, amount, elapsed)
  return DeltaLerp(startValue, endValue, amount, elapsed)
end

do
  local exports = {
    noop = noop,
    Mixin = Mixin,
    CreateFromMixins = CreateFromMixins,
    ipairs_reverse = ipairs_reverse,
    tInvert = tInvert,
    Round = Round,
    tIndexOf = tIndexOf,
    TableHasAnyEntries = TableHasAnyEntries,
    tAppendAll = tAppendAll,
    MergeTable = MergeTable,
    tCompare = tCompare,
    SafePack = SafePack,
    SafeUnpack = SafeUnpack,
    IsInGroup = IsInGroup,
    IsInRaid = IsInRaid,
    GetNumSubgroupMembers = GetNumSubgroupMembers,
    GetNumGroupMembers = GetNumGroupMembers,
    WrapTextInColorCode = WrapTextInColorCode,
    CreateTextureMarkup = CreateTextureMarkup,
    Clamp = Clamp,
    Lerp = Lerp,
    Saturate = Saturate,
    DeltaLerp = DeltaLerp,
    FrameDeltaLerp = FrameDeltaLerp,
  }

  local _G = _G
  for name, value in pairs(exports) do
    Private[name] = value
    Private.AuraEnvOverrides = Private.AuraEnvOverrides or {}
    Private.AuraEnvOverrides[name] = value
    if not _G[name] then
      _G[name] = value
    end
  end
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

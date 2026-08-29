---@type string
local AddonName = ...
---@class Private
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
local C_FunctionContainers
local C_Timer
local RunNextFrame

-- C_Timer
do
  local containerStates = setmetatable({}, { __mode = "k" })
  local ContainerMethods = {}
  local ContainerMetatable

  local function GetContainerState(container)
    return containerStates[container]
  end

  local function CreateContainerView(state)
    local container = setmetatable({}, ContainerMetatable)
    containerStates[container] = state
    return container
  end

  ContainerMetatable = {
    __index = function(container, key)
      local method = ContainerMethods[key]
      if method then
        return method
      end
      return GetContainerState(container).fields[key]
    end,
    __newindex = function(container, key, value)
      if ContainerMethods[key] then
        error("Attempted to assign to read-only key '" .. key .. "'", 2)
      end
      GetContainerState(container).fields[key] = value
    end,
    __eq = function(left, right)
      return GetContainerState(left) == GetContainerState(right)
    end,
    __metatable = true,
  }

  C_FunctionContainers = {}

  function C_FunctionContainers.CreateCallback(callback)
    if type(callback) ~= "function" then
      error(("Bad argument #1 to 'CreateCallback' (function expected, got %s)"):format(callback ~= nil and type(callback) or "no value"), 2)
    end

    return CreateContainerView({
      callback = callback,
      cancelled = false,
      fields = {},
    })
  end

  function ContainerMethods:Cancel()
    GetContainerState(self).cancelled = true
  end

  function ContainerMethods:IsCancelled()
    return GetContainerState(self).cancelled
  end

  function ContainerMethods:Invoke(...)
    local state = GetContainerState(self)
    if not state.cancelled then
      state.callback(...)
    end
  end

  C_Timer = {}
  local waitTable = {}

  local function ReleaseTicker(ticker)
    ticker.state = nil
    ticker.callbackView = nil
  end

  local function WaitFunc(self, elapsed)
    local total = #waitTable
    local i = 1

    while i <= total do
      local ticker = waitTable[i]

      if ticker.state.cancelled then
        ReleaseTicker(table.remove(waitTable, i))
        total = total - 1
      elseif ticker.delay > elapsed then
        ticker.delay = ticker.delay - elapsed
        i = i + 1
      else
        local ok, err = pcall(ticker.state.callback, ticker.callbackView)
        if not ok then
          geterrorhandler()(err)
        end

        if ticker.state.cancelled then
          ReleaseTicker(table.remove(waitTable, i))
          total = total - 1
        elseif ticker.iterations == -1 then
          ticker.delay = ticker.duration
          i = i + 1
        elseif ticker.iterations > 1 then
          ticker.iterations = ticker.iterations - 1
          ticker.delay = ticker.duration
          i = i + 1
        elseif ticker.iterations == 1 then
          ReleaseTicker(table.remove(waitTable, i))
          total = total - 1
        end
      end
    end

    if #waitTable == 0 then
      self:Hide()
    end
  end

  local waitFrame = CreateFrame("Frame")
  waitFrame:Hide()
  waitFrame:SetScript("OnUpdate", WaitFunc)

  local function AddDelayedCall(ticker)
    table.insert(waitTable, ticker)
    waitFrame:Show()
  end

  local function ValidateArguments(duration, callback, callFunc)
    if type(duration) ~= "number" then
      error(("Bad argument #1 to '%s' (number expected, got %s)"):format(callFunc, duration ~= nil and type(duration) or "no value"), 2)
    elseif type(callback) ~= "function" and not GetContainerState(callback) then
      error(("Bad argument #2 to '%s' (function expected, got %s)"):format(callFunc, callback ~= nil and type(callback) or "no value"), 2)
    end
  end

  local function ValidateIterations(iterations)
    if iterations ~= nil and (type(iterations) ~= "number" or iterations < 1 or iterations ~= floor(iterations)) then
      error(("Bad argument #3 to 'NewTicker' (positive integer expected, got %s)"):format(iterations ~= nil and tostring(iterations) or "no value"), 3)
    end
  end

  function C_Timer.After(duration, callback)
    ValidateArguments(duration, callback, "After")

    local state = GetContainerState(callback) or {
      callback = callback,
      cancelled = false,
      fields = {},
    }
    AddDelayedCall({
      state = state,
      callbackView = CreateContainerView(state),
      iterations = 1,
      delay = math.max(0.01, duration),
    })
  end

  local function CreateTicker(duration, callback, iterations)
    local state = GetContainerState(callback) or {
      callback = callback,
      cancelled = false,
      fields = {},
    }
    local ticker = {
      state = state,
      callbackView = CreateContainerView(state),
      iterations = iterations or -1,
      delay = math.max(0.01, duration),
    }
    ticker.duration = ticker.delay

    AddDelayedCall(ticker)
    return CreateContainerView(state)
  end

  function C_Timer.NewTicker(duration, callback, iterations)
    ValidateArguments(duration, callback, "NewTicker")
    ValidateIterations(iterations)
    return CreateTicker(duration, callback, iterations)
  end

  function C_Timer.NewTimer(duration, callback)
    ValidateArguments(duration, callback, "NewTimer")
    return CreateTicker(duration, callback, 1)
  end

  function C_Timer.CancelTimer(ticker, silent)
    if ticker and ticker.Cancel then
      ticker:Cancel()
    elseif not silent then
      error(AddonName .. ": CancelTimer(timer[, silent]): '" .. tostring(ticker) .. "' - no such timer registered")
    end
    return nil
  end

  function RunNextFrame(callback)
    C_Timer.After(0, callback)
  end
end

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
  local raid = GetNumRaidMembers()
  if raid > 0 then
    return raid
  end
  local party = GetNumPartyMembers()
  return party > 0 and party + 1 or 0
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

---@private
function Private.SetOptionTextDisabled(text, check)
  if check == nil or not check then
    return "|cff808080" .. text .. "|r"
  end
  return text
end

---@private
function Private.AddCompatibilityNote(desc, check, note)
  if check then
    return desc
  end
  desc = desc or ""
  return desc .. (desc ~= "" and "\n\n" or "") .. note
end

local function setDesaturated(self, desaturated, ...)
  self.isDesaturated = desaturated and 1 or 0
  return self._SetDesaturated(self, desaturated, ...)
end

local function setTexture(self, ...)
  local apply = self._SetTexture(self, ...)
  if self.isDesaturated ~= nil then
    self._SetDesaturated(self, self.isDesaturated == 1)
  end
  return apply
end

--- Texture:SetTexture can clear the desaturation state.
--- Keep the last SetDesaturated value on the texture object and
--- re-apply it after every SetTexture call.
--- @param texture Texture
--- @private
function Private.FixTextureDesaturation(texture)
  texture._SetDesaturated = texture.SetDesaturated
  texture._SetTexture = texture.SetTexture
  texture.SetDesaturated = setDesaturated
  texture.SetTexture = setTexture
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
    C_FunctionContainers = C_FunctionContainers,
    C_Timer = C_Timer,
    RunNextFrame = RunNextFrame,
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

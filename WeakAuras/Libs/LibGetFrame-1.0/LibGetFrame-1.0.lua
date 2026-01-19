local MAJOR_VERSION = "LibGetFrame-1.0"
local MINOR_VERSION = 69
if not LibStub then
  error(MAJOR_VERSION .. " requires LibStub.")
end
local lib = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then
  return
end

lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)
local callbacks = lib.callbacks

local GetPlayerInfoByGUID, UnitExists, UnitIsUnit, SecureButton_GetUnit, IsAddOnLoaded  =
  GetPlayerInfoByGUID, UnitExists, UnitIsUnit, SecureButton_GetUnit, IsAddOnLoaded
local tinsert, CopyTable, max, wipe = tinsert, CopyTable, math.max, wipe

-- C_Timer mimik
local C_Timer
do
  local Timer = {}
  C_Timer = Timer

  local timers = {}
  local timerCount = 0

  local frame = CreateFrame("Frame")
  frame:Hide()

  local function OnUpdate(self, elapsed)
    for i = timerCount, 1, -1 do
      local t = timers[i]
      t.remaining = t.remaining - elapsed
      if t.remaining <= 0 then
        timers[i] = timers[timerCount]
        timers[timerCount] = nil
        timerCount = timerCount - 1

        local cb = t.callback
        t.callback = nil
        cb()
      end
    end

    if timerCount == 0 then
      self:Hide()
    end
  end

  function C_Timer.After(delay, callback)
    timerCount = timerCount + 1
    timers[timerCount] = {
      remaining = max(0.01, delay),
      callback  = callback,
    }

    frame:Show()
  end
  frame:SetScript("OnUpdate", OnUpdate)
end

local function Mixin(object, ...)
	for i = 1, select("#", ...) do
		local mixin = select(i, ...);
		for k, v in pairs(mixin) do
			object[k] = v;
		end
	end
	return object;
end

local maxDepth = 50

local defaultFramePriorities = {
  -- raid frames
  "^Vd1", -- vuhdo
  "^Vd2", -- vuhdo
  "^Vd3", -- vuhdo
  "^Vd4", -- vuhdo
  "^Vd5", -- vuhdo
  "^Vd", -- vuhdo
  "^HealBot_HealUnit", -- healbot
  "^hbPet_HealUnit", -- healbot
  "^HealBot", -- healbot
  "^GridLayout", -- grid
  "^Grid2Layout", -- grid2
  "^NugRaid%d+UnitButton%d+", -- Aptechka
  "^PlexusLayout", -- plexus
  "^ElvUF_Raid%d*Group", -- elv
  "^ElvUF_RaidGroup", -- elv
  "^oUF_bdGrid", -- bdgrid
  "^oUF_.-Raid", -- generic oUF
  "^LimeGroup", -- lime
  "^InvenRaidFrames3Group%dUnitButton", -- InvenRaidFrames3
  "^SUFHeaderraid", -- suf
  "^LUFHeaderraid", -- luf
  "^AshToAshUnit%d+Unit%d+", -- AshToAsh
  "^Cell", -- Cell
  "^XPerl_Raid_Grp", -- xperl
  -- party frames
  "^AleaUI_GroupHeader", -- Alea
  "^SUFHeaderparty", --suf
  "^LUFHeaderparty", --luf
  "^ElvUF_PartyGroup", -- elv
  "^oUF_.-Party", -- generic oUF
  "^PitBull4_Groups_Party", -- pitbull4
  "^XPerl_party%d", -- xperl
  "^CompactRaid", -- blizz
  "^CompactParty", -- blizz
  "^PartyFrame", -- blizz
  "^PartyMemberFrame", -- blizz
    -- boss frames
  "^ElvUF_Boss%d$", -- elv
  "^SUFHeaderbossUnitButton%d$", -- suf
  "^LUFHeaderbossUnitButton%d$", -- luf
  "^Boss%dTargetFrame$", -- blizz
  "^UUF_Boss%d$", -- unhalted
  -- player frame
  "^InvenUnitFrames_Player$",
  "^SUFUnitplayer$",
  "^LUFUnitplayer$",
  "^PitBull4_Frames_Player$",
  "^ElvUF_Player$",
  "^oUF_.-Player$",
  "^XPerl_Player$",
  "^UUF_Player$",
  "^PlayerFrame$",
}
local getDefaultFramePriorities = function()
  return CopyTable(defaultFramePriorities)
end
lib.getDefaultFramePriorities = getDefaultFramePriorities

local defaultPlayerFrames = {
  "^InvenUnitFrames_Player$",
  "^SUFUnitplayer$",
  "^LUFUnitplayer$",
  "^PitBull4_Frames_Player$",
  "^ElvUF_Player$",
  "^oUF_.-Player$",
  "^oUF_PlayerPlate$",
  "^XPerl_Player$",
  "^UUF_Player$",
  "^PlayerFrame$",
}
local getDefaultPlayerFrames = function()
  return CopyTable(defaultPlayerFrames)
end
lib.getDefaultPlayerFrames = getDefaultPlayerFrames
local defaultTargetFrames = {
  "^InvenUnitFrames_Target$",
  "^SUFUnittarget$",
  "^LUFUnittarget$",
  "^PitBull4_Frames_Target$",
  "^ElvUF_Target$",
  "^oUF_.-Target$",
  "^TargetFrame$",
  "^hbExtra_HealUnit$",
  "^UUF_Target$",
  "^XPerl_Target$"
}
local getDefaultTargetFrames = function()
  return CopyTable(defaultTargetFrames)
end
lib.getDefaultTargetFrames = getDefaultTargetFrames
local defaultTargettargetFrames = {
  "^InvenUnitFrames_TargetTarget$",
  "^SUFUnittargettarget$",
  "^LUFUnittargettarget$",
  "^PitBull4_Frames_Target's target$",
  "^ElvUF_TargetTarget$",
  "^oUF_.-TargetTarget$",
  "^oUF_ToT$",
  "^UUF_TargetTarget$",
  "^TargetTargetFrame$",
  "^XPerl_TargetTarget$",
  "^TargetFrameToT$"
}
local getDefaultTargettargetFrames = function()
  return CopyTable(defaultTargettargetFrames)
end
lib.getDefaultTargettargetFrames = getDefaultTargettargetFrames
local defaultPartyFrames = {
  "^InvenUnitFrames_Party%d",
  "^AleaUI_GroupHeader",
  "^SUFHeaderparty",
  "^LUFHeaderparty",
  "^ElvUF_PartyGroup",
  "^oUF_.-Party",
  "^PitBull4_Groups_Party",
  "^XPerl_party%d",
  "^PartyFrame",
  "^CompactParty",
  "^PartyMemberFrame",
}
local getDefaultPartyFrames = function()
  return CopyTable(defaultPartyFrames)
end
lib.getDefaultPartyFrames = getDefaultPartyFrames
local defaultPartyTargetFrames = {
  "SUFChildpartytarget%d",
  "XPerl_party%dtargetFrame"
}
local getDefaultPartyTargetFrames = function()
  return CopyTable(defaultPartyTargetFrames)
end
lib.getDefaultPartyTargetFrames = getDefaultPartyTargetFrames
local defaultFocusFrames = {
  "^InvenUnitFrames_Focus$",
  "^ElvUF_FocusTarget$",
  "^SUFUnitfocus$",
  "^LUFUnitfocus$",
  "^FocusFrame$",
  "^hbExtra_HealUnit$",
  "^UUF_Focus$",
  "^XPerl_Focus$"
}
local getDefaultFocusFrames = function()
  return CopyTable(defaultFocusFrames)
end
lib.getDefaultFocusFrames = getDefaultFocusFrames
local defaultRaidFrames = {
  "^Vd",
  "^HealBot_HealUnit",
  "^hbPet_HealUnit",
  "^HealBot",
  "^GridLayout",
  "^Grid2Layout",
  "^PlexusLayout",
  "^InvenRaidFrames3Group%dUnitButton",
  "^ElvUF_Raid%d*Group",
  "^ElvUF_RaidGroup",
  "^oUF_.-Raid",
  "^AshToAsh",
  "^Cell",
  "^LimeGroup",
  "^SUFHeaderraid",
  "^LUFHeaderraid",
  "^XPerl_Raid_Grp",
  "^CompactRaid",
  "^RaidPullout",
}
local getDefaultRaidFrames = function()
  return CopyTable(defaultRaidFrames)
end
lib.getDefaultRaidFrames = getDefaultRaidFrames
local defaultBossFrames = {
  "^ElvUF_Boss%d$",
  "^SUFHeaderbossUnitButton%d$",
  "^LUFHeaderbossUnitButton%d$",
  "^UUF_Boss%d$",
  "^Boss%dTargetFrame$",
}
local getDefaultBossFrames = function()
  return CopyTable(defaultBossFrames)
end
lib.getDefaultBossFrames = getDefaultBossFrames

local copyTableCache = {}

local function CopyTableCached(src)
  wipe(copyTableCache)
  for i = 1, #src do
    copyTableCache[i] = src[i]
  end
  return copyTableCache
end

--
local CacheMonitorMixin = {}
function CacheMonitorMixin:Init(makeDiff)
  self.data = {}
  self.cache = {}
  if makeDiff then
    self.makeDiff = makeDiff
    self.added = {}
    self.updated = {}
    self.removed = {}
  end
end
-- fill cache, added, updated
function CacheMonitorMixin:Add(key, value)
  if self.makeDiff then
    local old = self.data[key]
    if old ~= value then
      if old == nil then
        self.added[key] = true
      else
        self.updated[key] = old
      end
    end
  end
  self.cache[key] = value
end
function CacheMonitorMixin:CalcRemoved()
  if not self.makeDiff then return end
  for key, value in pairs(self.data) do
    if self.cache[key] == nil then
      self.removed[key] = value
    end
  end
end
function CacheMonitorMixin:WriteCache()
  wipe(self.data)
  self.data, self.cache = self.cache, {}
end
function CacheMonitorMixin:Reset()
  if self.makeDiff then
    wipe(self.updated)
    wipe(self.removed)
    wipe(self.added)
  end
end

local FrameToFrameName = {}   -- frame adress => frame name
local FrameToUnit = {}        -- frame adress => unitToken
Mixin(FrameToFrameName, CacheMonitorMixin)
Mixin(FrameToUnit, CacheMonitorMixin)
FrameToFrameName:Init()
FrameToUnit:Init(true)

local profiling = false
local profileData

local function doNothing()
end

local StartProfiling = doNothing
local StopProfiling = doNothing

local function _StartProfiling(id)
  if not profileData[id] then
    profileData[id] = {}
    profileData[id].count = 1
    profileData[id].start = debugprofilestop()
    profileData[id].elapsed = 0
    profileData[id].spike = 0
    return
  end

  if profileData[id].count == 0 then
    profileData[id].count = 1
    profileData[id].start = debugprofilestop()
  else
    profileData[id].count = profileData[id].count + 1
  end
end

local function _StopProfiling(id)
  profileData[id].count = profileData[id].count - 1
  if profileData[id].count == 0 then
    local elapsed = debugprofilestop() - profileData[id].start
    profileData[id].elapsed = profileData[id].elapsed + elapsed
    if elapsed > profileData[id].spike then
      profileData[id].spike = elapsed
    end
  end
end

function lib.StartProfile()
  if profiling then
    print(MAJOR_VERSION, " (StartProfile) Profiling already started")
    return false
  end
  profiling = true
  profileData = {}
  StartProfiling = _StartProfiling
  StopProfiling = _StopProfiling
end

function lib.StopProfile()
  if not profiling then
    print(MAJOR_VERSION, " (StopProfile) Profiling not running")
    return false
  end
  profiling = false
  StartProfiling = doNothing
  StopProfiling = doNothing
end

function lib.GetProfileData()
  return profileData or {}
end

-- if frame doesn't have a name, try to use the key from it's parent
local function recurseGetName(frame)
  local name = frame.GetName and frame:GetName() or nil
  if name then
    return name
  end
  local parent = frame.GetParent and frame:GetParent()
  if parent then
    local parentKey = frame.GetParentKey and frame:GetParentKey()
    if not parentKey then
      for key, child in pairs(parent) do
        if child == frame then
          parentKey = key
          break
        end
      end
    end
    if parentKey then
      return (recurseGetName(parent) or "") .. "." .. parentKey
    end
  end
end

--local notAUnitFrameTypeAttribute = {
--  cancelaura = true
--}

local frameNameCache = setmetatable({}, { __mode = "k" })

local function ScanFrames(depth, frame, ...)
  coroutine.yield()
  if not frame then
    return
  end
  if depth < maxDepth then
    local frameType = frame:GetObjectType()
    if frameType == "Frame" or frameType == "Button" then
      ScanFrames(depth + 1, frame:GetChildren())
    end
    if frameType == "Button" then
      --local typeAttribute = frame:GetAttribute("type")
      --if not notAUnitFrameTypeAttribute[typeAttribute] then
        local unit = SecureButton_GetUnit(frame)
        if unit and frame:IsVisible() then
          local name = frameNameCache[frame]
          if not name then
            name = recurseGetName(frame)
            frameNameCache[frame] = name
          end
          if name then
            FrameToFrameName:Add(frame, name)
            FrameToUnit:Add(frame, unit)
          end
        end
      --end
    end
  end
  ScanFrames(depth, ...)
end

local status = "ready"
local co
local coroutineFrame = CreateFrame("Frame")
coroutineFrame:Hide()

local function doScanForUnitFrames()
  if not coroutineFrame:IsShown() then
    status = "scanning"
    co = coroutine.create(ScanFrames)
    coroutineFrame:Show()
  end
end

coroutineFrame:SetScript("OnUpdate", function()
  local start = debugprofilestop()
  -- Limit to 5ms per frame
  StartProfiling("scan frames")
  while debugprofilestop() - start < 5 and coroutine.status(co) ~= "dead" do
    coroutine.resume(co, 0, UIParent)
  end
  StopProfiling("scan frames")
  if coroutine.status(co) == "dead" then
    StartProfiling("callbacks")
    FrameToFrameName:WriteCache()
    FrameToUnit:CalcRemoved()
    FrameToUnit:WriteCache()
    StartProfiling("callback GETFRAME_REFRESH")
    callbacks:Fire("GETFRAME_REFRESH")
    StopProfiling("callback GETFRAME_REFRESH")
    -- FrameToUnit
    if next(FrameToUnit.added) then
      StartProfiling("callback FRAME_UNIT_ADDED")
      for frame in pairs(FrameToUnit.added) do
        callbacks:Fire("FRAME_UNIT_ADDED", frame, FrameToUnit.data[frame])
      end
      StopProfiling("callback FRAME_UNIT_ADDED")
    end
    if next(FrameToUnit.updated) then
      StartProfiling("callback FRAME_UNIT_UPDATE")
      for frame, previousUnit in pairs(FrameToUnit.updated) do
        callbacks:Fire("FRAME_UNIT_UPDATE", frame, FrameToUnit.data[frame], previousUnit)
      end
      StopProfiling("callback FRAME_UNIT_UPDATE")
    end
    if next(FrameToUnit.removed) then
      StartProfiling("callback FRAME_UNIT_REMOVED")
      for frame, unit in pairs(FrameToUnit.removed) do
        callbacks:Fire("FRAME_UNIT_REMOVED", frame, unit)
      end
      StopProfiling("callback FRAME_UNIT_REMOVED")
    end
    coroutineFrame:Hide()
    FrameToFrameName:Reset()
    FrameToUnit:Reset()
    StopProfiling("callbacks")
    if status == "scan_queued" then
      doScanForUnitFrames("queued")
    else
      status = "ready"
    end
    wipe(frameNameCache)
  end
end)

local function ScanForUnitFrames(noDelay)
  if status == "ready" then
    if noDelay then
      doScanForUnitFrames()
    else
      status = "scan_delay"
      C_Timer.After(1, function()
        doScanForUnitFrames()
      end)
    end
  elseif status == "scanning" then
    status = "scan_queued"
  end
end

function lib.ScanForUnitFrames()
  ScanForUnitFrames(true)
end

local function isFrameFiltered(name, ignoredFrames)
  for _, filter in pairs(ignoredFrames) do
    if name:find(filter) then
      return true
    end
  end
  return false
end

local function GetUnitFrames(target, ignoredFrames)
  if not UnitExists(target) then
    if type(target) ~= "string" then
      return
    end
    if target:match("^0x") then
      target = select(6, GetPlayerInfoByGUID(target))
    end
    if not UnitExists(target) then
      return
    end
  end

  local frames
  for frame, frameName in pairs(FrameToFrameName.data) do
    local unit = SecureButton_GetUnit(frame)
    if unit and UnitIsUnit(unit, target) and not isFrameFiltered(frameName, ignoredFrames) then
      frames = frames or {}
      frames[frame] = frameName
    end
  end
  return frames
end

local function ElvuiWorkaround(frame)
  if IsAddOnLoaded("ElvUI") and frame and frame:GetName() and frame:GetName():find("^ElvUF_") and frame.Health then
    return frame.Health
  else
    return frame
  end
end

local function CellGetUnitFrames(target, frames, framePriorities)
  if not IsAddOnLoaded("Cell") or not Cell.GetUnitFramesForLGF then
    return frames
  end
  return Cell.GetUnitFramesForLGF(target, frames, framePriorities)
end

local defaultOptions = {
  framePriorities = defaultFramePriorities,
  ignorePlayerFrame = true,
  ignoreTargetFrame = true,
  ignoreTargettargetFrame = true,
  ignorePartyFrame = false,
  ignorePartyTargetFrame = true,
  ignoreFocusFrame = true,
  ignoreRaidFrame = false,
  ignoreBossFrame = false,
  playerFrames = defaultPlayerFrames,
  targetFrames = defaultTargetFrames,
  targettargetFrames = defaultTargettargetFrames,
  partyFrames = defaultPartyFrames,
  partyTargetFrames = defaultPartyTargetFrames,
  focusFrames = defaultFocusFrames,
  raidFrames = defaultRaidFrames,
  bossFrames = defaultBossFrames,
  ignoreFrames = {
    "PitBull4_Frames_Target's target's target",
    "ElvUF_PartyGroup%dUnitButton%dTarget",
    "RavenButton",
    "RavenOverlay",
    "AshToAshUnit%d+ShadowGroupHeaderUnitButton%d+",
    "InvenUnitFrames_TargetTargetTarget",
    "CellQuickCastButton",
  },
  skipCellOverrides = false,
  returnAll = false,
}
local getDefaultOptions = function()
  return CopyTable(defaultOptions)
end
lib.getDefaultOptions = getDefaultOptions

local IterateGroupMembers = function(reversed, forceParty)
  local unit = (not forceParty and GetNumRaidMembers() > 0) and 'raid' or 'party'
  local numGroupMembers = unit == 'party' and GetNumPartyMembers() or GetNumRaidMembers()
  local i = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == 'party' then
      ret = 'player'
    elseif i <= numGroupMembers and i > 0 then
      ret = unit .. i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

local unitPetState = {} -- track if unit's pet exists

local saveGetUnitFrame
local function fixGetUnitFrameIntegrity()
  lib.GetUnitFrame = saveGetUnitFrame
  lib.GetFrame = saveGetUnitFrame
  if WeakAuras and WeakAuras.GetUnitFrame then
    WeakAuras.GetUnitFrame = saveGetUnitFrame
  end
end

local GetFramesCacheListener
local function Init(noDelay)
  GetFramesCacheListener = CreateFrame("Frame")
  GetFramesCacheListener:RegisterEvent("PLAYER_REGEN_DISABLED")
  GetFramesCacheListener:RegisterEvent("PLAYER_REGEN_ENABLED")
  GetFramesCacheListener:RegisterEvent("PLAYER_ENTERING_WORLD")
  GetFramesCacheListener:RegisterEvent("RAID_ROSTER_UPDATE")
  GetFramesCacheListener:RegisterEvent("PARTY_MEMBERS_CHANGED")
  GetFramesCacheListener:RegisterEvent("UNIT_PET")
  GetFramesCacheListener:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
  GetFramesCacheListener:SetScript("OnEvent", function(self, event, unit, ...)
    fixGetUnitFrameIntegrity()
    if event == "RAID_ROSTER_UPDATE" or event == "PARTY_MEMBERS_CHANGED" then
      wipe(unitPetState)
      for member in IterateGroupMembers() do
        unitPetState[member] = UnitExists(member .. "pet") and true or nil
      end
    end
    if event == "UNIT_PET" then
      if not (UnitIsUnit("player", unit) or UnitInParty(unit) or UnitInRaid(unit)) then
        return
      end
      -- skip if unit's pet existance has not changed
      local exists = UnitExists(unit .. "pet") and true or nil
      if unitPetState[unit] == exists then
        return
      else
        unitPetState[unit] = exists
      end
    end
    ScanForUnitFrames(false)
  end)
  ScanForUnitFrames(noDelay)
end

function lib.GetUnitFrame(target, opt)
  if type(GetFramesCacheListener) ~= "table" then
    Init(true)
  end
  local defaultOpt
  if not opt then
    opt = {}
    defaultOpt = true
  end
  setmetatable(opt, { __index = defaultOptions })

  if not target then
    return
  end

  local ignoredFrames = CopyTableCached(opt.ignoreFrames)
  if opt.ignorePlayerFrame then
    for _, v in pairs(opt.playerFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignoreTargetFrame and not (defaultOpt and target == "target") then
    for _, v in pairs(opt.targetFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignoreTargettargetFrame and not (defaultOpt and target == "targettarget") then
    for _, v in pairs(opt.targettargetFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignorePartyFrame then
    for _, v in pairs(opt.partyFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignorePartyTargetFrame then
    for _, v in pairs(opt.partyTargetFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignoreFocusFrame and not (defaultOpt and target == "focus") then
    for _, v in pairs(opt.focusFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignoreRaidFrame then
    for _, v in pairs(opt.raidFrames) do
      tinsert(ignoredFrames, v)
    end
  end
  if opt.ignoreBossFrame then
    for _, v in pairs(opt.bossFrames) do
      tinsert(ignoredFrames, v)
    end
  end

  local frames = GetUnitFrames(target, ignoredFrames)

  if not (opt.ignoreRaidFrame or opt.skipCellOverrides) then
    frames = CellGetUnitFrames(target, frames, opt.framePriorities)
  end

  if not frames then
    return
  end

  if not opt.returnAll then
    for i = 1, #opt.framePriorities do
      for frame, frameName in pairs(frames) do
        if frameName:find(opt.framePriorities[i]) then
          return ElvuiWorkaround(frame)
        end
      end
    end
    local next = next
    return ElvuiWorkaround(next(frames))
  else
    for frame in pairs(frames) do
      frames[frame] = ElvuiWorkaround(frame)
    end
    return frames
  end
end
saveGetUnitFrame = lib.GetUnitFrame
lib.GetFrame = lib.GetUnitFrame -- compatibility

-- nameplates
function lib.GetUnitNameplate(unit)
  if not unit then
    return
  end
  local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
  if nameplate then
    -- credit to Exality for https://wago.io/explosiveorbs
    if nameplate.UnitFrame and nameplate.UnitFrame.Health then
      -- ElvUI Bunny
      return nameplate.UnitFrame.Health:IsShown() and nameplate.UnitFrame.Health
          or nameplate.UnitFrame.Name:IsShown() and nameplate.UnitFrame.Name
          or nameplate

    elseif nameplate.unitFrame and nameplate.unitFrame.Health then
      -- ElvUI Crum
      return nameplate.unitFrame.Health:IsShown() and nameplate.unitFrame.Health
          or nameplate.unitFrame.Name and nameplate.unitFrame.Name:IsShown() and nameplate.unitFrame.Name
          or nameplate

    elseif nameplate.unitFramePlater and nameplate.unitFramePlater.healthBar then
      -- Plater
      -- fallback to default nameplate in case plater is not on screen and uses blizzard default (module disabled, force-blizzard functionality)
      return nameplate.unitFramePlater.PlaterOnScreen
          and nameplate.unitFramePlater.healthBar
          and nameplate.unitFramePlater.healthBar:IsShown() and nameplate.unitFramePlater.healthBar
          or (nameplate.UnitFrame and nameplate.UnitFrame.healthBar and nameplate.UnitFrame.healthBar:IsShown() and nameplate.UnitFrame.healthBar)
          or nameplate

    elseif nameplate.kui and nameplate.kui.HealthBar then
      -- KuiNameplates
      return nameplate.kui.HealthBar:IsShown() and nameplate.kui.HealthBar
          or nameplate

    elseif nameplate.extended and nameplate.extended.visual and nameplate.extended.visual.healthbar then
      -- TidyPlates
      return nameplate.extended.visual.healthbar:IsShown() and nameplate.extended.visual.healthbar
          or nameplate

    elseif nameplate.TPFrame and nameplate.TPFrame.visual and nameplate.TPFrame.visual.healthbar then
      -- Threat Plates
      return nameplate.TPFrame.visual.healthbar:IsShown() and nameplate.TPFrame.visual.healthbar
          or nameplate

    elseif nameplate.ouf and nameplate.ouf.Health then
      -- bdNameplates
      return nameplate.ouf.Health:IsShown() and nameplate.ouf.Health
          or nameplate

    elseif nameplate.slab
        and nameplate.slab.components
        and nameplate.slab.components.healthBar
        and nameplate.slab.components.healthBar.frame then
      -- Slab
      return nameplate.slab.components.healthBar.frame:IsShown() and nameplate.slab.components.healthBar.frame
          or nameplate

    elseif nameplate.UnitFrame and nameplate.UnitFrame.healthBar then
      -- default
      return nameplate.UnitFrame.healthBar:IsShown() and nameplate.UnitFrame.healthBar
          or nameplate

    else
      return nameplate
    end
  end
end

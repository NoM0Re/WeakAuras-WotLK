if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)

-- Lua APIs
local tinsert, tsort = table.insert, table.sort
local tostring = tostring
local select, pairs, type = select, pairs, type
local ceil = ceil

-- WoW APIs
local GetTalentInfo = GetTalentInfo
local UnitClass = UnitClass
local GetSpellInfo, GetItemInfo, GetItemCount, GetItemIcon = GetSpellInfo, GetItemInfo, GetItemCount, GetItemIcon
local GetShapeshiftFormInfo, GetShapeshiftForm = GetShapeshiftFormInfo, GetShapeshiftForm
local GetRuneCooldown, UnitCastingInfo, UnitChannelInfo = GetRuneCooldown, UnitCastingInfo, UnitChannelInfo
local UnitDetailedThreatSituation = UnitDetailedThreatSituation
local MAX_NUM_TALENTS = MAX_NUM_TALENTS or 40

local WeakAuras = WeakAuras
local L = WeakAuras.L

local SpellRange = LibStub("SpellRange-1.0")
function WeakAuras.IsSpellInRange(spellId, unit)
  return SpellRange.IsSpellInRange(spellId, unit)
end

local LibRangeCheck = LibStub("LibRangeCheck-2.0")

function WeakAuras.GetRange(unit, checkVisible)
  return LibRangeCheck:GetRange(unit, checkVisible);
end

function WeakAuras.CheckRange(unit, range, operator)
  local min, max = LibRangeCheck:GetRange(unit, true);
  if (type(range) ~= "number") then
    range = tonumber(range);
  end
  if (not range) then
    return
  end
  if (operator == "<=") then
    return (max or 999) <= range;
  else
    return (min or 0) >= range;
  end
end

local RangeCacheStrings = {friend = "", harm = "", misc = ""}
local function RangeCacheUpdate()
  local friend, harm, misc = {}, {}, {}
  local friendString, harmString, miscString

  for range in LibRangeCheck:GetFriendCheckers() do
    tinsert(friend, range)
  end
  tsort(friend)
  for range in LibRangeCheck:GetHarmCheckers() do
    tinsert(harm, range)
  end
  tsort(harm)
  for range in LibRangeCheck:GetMiscCheckers() do
    tinsert(misc, range)
  end
  tsort(misc)

  for _, key in pairs(friend) do
    friendString = (friendString and (friendString .. ", ") or "") .. key
  end
  for _, key in pairs(harm) do
    harmString = (harmString and (harmString .. ", ") or "") .. key
  end
  for _, key in pairs(misc) do
      miscString = (miscString and (miscString .. ", ") or "") .. key
  end
  RangeCacheStrings.friend, RangeCacheStrings.harm, RangeCacheStrings.misc = friendString, harmString, miscString
end

LibRangeCheck:RegisterCallback(LibRangeCheck.CHECKERS_CHANGED, RangeCacheUpdate)

function WeakAuras.UnitDetailedThreatSituation(unit1, unit2)
  local ok, aggro, status, threatpct, rawthreatpct, threatvalue = pcall(UnitDetailedThreatSituation, unit1, unit2)
  if ok then
    return aggro, status, threatpct, rawthreatpct, threatvalue
  end
end

local constants = {
  nameRealmFilterDesc = L[" Filter formats: 'Name', 'Name-Realm', '-Realm'. \n\nSupports multiple entries, separated by commas\nCan use \\ to escape -."],
  instanceFilterDeprecated = L["This filter has been moved to the Location trigger. Change your aura to use the new Location trigger or join the WeakAuras Discord server for help."],
  guildFilterDesc = L["Supports multiple entries, separated by commas. Escape with \\. Prefix with '-' for negation."]
}

WeakAuras.UnitRaidRole = function(unit)
  local raidID = UnitInRaid(unit)
  if raidID then
    return select(10, GetRaidRosterInfo(raidID + 1)) or "NONE"
  end
end

function WeakAuras.SpellSchool(school)
  return Private.combatlog_spell_school_types[school] or ""
end

function WeakAuras.RaidFlagToIndex(flag)
  return Private.combatlog_raidFlags[flag] or 0
end

Private.function_strings = {
  count = [[
    return function(count)
      if(count %s %s) then
        return true
      else
        return false
      end
    end
  ]],
  count_fraction = [[
    return function(count, max)
      if max == 0 then
        return false
      end
      local fraction = count/max
      if(fraction %s %s) then
        return true
      else
        return false
      end
    end
  ]],
  always = [[
    return function()
      return true
    end
  ]]
};

local hsvFrame = CreateFrame("ColorSelect")

-- HSV transition, for a much prettier color transition in many cases
-- see http://www.wowinterface.com/forums/showthread.php?t=48236
function WeakAuras.GetHSVTransition(perc, r1, g1, b1, a1, r2, g2, b2, a2)
  --get hsv color for colorA
  hsvFrame:SetColorRGB(r1, g1, b1)
  local h1, s1, v1 = hsvFrame:GetColorHSV() -- hue, saturation, value
  --get hsv color for colorB
  hsvFrame:SetColorRGB(r2, g2, b2)
  local h2, s2, v2 = hsvFrame:GetColorHSV() -- hue, saturation, value
  local h3 = floor(h1 - (h1 - h2) * perc)
  -- find the shortest arc through the color circle, then interpolate
  local diff = h2 - h1
  if diff < -180 then
    diff = diff + 360
  elseif diff > 180 then
    diff = diff - 360
  end

  h3 = (h1 + perc * diff) % 360
  local s3 = s1 - ( s1 - s2 ) * perc
  local v3 = v1 - ( v1 - v2 ) * perc
  --get the RGB values of the new color
  hsvFrame:SetColorHSV(h3, s3, v3)
  local r, g, b = hsvFrame:GetColorRGB()
  --interpolate alpha
  local a = a1 - ( a1 - a2 ) * perc
  --return the new color
  return r, g, b, a
end


Private.anim_function_strings = {
straight = [[
function(progress, start, delta)
    return start + (progress * delta)
end
]],

straightTranslate = [[
function(progress, startX, startY, deltaX, deltaY)
    return startX + (progress * deltaX), startY + (progress * deltaY)
end
]],

straightScale = [[
function(progress, startX, startY, scaleX, scaleY)
    return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))
end
]],

straightColor = [[
function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
    return r1 + (progress * (r2 - r1)), g1 + (progress * (g2 - g1)), b1 + (progress * (b2 - b1)), a1 + (progress * (a2 - a1))
end
]],

straightHSV = [[
function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
    return WeakAuras.GetHSVTransition(progress, r1, g1, b1, a1, r2, g2, b2, a2)
end
]],

circle = [[
function(progress, startX, startY, deltaX, deltaY)
    local angle = progress * 2 * math.pi
    return startX + (deltaX * math.cos(angle)), startY + (deltaY * math.sin(angle))
end
]],

circle2 = [[
function(progress, startX, startY, deltaX, deltaY)
    local angle = progress * 2 * math.pi
    return startX + (deltaX * math.sin(angle)), startY + (deltaY * math.cos(angle))
end
]],

spiral = [[
function(progress, startX, startY, deltaX, deltaY)
    local angle = progress * 2 * math.pi
    return startX + (progress * deltaX * math.cos(angle)), startY + (progress * deltaY * math.sin(angle))
end
]],

spiralandpulse = [[
function(progress, startX, startY, deltaX, deltaY)
    local angle = (progress + 0.25) * 2 * math.pi
    return startX + (math.cos(angle) * deltaX * math.cos(angle*2)), startY + (math.abs(math.cos(angle)) * deltaY * math.sin(angle*2))
end
]],

shake = [[
function(progress, startX, startY, deltaX, deltaY)
    local prog
    if(progress < 0.25) then
        prog = progress * 4
    elseif(progress < .75) then
        prog = 2 - (progress * 4)
    else
        prog = (progress - 1) * 4
    end
    return startX + (prog * deltaX), startY + (prog * deltaY)
end
]],

starShakeDecay = [[
function(progress, startX, startY, deltaX, deltaY)
    local spokes = 10
    local fullCircles = 4

    local r = min(abs(deltaX), abs(deltaY))
    local xScale = deltaX / r
    local yScale = deltaY / r

    local deltaAngle = fullCircles *2 / spokes * math.pi
    local p = progress * spokes
    local i1 = floor(p)
    p = p - i1

    local angle1 = i1 * deltaAngle
    local angle2 = angle1 + deltaAngle

    local x1 = r * math.cos(angle1)
    local y1 = r * math.sin(angle1)

    local x2 = r * math.cos(angle2)
    local y2 = r * math.sin(angle2)

    local x, y = p * x2 + (1-p) * x1, p * y2 + (1-p) * y1
    local ease = math.sin(progress * math.pi / 2)
    return ease * x * xScale, ease * y * yScale
end
]],

bounceDecay = [[
function(progress, startX, startY, deltaX, deltaY)
    local prog = (progress * 3.5) % 1
    local bounce = math.ceil(progress * 3.5)
    local bounceDistance = math.sin(prog * math.pi) * (bounce / 4)
    return startX + (bounceDistance * deltaX), startY + (bounceDistance * deltaY)
end
]],

bounce = [[
function(progress, startX, startY, deltaX, deltaY)
    local bounceDistance = math.sin(progress * math.pi)
    return startX + (bounceDistance * deltaX), startY + (bounceDistance * deltaY)
end
]],

flash = [[
function(progress, start, delta)
    local prog
    if(progress < 0.5) then
        prog = progress * 2
    else
        prog = (progress - 1) * 2
    end
    return start + (prog * delta)
end
]],

pulse = [[
function(progress, startX, startY, scaleX, scaleY)
    local angle = (progress * 2 * math.pi) - (math.pi / 2)
    return startX + (((math.sin(angle) + 1)/2) * (scaleX - 1)), startY + (((math.sin(angle) + 1)/2) * (scaleY - 1))
end
]],

alphaPulse = [[
function(progress, start, delta)
    local angle = (progress * 2 * math.pi) - (math.pi / 2)
    return start + (((math.sin(angle) + 1)/2) * delta)
end
]],

pulseColor = [[
function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
    local angle = (progress * 2 * math.pi) - (math.pi / 2)
    local newProgress = ((math.sin(angle) + 1)/2);
    return r1 + (newProgress * (r2 - r1)),
         g1 + (newProgress * (g2 - g1)),
         b1 + (newProgress * (b2 - b1)),
         a1 + (newProgress * (a2 - a1))
end
]],

pulseHSV = [[
function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
    local angle = (progress * 2 * math.pi) - (math.pi / 2)
    local newProgress = ((math.sin(angle) + 1)/2);
    return WeakAuras.GetHSVTransition(newProgress, r1, g1, b1, a1, r2, g2, b2, a2)
end
]],

fauxspin = [[
function(progress, startX, startY, scaleX, scaleY)
    local angle = progress * 2 * math.pi
    return math.cos(angle) * scaleX, startY + (progress * (scaleY - startY))
end
]],

fauxflip = [[
function(progress, startX, startY, scaleX, scaleY)
    local angle = progress * 2 * math.pi
    return startX + (progress * (scaleX - startX)), math.cos(angle) * scaleY
end
]],

backandforth = [[
function(progress, start, delta)
    local prog
    if(progress < 0.25) then
        prog = progress * 4
    elseif(progress < .75) then
        prog = 2 - (progress * 4)
    else
        prog = (progress - 1) * 4
    end
    return start + (prog * delta)
end
]],

wobble = [[
function(progress, start, delta)
    local angle = progress * 2 * math.pi
    return start + math.sin(angle) * delta
end
]],

hide = [[
function()
    return 0
end
]]
};

Private.anim_presets = {
  -- Start and Finish
  slidetop = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 0, y = 50,
    use_alpha = true,
    alpha = 0
  },
  slideleft = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = -50,
    y = 0,
    use_alpha = true,
    alpha = 0
  },
  slideright = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 50,
    y = 0,
    use_alpha = true,
    alpha = 0
  },
  slidebottom = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 0,
    y = -50,
    use_alpha = true,
    alpha = 0
  },
  fade = {
    type = "custom",
    duration = 0.25,
    use_alpha = true,
    alpha = 0
  },
  grow = {
    type = "custom",
    duration = 0.25,
    use_scale = true,
    scalex = 2,
    scaley = 2,
    use_alpha = true,
    alpha = 0
  },
  shrink = {
    type = "custom",
    duration = 0.25,
    use_scale = true,
    scalex = 0,
    scaley = 0,
    use_alpha = true,
    alpha = 0
  },
  spiral = {
    type = "custom",
    duration = 0.5,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "spiral",
    use_alpha = true,
    alpha = 0
  },
  bounceDecay = {
    type = "custom",
    duration = 1.5,
    use_translate = true,
    x = 50,
    y = 50,
    translateType = "bounceDecay",
    use_alpha = true,
    alpha = 0
  },
  starShakeDecay = {
    type = "custom",
    duration = 1,
    use_translate = true,
    x = 50,
    y = 50,
    translateType = "starShakeDecay",
    use_alpha = true,
    alpha = 0
  },
  -- Main
  shake = {
    type = "custom",
    duration = 0.5,
    use_translate = true,
    x = 10,
    y = 0,
    translateType = "circle2"
  },
  spin = {
    type = "custom",
    duration = 1,
    use_scale = true,
    scalex = 1,
    scaley = 1,
    scaleType = "fauxspin"
  },
  flip = {
    type = "custom",
    duration = 1,
    use_scale = true,
    scalex = 1,
    scaley = 1,
    scaleType = "fauxflip"
  },
  wobble = {
    type = "custom",
    duration = 0.5,
    use_rotate = true,
    rotate = 3,
    rotateType = "wobble"
  },
  pulse = {
    type = "custom",
    duration = 0.75,
    use_scale = true,
    scalex = 1.05,
    scaley = 1.05,
    scaleType = "pulse"
  },
  alphaPulse = {
    type = "custom",
    duration = 0.5,
    use_alpha = true,
    alpha = 0.5,
    alphaType = "alphaPulse"
  },
  rotateClockwise = {
    type = "custom",
    duration = 4,
    use_rotate = true,
    rotate = -360
  },
  rotateCounterClockwise = {
    type = "custom",
    duration = 4,
    use_rotate = true,
    rotate = 360
  },
  spiralandpulse = {
    type = "custom",
    duration = 6,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "spiralandpulse"
  },
  circle = {
    type = "custom",
    duration = 4,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "circle"
  },
  orbit = {
    type = "custom",
    duration = 4,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "circle",
    use_rotate = true,
    rotate = 360
  },
  bounce = {
    type = "custom",
    duration = 0.6,
    use_translate = true,
    x = 0,
    y = 25,
    translateType = "bounce"
  }
};

function WeakAuras.CheckTalentByIndex(index, extraOption)
  local tab = ceil(index / MAX_NUM_TALENTS)
  local num_talent = (index - 1) % MAX_NUM_TALENTS + 1
  local name, _, _, _, rank  = GetTalentInfo(tab, num_talent)
  if name == nil then
    return nil
  end
  local result = rank and rank > 0
  if extraOption == 4 then
    return result
  elseif extraOption == 5 then
    return not result
  end
  return result;
end

function WeakAuras.CheckNumericIds(loadids, currentId)
  if (not loadids or not currentId) then
    return false;
  end

  local searchFrom = 0;
  local startI, endI = string.find(loadids, currentId, searchFrom);
  while (startI) do
    searchFrom = endI + 1; -- start next search from end
    if (startI == 1 or tonumber(string.sub(loadids, startI - 1, startI - 1)) == nil) then
      -- Either right at start, or character before is not a number
      if (endI == string.len(loadids) or tonumber(string.sub(loadids, endI + 1, endI + 1)) == nil) then
        return true;
      end
    end
    startI, endI = string.find(loadids, currentId, searchFrom);
  end
  return false;
end

function WeakAuras.ValidateNumeric(info, val)
  if val ~= nil and val ~= "" and (not tonumber(val) or tonumber(val) >= 2^31) then
    return false;
  end
  return true
end

function WeakAuras.ValidateTime(info, val)
  if val ~= nil and val ~= "" then
    if not tonumber(val) then
      if val:sub(1,1) == "-" then
        val = val:sub(2, #val)
      end
      return (val:match("^%d+:%d+:[%d%.]+$") or val:match("^%d+:[%d+%.]+$")) and true or false
    elseif tonumber(val) >= 2^31 then
      return false
    end
  end
  return true
end

function WeakAuras.TimeToSeconds(val)
  if tonumber(val) then
    return tonumber(val)
  else
    local sign = 1
    if val:sub(1,1) == "-" then
      sign = -1
      val = val:sub(2, #val)
    end
    local h, m, s = val:match("^(%d+):(%d+):([%d%.]+)$")
    if h and m and s then
      return (h*3600 + m*60 + s) * sign
    else
      local m, s = val:match("^(%d+):([%d%.]+)$")
      if m and s then
        return (m*60 + s) * sign
      end
    end
  end
end

Private.tinySecondFormat = function(value)
  if type(value) == "string" then value = tonumber(value) end
  if type(value) == "number" then
     local negative = value < 0
     value = math.abs(value)
     local fraction = value - math.floor(value)
     local ret
     if value > 3600 then
        ret = ("%i:%02i:%02i"):format(math.floor(value / 3600), math.floor((value % 3600) / 60), value % 60)
     elseif value > 60 then
        ret = ("%i:%02i"):format(math.floor(value / 60), value % 60)
     else
        ret = ("%i"):format(value)
     end
     local negSign = negative and "-" or ""
     if fraction > 0 then
        return negSign .. ret .. tostring(Round(fraction * 100) / 100):sub(2)
     else
        return negSign .. ret
     end
  end
end

function Private.ExecEnv.GetSpecIcon(specID)
  return specID and Private.specid_to_icon[specID] or ""
end

function Private.ExecEnv.GetSpecName(specID)
  return specID and Private.specid_to_name[specID] or ""
end

function Private.ExecEnv.GetSpecID(specName)
  return specName and Private.specname_to_id[specName] or 0
end

function Private.ExecEnv.GetUnitTalentSpec(unit)
  local spec = WeakAuras.LGT:GetUnitTalentSpec(unit)
  -- LibGroupTalents misses Guardian for tanks, so we fix it here
  if spec == L["Feral Combat"] then
    return (WeakAuras.LGT:GetUnitRole(unit) == "tank" and L["Guardian"]) or spec
  end
  return spec
end

function WeakAuras.CheckClassSpec(specID)
  specID = tonumber(specID)
  if not specID then return end
  local class = select(2, UnitClass("player")) or ""
  local currentSpec = Private.ExecEnv.GetUnitTalentSpec("player") or ""
  return Private.ExecEnv.GetSpecName(specID) == class .. currentSpec
end

function WeakAuras.SpecForUnit(unit)
  if not unit then return 0 end
  local spec = Private.ExecEnv.GetUnitTalentSpec(unit)
  local class = select(2, UnitClass(unit))
  return (spec and class) and Private.ExecEnv.GetSpecID(class .. spec) or 0
end

function Private.ExecEnv.ParseStringCheck(input)
  if not input then return end
  local matcher = {
    entries = {},
    negativeEntries = {},
    Check = function(self, e)
      return false
    end,
    CheckBoth = function(self, e)
      return self.entries[e] and not self.negativeEntries[e]
    end,
    CheckPositive = function(self, e)
      return self.entries[e]
    end,
    CheckNegative = function(self, e)
      return not self.negativeEntries[e]
    end,
    Add = function(self, e, negate)
      if negate then
        self.negativeEntries[e] = true
      else
        self.entries[e] = true
      end
    end
  }

  local start = 1
  local escaped = false
  local partial = ""
  local negate = false
  for i = 1, #input do
    local c = input:sub(i, i)
    if escaped then
      escaped = false
    elseif c == '\\' then
      partial = partial .. input:sub(start, i - 1)
      start = i + 1
      escaped = true
    elseif c == "," then
      matcher:Add(partial .. input:sub(start, i - 1):trim(), negate)
      start = i + 1
      partial = ""
      negate = false
    elseif c == "-" and partial:trim() == "" and input:sub(start, i - 1):trim() == "" then
      start = i + 1
      negate = true
    end
  end
  matcher:Add(partial .. input:sub(start, #input):trim(), negate)

  -- Update check function
  if next(matcher.entries) and next(matcher.negativeEntries) then
    matcher.Check = matcher.CheckBoth
  elseif next(matcher.entries) then
    matcher.Check = matcher.CheckPositive
  elseif next(matcher.negativeEntries) then
    matcher.Check = matcher.CheckNegative
  end

  return matcher
end

function WeakAuras.ValidateNumericOrPercent(info, val)
  if val ~= nil and val ~= "" then
    local index = val:find("%% *$")
    local number = index and tonumber(val:sub(1, index-1)) or tonumber(val)
    if(not number or number >= 2^31) then
      return false;
    end
  end
  return true
end

function Private.ExecEnv.CheckGroupMemberType(loadSetting, currentFlags)
  if loadSetting == "LEADER" then
    return bit.band(currentFlags, 1) == 1
  elseif loadSetting == "ASSIST" then
    return bit.band(currentFlags, 2) == 2
  else
    return currentFlags == 0
  end
end

function Private.ExecEnv.CheckChargesDirection(direction, triggerDirection)
  return triggerDirection == "CHANGED"
    or (triggerDirection == "GAINED" and direction > 0)
    or (triggerDirection == "LOST" and direction < 0)
end

function Private.ExecEnv.CheckCombatLogFlags(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  if(flagToCheck == "Mine") then
    return bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_MINE) > 0
  elseif (flagToCheck == "InGroup") then
    return bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) == 0
  elseif (flagToCheck == "InParty") then
    return bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_PARTY) > 0
  elseif (flagToCheck == "NotInGroup") then
    return bit.band(flags, COMBATLOG_OBJECT_AFFILIATION_OUTSIDER) > 0
  end
end

function Private.ExecEnv.CheckCombatLogFlagsReaction(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  if (flagToCheck == "Hostile") then
    return bit.band(flags, 64) ~= 0;
  elseif (flagToCheck == "Neutral") then
    return bit.band(flags, 32) ~= 0;
  elseif (flagToCheck == "Friendly") then
    return bit.band(flags, 16) ~= 0;
  end
end

local objectTypeToBit = {
  Object = 16384,
  Guardian = 8192,
  Pet = 4096,
  NPC = 2048,
  Player = 1024,
}

function Private.ExecEnv.CheckCombatLogFlagsObjectType(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  local bitToCheck = objectTypeToBit[flagToCheck]
  if not bitToCheck then return end
  return bit.band(flags, bitToCheck) ~= 0;
end

function WeakAuras.IsSpellKnownForLoad(spell, exact)
  local result = WeakAuras.IsSpellKnown(spell)
  if exact or result then
    return result
  end
  -- Dance through the spellname to the current spell id
  spell = GetSpellInfo(spell)
  if spell then
    return WeakAuras.IsSpellKnown(spell)
  end
end

function WeakAuras.IsSpellKnown(spell, pet)
  local id = tonumber(spell)
  if id then
    if id > 0 and id < 2^31 then
      return IsSpellKnown(id, pet)
    end
    return false
  end
  return GetSpellInfo(spell) and true or false
end

function WeakAuras.IsSpellKnownIncludingPet(spell)
  if (not spell) then
    return false;
  end
  return WeakAuras.IsSpellKnown(spell, false) or WeakAuras.IsSpellKnown(spell, true)
end

function WeakAuras.IsGlyphActive(glyphID)
  for slot = 1, GetNumGlyphSockets() or 6 do
    local enabled, _, glyphId = GetGlyphSocketInfo(slot)
    if glyphID == glyphId then
      return enabled == 1
    end
  end
  return false
end

function WeakAuras.GetEffectiveAttackPower()
  local base, pos, neg = UnitAttackPower("player")
  return base + pos + neg
end

function WeakAuras.GetEffectiveSpellPower()
  -- Straight from the PaperDoll
  local spellPower = 0
  for i = 2, MAX_SPELL_SCHOOLS or 7 do
    spellPower = max(spellPower, GetSpellBonusDamage(i))
  end
  return spellPower
end

function WeakAuras.GetEffectiveRangedAttackPower()
  local base, pos, neg = UnitRangedAttackPower("player")
  return base + pos + neg
end

local function valuesForTalentFunction(trigger)
  return function()
    local single_class = Private.checkForSingleLoadCondition(trigger, "class")
    if not single_class then
      single_class = select(2, UnitClass("player"));
    end

    return Private.talentInfo[single_class]
  end
end

---helper to check if a condition is checked and have a single value, and return it
function Private.checkForSingleLoadCondition(trigger, name, validateFn)
  local use_name = "use_"..name
  local trigger_use_name = trigger[use_name]
  local trigger_name = trigger[name]
  if trigger_use_name == true
  and trigger_name
  and trigger_name.single ~= nil
  and (validateFn == nil or validateFn(trigger_name.single))
  then
    return trigger_name.single
  end
  if trigger_use_name == false and trigger_name and trigger_name.multi ~= nil then
    local count = 0
    local key
    for k, v in pairs(trigger_name.multi) do
      if v ~= nil
      and (validateFn == nil or validateFn(k))
      then
        count = count + 1
        key = k
      end
    end
    if count == 1 then
      return key
    end
  end
end

Private.load_prototype = {
  -- Each entry
  --   name: name of argument for load function/option for options/setting in saved data
  --   Options data
  --     display: name to be displayed in the options
  --     type: type to be used for the options
  --     width: width in the options
  --     hidden: whether the option is shown in the options, defaults to false
  --   Load Function Data
  --     enable: whether the test should be tested or not, defaults to true
  --     test: overrides the default test
  --     init: whether the argument should be a function parameter or not. "arg" for yes. Defaults to no argument
  --     events: the events on which the test must be reevaluated
  --     optional: whether the test is relevant for the options classification between loaded and unloaded, defaults to false
  args = {
    {
      name ="generalTitle",
      display = L["General"],
      type = "description",
    },
    {
      name = "combat",
      display = L["In Combat"],
      type = "tristate",
      width = WeakAuras.normalWidth,
      init = "arg",
      optional = true,
      events = {"PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED"}
    },
    {
      name = "never",
      display = L["Never"],
      type = "toggle",
      width = WeakAuras.normalWidth,
      test = "false",
    },
    {
      name = "alive",
      display = L["Alive"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST"}
    },
    {
      name = "pvpmode",
      display = L["PvP Mode Active"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"PLAYER_FLAGS_CHANGED", "UNIT_FACTION", "ZONE_CHANGED"}
    },
    {
      name = "vehicle",
      display = L["In Vehicle"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"VEHICLE_UPDATE", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE", "UNIT_FLAGS"}
    },
    {
      name = "vehicleUi",
      display = L["Has Vehicle UI"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"VEHICLE_UPDATE", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE"}
    },
    {
      name = "mounted",
      display = L["Mounted"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"MOUNTED_UPDATE"}
    },
    {
      name ="playerTitle",
      display = L["Player"],
      type = "description",
    },
    {
      name = "class",
      display = L["Player Class"],
      type = "multiselect",
      values = "class_types",
      init = "arg"
    },
    {
      name = "class_and_spec",
      display = L["Class and Specialization"],
      type = "multiselect",
      values = "spec_types_all",
      test = "WeakAuras.CheckClassSpec(%s)",
      events = {"UNIT_SPEC_CHANGED_player", "WA_DELAYED_PLAYER_ENTERING_WORLD"},
    },
    {
      name = "talent",
      display = L["Talent"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d, %d)",
      multiConvertKey = nil,
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"},
      inverse = nil,
      extraOption = nil,
      control = "WeakAurasMiniTalent",
      multiNoSingle = true, -- no single mode
      multiTristate = true, -- values can be true/false/nil
      multiAll = true, -- require all tests
      orConjunctionGroup = "talent",
      multiUseControlWhenFalse = true,
      enable = function(trigger)
        return (Private.checkForSingleLoadCondition(trigger, "class") ~= nil)
      end,
      hidden = function(trigger)
        return not (Private.checkForSingleLoadCondition(trigger, "class") ~= nil)
      end,
    },
    {
      name = "talent2",
      display = L["Or Talent"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d, %d)",
      multiConvertKey = nil,
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"},
      inverse = nil,
      extraOption = nil,
      control = "WeakAurasMiniTalent",
      multiNoSingle = true, -- no single mode
      multiTristate = true, -- values can be true/false/nil
      multiAll = true, -- require all tests
      orConjunctionGroup = "talent",
      multiUseControlWhenFalse = true,
      enable = function(trigger)
        return (trigger.use_talent ~= nil or trigger.use_talent2 ~= nil) and (
          (Private.checkForSingleLoadCondition(trigger, "class") ~= nil)
        )
      end,
      hidden = function(trigger)
        return not((trigger.use_talent ~= nil or trigger.use_talent2 ~= nil) and (
          (Private.checkForSingleLoadCondition(trigger, "class") ~= nil))
        )
      end,
    },
    {
      name = "talent3",
      display = L["Or Talent"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d, %d)",
      multiConvertKey = nil,
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"},
      inverse = nil,
      extraOption = nil,
      control = "WeakAurasMiniTalent",
      multiNoSingle = true, -- no single mode
      multiTristate = true, -- values can be true/false/nil
      multiAll = true, -- require all tests
      orConjunctionGroup = "talent",
      multiUseControlWhenFalse = true,
      enable = function(trigger)
        return ((trigger.use_talent ~= nil and trigger.use_talent2 ~= nil) or trigger.use_talent3 ~= nil) and (
          (Private.checkForSingleLoadCondition(trigger, "class") ~= nil)
        )
      end,
      hidden = function(trigger)
        return not(((trigger.use_talent ~= nil and trigger.use_talent2 ~= nil) or trigger.use_talent3 ~= nil) and (
          (Private.checkForSingleLoadCondition(trigger, "class") ~= nil)
        ))
      end
    },
    {
      name = "glyph",
      display = L["Glyph"],
      type = "multiselect",
      values = function(trigger)
        Private.InitializeGlyphs(trigger and trigger.glyph)
        return Private.glyph_types
      end,
      sorted = true,
      sortOrder = Private.glyph_sorted or {},
      test = "WeakAuras.IsGlyphActive(%s)",
      events = {"GLYPH_ADDED", "GLYPH_REMOVED", "GLYPH_UPDATED", "USE_GLYPH"},
    },
    {
      name = "spellknown",
      display = L["Spell Known"],
      type = "spell",
      test = "WeakAuras.IsSpellKnownForLoad(%s, %s)",
      events = {"SPELLS_CHANGED", "UNIT_PET"},
      showExactOption = true
    },
    {
      name = "not_spellknown",
      display = WeakAuras.newFeatureString .. L["|cFFFF0000Not|r Spell Known"],
      type = "spell",
      test = "not WeakAuras.IsSpellKnownForLoad(%s, %s)",
      events = {"SPELLS_CHANGED", "UNIT_PET"},
      showExactOption = true
    },
    {
      name = "player",
      init = "arg",
      enable = false,
      hidden = true
    },
    {
      name = "realm",
      init = "arg",
      enable = false,
      hidden = true
    },
    {
      name = "guild",
      init = "arg",
      enable = false,
      hidden = true
    },
    {
      name = "namerealm",
      display = L["Player Name/Realm"],
      type = "string",
      multiline = true,
      test = "nameRealmChecker:Check(player, realm)",
      preamble = "local nameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
      desc = constants.nameRealmFilterDesc,
    },
    {
      name = "ignoreNameRealm",
      display = L["|cFFFF0000Not|r Player Name/Realm"],
      type = "string",
      multiline = true,
      test = "not nameRealmIgnoreChecker:Check(player, realm)",
      preamble = "local nameRealmIgnoreChecker = Private.ExecEnv.ParseNameCheck(%q)",
      desc = constants.nameRealmFilterDesc,
    },
    {
      name = "guildcheck",
      display = L["Guild"],
      type = "string",
      multiline = true,
      test = "guildChecker:Check(guild)",
      preamble = "local guildChecker = Private.ExecEnv.ParseStringCheck(%q)",
      desc = constants.guildFilterDesc,
      events = {"PLAYER_GUILD_UPDATE"}
    },
    {
      name = "race",
      display = L["Player Race"],
      type = "multiselect",
      values = "race_types",
      init = "arg"
    },
    {
      name = "faction",
      display = L["Player Faction"],
      type = "multiselect",
      values = "faction_group",
      init = "arg"
    },
    {
      name = "level",
      display = L["Player Level"],
      type = "number",
      init = "arg",
      events = {"PLAYER_LEVEL_UP"},
      multiEntry = {
        operator = "and",
        limit = 2
      },
    },
    {
      name = "role",
      display = L["Spec Role"],
      type = "multiselect",
      values = "role_types",
      init = "arg",
      events = {"PLAYER_ROLES_ASSIGNED", "PLAYER_TALENT_UPDATE", "WA_DELAYED_PLAYER_ENTERING_WORLD"}
    },
    {
      name = "spec_position",
      display = WeakAuras.newFeatureString .. L["Spec Position"],
      type = "multiselect",
      values = "spec_position_types",
      init = "arg",
      events = {"PLAYER_ROLES_ASSIGNED", "PLAYER_TALENT_UPDATE", "WA_DELAYED_PLAYER_ENTERING_WORLD"}
    },
    {
      name = "raid_role",
      display = L["Raid Role"],
      type = "multiselect",
      values = "raid_role_types",
      init = "arg",
      events = {"PLAYER_ROLES_ASSIGNED"}
    },
    {
      name = "ingroup",
      display = L["Group Type"],
      type = "multiselect",
      width = WeakAuras.normalWidth,
      init = "arg",
      values = "group_types",
      events = {"PARTY_MEMBERS_CHANGED", "RAID_ROSTER_UPDATE"},
      optional = true,
    },
    {
      name = "groupSize",
      display = L["Group Size"],
      type = "number",
      init = "arg",
      events = {"PARTY_MEMBERS_CHANGED", "RAID_ROSTER_UPDATE"},
      multiEntry = {
        operator = "and",
        limit = 2
      },
      optional = true,
    },
    {
      name = "group_leader",
      display = WeakAuras.newFeatureString .. L["Group Leader/Assist"],
      type = "multiselect",
      init = "arg",
      events = {"PARTY_LEADER_CHANGED", "PLAYER_FLAGS_CHANGED", "RAID_ROSTER_UPDATE"},
      values = "group_member_types",
      test = "Private.ExecEnv.CheckGroupMemberType(%s, group_leader)",
      optional = true,
    },
    {
      name ="locationTitle",
      display = L["Location"],
      type = "description",
    },
    {
      name = "zone",
      display = L["Zone Name"],
      type = "string",
      multiline = true,
      init = "arg",
      preamble = "local checker = Private.ExecEnv.ParseStringCheck(%q)",
      test = "checker:Check(zone)",
      events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "VEHICLE_UPDATE", "WA_DELAYED_PLAYER_ENTERING_WORLD" },
      desc = function()
        return ("\n|cffffd200%s|r%s\n\n%s"):format(L["Current Zone\n"], GetRealZoneText(), L["Supports multiple entries, separated by commas. Prefix with '-' for negation."])
      end,
      optional = true,
    },
    {
      name = "zoneId",
      display = L["Player Location ID(s)"],
      type = "string",
      multiline = true,
      init = "arg",
      test = "WeakAuras.CheckNumericIds(%q, zoneId)",
      events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "VEHICLE_UPDATE", "WA_DELAYED_PLAYER_ENTERING_WORLD" },
      desc = function()
	    return ("\n|cffffd200%s|r%s: %d\n\n%s"):format(L["Current Zone\n"], GetRealZoneText(), GetCurrentMapAreaID(), L["Supports multiple entries, separated by commas. Prefix with '-' for negation."])
	    end,
      optional = true,
    },
    {
      name = "subzone",
      display = L["Subzone Name"],
      type = "string",
      multiline = true,
      init = "arg",
      preamble = "local subzoneChecker = Private.ExecEnv.ParseStringCheck(%q)",
      test = "subzoneChecker:Check(subzone)",
      events = { "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "VEHICLE_UPDATE", "WA_DELAYED_PLAYER_ENTERING_WORLD" },
      desc = function()
        return ("\n|cffffd200%s|r%s\n\n%s"):format(L["Current Zone\n"], GetMinimapZoneText(), L["Supports multiple entries, separated by commas. Prefix with '-' for negation."])
      end,
      optional = true,
    },
    {
      name = "size",
      display = L["Instance Size Type"],
      type = "multiselect",
      values = "instance_types",
      sorted = true,
      init = "arg",
      events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "WA_DELAYED_PLAYER_ENTERING_WORLD"},
      optional = true,
    },
    {
      name = "difficulty",
      display = L["Instance Difficulty"],
      type = "multiselect",
      values = "difficulty_types",
      init = "arg",
      events = {"PLAYER_DIFFICULTY_CHANGED", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "WA_DELAYED_PLAYER_ENTERING_WORLD"},
      optional = true,
    },
    {
      name ="equipmentTitle",
      display = L["Equipment"],
      type = "description",
    },
    {
      name = "itemequiped",
      display = L["Item Equipped"],
      type = "item",
      multiEntry = {
        operator = "or"
      },
      test = "IsEquippedItem(%s or '')",
      events = { "UNIT_INVENTORY_CHANGED", "PLAYER_EQUIPMENT_CHANGED"},
      only_exact = true,
    },
    {
      name = "not_itemequiped",
      display = WeakAuras.newFeatureString .. L["|cFFFF0000Not|r Item Equipped"],
      type = "item",
      multiEntry = {
        operator = "or"
      },
      test = "not IsEquippedItem(%s or '')",
      events = { "UNIT_INVENTORY_CHANGED", "PLAYER_EQUIPMENT_CHANGED"},
      only_exact = true,
    },
  }
};

local function AddUnitChangeInternalEvents(triggerUnit, t, includePets, unitisunit)
  if (triggerUnit == nil) then
    return
  end
  if (triggerUnit == "multi") then
    -- Handled by normal events"
  elseif triggerUnit == "pet" then
    tinsert(t, "PET_UPDATE")
  else
    if Private.multiUnitUnits[triggerUnit] then
      local isPet
      for unit in pairs(Private.multiUnitUnits[triggerUnit]) do
        isPet = WeakAuras.UnitIsPet(unit)
        if (includePets ~= nil and isPet) or (includePets ~= "PetsOnly" and not isPet) then
          tinsert(t, "UNIT_CHANGED_" .. string.lower(unit))
          if unitisunit then
            tinsert(t, "UNIT_IS_UNIT_CHANGED_" .. string.lower(unit) .. "_" .. string.lower(unitisunit))
          end
        end
      end
    else
      tinsert(t, "UNIT_CHANGED_" .. string.lower(triggerUnit))
      if unitisunit then
        tinsert(t, "UNIT_IS_UNIT_CHANGED_" .. string.lower(triggerUnit) .. "_" .. string.lower(unitisunit))
      end
    end
  end
end

local function AddWatchedUnits(triggerUnit, includePets, unitisunit)
  if (triggerUnit == nil) then
    return
  end
  if (triggerUnit == "multi") then
    -- Handled by normal events"
  elseif triggerUnit == "pet" then
    WeakAuras.WatchForPetDeath();
  else
    if Private.multiUnitUnits[triggerUnit] then
      local isPet
      for unit in pairs(Private.multiUnitUnits[triggerUnit]) do
        isPet = WeakAuras.UnitIsPet(unit)
        if (includePets ~= nil and isPet) or (includePets ~= "PetsOnly" and not isPet) then
          if unitisunit then
            WeakAuras.WatchUnitChange(unitisunit)
          end
          WeakAuras.WatchUnitChange(unit)
        end
      end
    else
      if unitisunit then
        WeakAuras.WatchUnitChange(unitisunit)
      end
      WeakAuras.WatchUnitChange(triggerUnit)
    end
  end
end

local function AddUnitSpecChangeInternalEvents(triggerUnit, t)
  if (triggerUnit == nil) then
    return
  end

  if Private.multiUnitUnits[triggerUnit] then
    for unit in pairs(Private.multiUnitUnits[triggerUnit]) do
      local isPet = WeakAuras.UnitIsPet(unit)
      if (not isPet) then
        tinsert(t, "UNIT_SPEC_CHANGED_" .. string.lower(unit))
      end
    end
  else
    tinsert(t, "UNIT_SPEC_CHANGED_" .. string.lower(triggerUnit))
  end
end

local function AddUnitRoleChangeInternalEvents(triggerUnit, t)
  if (triggerUnit == nil) then
    return
  end

  if Private.multiUnitUnits[triggerUnit] then
    for unit in pairs(Private.multiUnitUnits[triggerUnit]) do
      if not WeakAuras.UnitIsPet(unit) then
        tinsert(t, "UNIT_ROLE_CHANGED_" .. string.lower(unit))
      end
    end
  else
    if not WeakAuras.UnitIsPet(triggerUnit) then
      tinsert(t, "UNIT_ROLE_CHANGED_" .. string.lower(triggerUnit))
    end
  end
end

local function AddRemainingCastInternalEvents(triggerUnit, t)
  if (triggerUnit == nil) then
    return
  end

  if Private.multiUnitUnits[triggerUnit] then
    for unit in pairs(Private.multiUnitUnits[triggerUnit]) do
      tinsert(t, "CAST_REMAINING_CHECK_" .. string.lower(unit))
    end
  else
    tinsert(t, "CAST_REMAINING_CHECK_" .. string.lower(triggerUnit))
  end
end

local function AddUnitEventForEvents(result, unit, event)
  if unit then
    if not result.unit_events then
      result.unit_events = {}
    end
    if not result.unit_events[unit] then
      result.unit_events[unit] = {}
    end
    tinsert(result.unit_events[unit], event)
  else
    if not result.events then
      result.events = {}
    end
    tinsert(result.events, event)
  end
end

local powerEvents = {
  [0] = { "UNIT_MANA", "UNIT_MAXMANA" },
  [1] = { "UNIT_RAGE", "UNIT_MAXRAGE" },
  [2] = { "UNIT_FOCUS", "UNIT_MAXFOCUS" },
  [3] = { "UNIT_ENERGY", "UNIT_MAXENERGY" },
  [27] = { "UNIT_HAPPINESS", "UNIT_MAXHAPPINESS" },
  [6] = { "UNIT_RUNIC_POWER", "UNIT_MAXRUNIC_POWER" }
}

local function AddUnitEventForPowerEvents(result, unit, powerType)
  if powerType then
    if powerType == 4 then return end
    for _, event in ipairs(powerEvents[powerType]) do
      AddUnitEventForEvents(result, unit, event)
    end
  else
    for _, eventsList in pairs(powerEvents) do
      for _, event in ipairs(eventsList) do
        AddUnitEventForEvents(result, unit, event)
      end
    end
  end
  return result
end

local function AddTargetConditionEvents(result, useFocus)
  if useFocus then
    tinsert(result, "PLAYER_FOCUS_CHANGED")
  end
  tinsert(result, "PLAYER_TARGET_CHANGED")
  return result
end

Private.AddTargetConditionEvents = AddTargetConditionEvents

local unitHelperFunctions = {
  UnitChangedForceEventsWithPets = function(trigger)
    local events = {}
    local includePets = trigger.use_includePets == true and trigger.includePets or nil
    if Private.multiUnitUnits[trigger.unit] then
      local isPet
      for unit in pairs(Private.multiUnitUnits[trigger.unit]) do
        isPet = WeakAuras.UnitIsPet(unit)
        if (includePets ~= nil and isPet) or (includePets ~= "PetsOnly" and not isPet) then
          tinsert(events, {"UNIT_CHANGED_" .. unit, unit})
        end
      end
    else
      if trigger.unit then
        tinsert(events, {"UNIT_CHANGED_" .. trigger.unit, trigger.unit})
      end
    end
    return events
  end,

  UnitChangedForceEvents = function(trigger)
    local events = {}
    if Private.multiUnitUnits[trigger.unit] then
      for unit in pairs(Private.multiUnitUnits[trigger.unit]) do
        if not WeakAuras.UnitIsPet(unit) then
          tinsert(events, {"UNIT_CHANGED_" .. unit, unit})
        end
      end
    else
      if trigger.unit then
        tinsert(events, {"UNIT_CHANGED_" .. trigger.unit, trigger.unit})
      end
    end
    return events
  end,

  SpecificUnitCheck = function(trigger)
    if not trigger.use_specific_unit then
      return "local specificUnitCheck = true\n"
    end

    if trigger.unit == nil then
      return "local specificUnitCheck = false\n"
    end

    return string.format([=[
      local specificUnitCheck = UnitIsUnit(%q, unit)
    ]=], trigger.unit or "")
  end
}

Private.event_categories = {
  spell = {
    name = L["Spell"],
    default = "Cooldown Progress (Spell)"
  },
  item = {
    name = L["Item"],
    default = "Cooldown Progress (Item)"
  },
  unit = {
    name = L["Player/Unit Info"],
    default = "Health"
  },
  addons = {
    name = L["Other Addons"],
    default = "GTFO"
  },
  combatlog = {
    name = L["Combat Log"],
    default = "Combat Log",
  },
  event = {
    name = L["Other Events"],
    default = "Chat Message"
  },
  custom = {
    name = L["Custom"],
  }
}

local GetNameAndIconForSpellName = function(trigger)
  if type(trigger.spellName) == "table" then return end
  local name, _, icon = GetSpellInfo(trigger.spellName or 0)
  return name, icon
end

Private.event_prototypes = {
  ["Unit Characteristics"] = {
    type = "unit",
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitEventForEvents(result, unit, "UNIT_LEVEL")
      AddUnitEventForEvents(result, unit, "UNIT_FACTION")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
      AddUnitEventForEvents(result, unit, "PLAYER_FLAGS_CHANGED")
      if trigger.use_inRange then
        AddUnitEventForEvents(result, unit, "UNIT_IN_RANGE_UPDATE")
      end
      return result;
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitChangeInternalEvents(unit, result, nil, trigger.use_unitisunit and trigger.unitisunit or nil)
      AddUnitRoleChangeInternalEvents(unit, result)
      AddUnitSpecChangeInternalEvents(unit, result)
      return result
    end,
    loadFunc = function(trigger)
      AddWatchedUnits(trigger.unit, nil, trigger.use_unitisunit and trigger.unitisunit or nil)
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    name = L["Unit Characteristics"],
    init = function(trigger)
      trigger.unit = trigger.unit or "target";
      local ret = [=[
        unit = string.lower(unit)
        local smart = %s
        local extraUnit = %q;
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
      ]=];

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret:format(trigger.unit == "group" and "true" or "false", trigger.unitisunit or "");
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        desc = Private.actual_unit_types_cast_tooltip,
        test = "true",
        store = true,
        reloadOptions = true,
      },
      {
        name = "unitisunit",
        display = L["Unit is Unit"],
        type = "unit",
        init = "UnitIsUnit(unit, extraUnit)",
        values = function(trigger)
          if Private.multiUnitUnits[trigger.unit] then
            return Private.actual_unit_types
          else
            return Private.actual_unit_types_with_specific
          end
        end,
        test = "unitisunit",
        desc = function() return L["Can be used for e.g. checking if \"boss1target\" is the same as \"player\"."] end,
      },
      {
        name = "name",
        display = L["Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        desc = constants.nameRealmFilterDesc,
        type = "string",
        multiline = true,
        preamble = "local nameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "specId",
        display = L["Specialization"],
        type = "multiselect",
        init = "WeakAuras.SpecForUnit(unit)",
        values = "spec_types_all",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" or trigger.unit == "player"
        end,
        desc = L["Requires syncing the specialization via LibGroupTalents."],
      },
      {
        name = "classification",
        display = L["Classification"],
        type = "multiselect",
        init = "UnitClassification(unit)",
        values = "classification_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "creatureTypeIndex",
        display = L["Creature Type"],
        type = "multiselect",
        init = "Private.ExecEnv.creature_type_name_to_id[UnitCreatureType(unit or '') or 0]",
        values = "creature_type_types",
        store = true,
        sorted = true,
        conditionType = "select",
      },
      {
        name = "creatureType",
        display = L["Creature Type Name"],
        init = "UnitCreatureType(unit)",
        store = true,
        test = "true",
        hidden = true,
      },
      {
        name = "creatureFamilyIndex",
        display = L["Creature Family"],
        type = "multiselect",
        init = "Private.ExecEnv.creature_family_name_to_id[UnitCreatureFamily(unit or '') or 0]",
        values = "creature_family_types",
        store = true,
        sorted = true,
        conditionType = "select",
      },
      {
        name = "creatureFamily",
        display = L["Creature Family Name"],
        init = "UnitCreatureFamily(unit)",
        store = true,
        test = "true",
        hidden = true,
      },
      {
        name = "role",
        display = L["Spec Role"],
        type = "select",
        init = "WeakAuras.LGT:GetUnitRole(unit)",
        values = "role_types",
        store = true,
        conditionType = "select",
      },
      {
        name = "raid_role",
        display = L["Raid Role"],
        type = "select",
        init = "WeakAuras.UnitRaidRole(unit)",
        values = "raid_role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "raidMarkIndex",
        display = L["Raid Mark"],
        type = "multiselect",
        values = "raid_mark_check_type",
        store = true,
        conditionType = "select",
        init = "GetRaidTargetIndex(unit) or 0"
      },
      {
        name = "raidMark",
        display = L["Raid Mark Icon"],
        store = true,
        hidden = true,
        test = "true",
        init = "raidMarkIndex > 0 and '{rt'..raidMarkIndex..'}' or ''"
      },
      {
        name = "dead",
        display = L["Dead"],
        type = "tristate",
        width = WeakAuras.doubleWidth,
        init = "UnitIsDeadOrGhost(unit)",
        store = true,
        conditionType = "bool",
      },
      {
        name = "ignoreSelf",
        display = L["Ignore Self"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsUnit(\"player\", unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        name = "inRange",
        display = L["In Range"],
        desc = L["Uses UnitInRange() to check if in range. Matches default raid frames out of range behavior, which is between 25 to 40 yards depending on your class and spec."],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitInRange(unit)"
      },
      {
        name = "hostility",
        display = L["Hostility"],
        type = "select",
        init = "WeakAuras.GetPlayerReaction(unit)",
        values = "hostility_types",
        store = true,
        conditionType = "select",
      },
      {
        name = "character",
        display = L["Character Type"],
        type = "select",
        init = "UnitIsPlayer(unit) and 'player' or 'npc'",
        values = "character_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "level",
        display = L["Level"],
        type = "number",
        init = "UnitLevel(unit)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        multiline = true,
        store = true,
        init = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '')",
        conditionType = "string",
        preamble = "local npcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "npcIdChecker:Check(npcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.npcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."]
      },
      {
        name = "attackable",
        display = L["Attackable"],
        type = "tristate",
        init = "UnitCanAttack('player', unit)",
        store = true,
        conditionType = "bool"
      },
      {
        name = "inCombat",
        display = L["In Combat"],
        type = "tristate",
        init = "UnitAffectingCombat(unit)",
        store = true,
        conditionType = "bool"
      },
      {
        name = "afk",
        display = L["Afk"],
        type = "tristate",
        init = "UnitIsAFK(unit)",
        store = true,
        conditionType = "bool"
      },
      {
        name = "dnd",
        display = L["Do Not Disturb"],
        type = "tristate",
        init = "UnitIsDND(unit)",
        store = true,
        conditionType = "bool"
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    automaticrequired = true,
    progressType = "none"
  },
  ["Faction Reputation"] = {
    type = "unit",
    progressType = "static",
    events = {
      ["events"] = {
        "UPDATE_FACTION",
      }
    },
    internal_events = {"WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "UPDATE_FACTION",
    name = L["Faction Reputation"],
    statesParameter = "one",
    automaticrequired = true,
    init = function(trigger)
      local ret = [=[
        local useWatched = %s
        local factionID = useWatched and Private.ExecEnv.GetWatchedFactionId() or %q
        local minValue, maxValue, currentValue
        local factionData = Private.ExecEnv.GetFactionDataByID(factionID)
        if not factionData then return end;

        local name, description = factionData.name, factionData.description
        local standingID = factionData.reaction
        local hasRep = factionData.isHeaderWithRep
        local barMin, barMax, barValue = factionData.currentReactionThreshold, factionData.nextReactionThreshold, factionData.currentStanding
        local atWarWith, canToggleAtWar, isHeader, isCollapsed, isWatched, isChild = factionData.atWarWith, factionData. canToggleAtWar, factionData.isHeader, factionData.isCollapsed, factionData.isWatched, factionData.isChild
        minValue, maxValue, currentValue = barMin, barMax, barValue
        local standing
        if tonumber(standingID) then
           standing = GetText("FACTION_STANDING_LABEL"..standingID, UnitSex("player"))
        end
        local isCapped = standingID == 8 and currentValue >= 42999
      ]=]
      return ret:format(trigger.use_watched and "true" or "false", trigger.factionID or 0)
    end,
    args = {
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "watched",
        display = L["Use Watched Faction"],
        type = "toggle",
        test = "true",
        reloadOptions = true,
      },
      {
        name = "factionID",
        display = L["Faction"],
        required = true,
        type = "select",
        itemControl = "Dropdown-Currency",
        values = Private.GetReputations,
        headers = Private.GetReputationsHeaders,
        sorted = true,
        sortOrder = function()
          local sorted = Private.GetReputationsSorted()
          local sortOrder = {}
          for key, value in pairs(Private.GetReputations()) do
            tinsert(sortOrder, key)
          end
          table.sort(sortOrder, function(aKey, bKey)
            local aValue = sorted[aKey]
            local bValue = sorted[bKey]
            return aValue < bValue
          end)
          return sortOrder
        end,
        conditionType = "select",
        enable = function(trigger)
          return not trigger.use_watched
        end,
        reloadOptions = true,
        test = "true",
      },
      {
        name = "name",
        display = L["Faction Name"],
        type = "string",
        store = true,
        hidden = "true",
        init = "name",
        test = "true"
      },
      {
        name = "value",
        display = L["Reputation"],
        type = "number",
        store = true,
        init = [[currentValue - minValue]],
        conditionType = "number",
        progressTotal = "total",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "total",
        display = L["Total Reputation"],
        type = "number",
        store = true,
        init = [[maxValue - minValue]],
        conditionType = "number",
        noProgressSource = true,
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "percentRep",
        display = L["Reputation (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100 or nil",
        store = true,
        conditionType = "number",
        noProgressSource = true,
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "standing",
        display = L["Standing"],
        type = "string",
        init = "standing",
        store = true,
        hidden = "true",
        test = "true"
      },
      {
        name = "standingId",
        display = L["Standing"],
        type = "select",
        values = function()
          local ret = {}
          for i = 1, 8 do
            ret[i] = GetText("FACTION_STANDING_LABEL"..i, UnitSex("player"))
          end
          return ret
        end,
        init = "standingID",
        store = true,
        conditionType = "select",
      },
      {
        name = "capped",
        display = L["Capped"],
        type = "tristate",
        init = "isCapped",
        conditionType = "bool",
        store = true,
      },
      {
        name = "atWar",
        display = L["At War"],
        type = "tristate",
        init = "atWarWith",
        conditionType = "bool",
        store = true,
      },
    }
  },
  ["Experience"] = {
    type = "unit",
    progressType = "static",
    events = {
      ["events"] = {
        "PLAYER_XP_UPDATE",
      }
    },
    internal_events = {"WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "PLAYER_XP_UPDATE",
    name = L["Player Experience"],
    init = function(trigger)
      return ""
    end,
    statesParameter = "one",
    args = {
      {
        name = "level",
        display = L["Level"],
        required = false,
        type = "number",
        store = true,
        init = [[UnitLevel("player")]],
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "currentXP",
        display = L["Current Experience"],
        type = "number",
        store = true,
        init = [[UnitXP("player")]],
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        progressTotal = "totalXP"
      },
      {
        name = "totalXP",
        display = L["Total Experience"],
        type = "number",
        store = true,
        init = [[UnitXPMax("player")]],
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "value",
        type = "number",
        store = true,
        init = "currentXP",
        hidden = true,
        test = "true",
      },
      {
        name = "total",
        type = "number",
        store = true,
        init = "totalXP",
        hidden = true,
        test = "true",
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "percentXP",
        display = L["Experience (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100 or nil",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        type = "header",
        name = "restedExperienceHeader",
        display = L["Rested Experience"],
      },
      {
        name = "showRested",
        display = L["Show Rested Overlay"],
        type = "toggle",
        test = "true",
        reloadOptions = true,
      },
      {
        name = "restedXP",
        display = L["Rested Experience"],
        init = [[GetXPExhaustion() or 0]],
        type = "number",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "percentrested",
        display = L["Rested Experience (%)"],
        init = "total ~= 0 and (restedXP / total) * 100 or nil",
        type = "number",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
    },
    overlayFuncs = {
      {
        name = L["Rested"],
        func = function(trigger, state)
          return "forward", state.restedXP
        end,
        enable = function(trigger)
          return trigger.use_showRested
        end
      },
    },
    automaticrequired = true
  },
  ["Health"] = {
    type = "unit",
    includePets = "true",
    progressType = "static",
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitEventForEvents(result, unit, "UNIT_HEALTH")
      AddUnitEventForEvents(result, unit, "UNIT_MAXHEALTH")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      if trigger.use_ignoreDead or trigger.use_ignoreDisconnected then
        AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
      end
      if trigger.use_inRange then
        AddUnitEventForEvents(result, unit, "UNIT_IN_RANGE_UPDATE")
      end
      return result
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddUnitChangeInternalEvents(unit, result, includePets)
      if includePets ~= "PetsOnly" then
        AddUnitRoleChangeInternalEvents(unit, result)
      end
      AddUnitSpecChangeInternalEvents(unit, result)
      return result
    end,
    loadFunc = function(trigger)
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddWatchedUnits(trigger.unit, includePets)
    end,
    force_events = unitHelperFunctions.UnitChangedForceEventsWithPets,
    name = L["Health"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = [=[
        unit = string.lower(unit)
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
        local smart = %s
      ]=];

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret:format(trigger.unit == "group" and "true" or "false");
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        desc = Private.actual_unit_types_cast_tooltip,
        test = "true",
        store = true
      },
      {
        name = "health",
        display = L["Health"],
        type = "number",
        init = "UnitHealth(unit)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        progressTotal = "maxhealth",
        formatter = "BigNumber",
      },
      {
        name = "value",
        hidden = true,
        init = "health",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "UnitHealthMax(unit)",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "percenthealth",
        display = L["Health (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100 or nil",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "deficit",
        display = L["Health Deficit"],
        type = "number",
        init = "total - value",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        progressTotal = "total",
        formatter = "BigNumber",
      },
      {
        name = "maxhealth",
        display = WeakAuras.newFeatureString .. L["Max Health"],
        type = "number",
        init = "total",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "BigNumber",
      },
      {
        type = "header",
        name = "unitCharacteristicsHeader",
        display = L["Unit Characteristics"],
      },
      {
        name = "name",
        display = L["Unit Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        type = "string",
        multiline = true,
        preamble = "local nameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        multiline = true,
        store = true,
        init = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '')",
        conditionType = "string",
        preamble = "local npcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "npcIdChecker:Check(npcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.npcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."]
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "specId",
        display = L["Specialization"],
        type = "multiselect",
        init = "WeakAuras.SpecForUnit(unit)",
        values = "spec_types_all",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" or trigger.unit == "player"
        end,
        desc = L["Requires syncing the specialization via LibGroupTalents."],
      },
      {
        name = "role",
        display = L["Spec Role"],
        type = "select",
        init = "WeakAuras.LGT:GetUnitRole(unit)",
        values = "role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" or trigger.unit == "player"
        end
      },
      {
        name = "raid_role",
        display = L["Raid Role"],
        type = "select",
        init = "WeakAuras.UnitRaidRole(unit)",
        values = "raid_role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "raidMarkIndex",
        display = L["Raid Mark"],
        type = "multiselect",
        values = "raid_mark_check_type",
        store = true,
        conditionType = "select",
        init = "GetRaidTargetIndex(unit) or 0"
      },
      {
        name = "raidMark",
        display = L["Raid Mark Icon"],
        store = true,
        hidden = true,
        test = "true",
        init = "raidMarkIndex > 0 and '{rt'..raidMarkIndex..'}' or ''"
      },
      {
        type = "header",
        name = "miscellaneousHeader",
        display = L["Miscellaneous"],
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
      },
      {
        name = "includePets",
        display = L["Include Pets"],
        type = "select",
        values = "include_pets_types",
        width = WeakAuras.normalWidth,
        test = "true",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "ignoreSelf",
        display = L["Ignore Self"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsUnit(\"player\", unit)"
      },
      {
        name = "ignoreDead",
        display = L["Ignore Dead"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsDeadOrGhost(unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        name = "inRange",
        display = L["In Range"],
        desc = L["Uses UnitInRange() to check if in range. Matches default raid frames out of range behavior, which is between 25 to 40 yards depending on your class and spec."],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitInRange(unit)"
      },
      {
        name = "nameplateType",
        display = L["Hostility"],
        type = "select",
        init = "WeakAuras.GetPlayerReaction(unit)",
        values = "hostility_types",
        conditionType = "select",
        store = true,
      },
      {
        name = "name",
        hidden = true,
        init = "UnitName(unit)",
        test = "true"
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    automaticrequired = true
  },
  ["Power"] = {
    type = "unit",
    progressType = "static",
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      local powerType = trigger.use_powertype and trigger.powertype

      if trigger.powertype == 4 then
        local _, class = UnitClass("player")
        AddUnitEventForEvents(result, unit, "UNIT_COMBO_POINTS")
        AddUnitEventForEvents(result, unit, "UNIT_TARGET")
        if class == "DRUID" then
          AddUnitEventForEvents(result, unit, "UNIT_MODEL_CHANGED")
        end
      -- For units not in multiUnitUnits, add FRAME_UPDATE to ensure smooth power updates
      elseif unit and not Private.multiUnitUnits[unit] then
        if not result.events then
          result.events = {}
        end
        tinsert(result.events, "FRAME_UPDATE")
      else
        AddUnitEventForPowerEvents(result, unit, powerType)
      end

      -- The api for spell power costs is not meant to be for other units
      if trigger.use_showCost and unit == "player" then
        AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_START")
        AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_STOP")
        AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_FAILED")
        AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_SUCCEEDED")
      end

      -- Register shared events unless we're in the FRAME_UPDATE case
      if (not (unit and not Private.multiUnitUnits[unit])) or (trigger.powertype == 4) then
        AddUnitEventForEvents(result, unit, "UNIT_DISPLAYPOWER")
        AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
        if trigger.use_ignoreDead or trigger.use_ignoreDisconnected then
          AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
        end
        if trigger.use_inRange then
          AddUnitEventForEvents(result, unit, "UNIT_IN_RANGE_UPDATE")
        end
      end
      return result;
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddUnitChangeInternalEvents(unit, result, includePets)
      if includePets ~= "PetsOnly" then
        AddUnitRoleChangeInternalEvents(unit, result)
      end
      AddUnitSpecChangeInternalEvents(unit, result)
      if trigger.use_showCost and trigger.unit == "player" then
        tinsert(result, "WA_UNIT_QUEUED_SPELL_CHANGED");
      end
      return result
    end,
    loadFunc = function(trigger)
      if trigger.use_showCost and trigger.unit == "player" then
        WeakAuras.WatchForQueuedSpell()
      end
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddWatchedUnits(trigger.unit, includePets)
    end,
    force_events = unitHelperFunctions.UnitChangedForceEventsWithPets,
    name = L["Power"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = {}
      table.insert(ret, ([=[
        unit = string.lower(unit)
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
        local smart = %s
        local powerType = %s
        local unitPowerType = UnitPowerType(unit);
        local powerTypeToCheck = powerType or unitPowerType;
      ]=]):format(trigger.unit == "group" and "true" or "false", trigger.use_powertype and trigger.powertype or "nil"))
      local powerType = trigger.use_powertype and trigger.powertype or nil
      -- Combo Points
      if powerType == 4 then
        local _, class = UnitClass("player")
        table.insert(ret, [[
          local comboUnit = UnitInVehicle(unit) and 'vehicle' or unit
          local power = GetComboPoints(comboUnit, 'target')
          local total = MAX_COMBO_POINTS
        ]])
        if class == "ROGUE" then
          table.insert(ret, [[
            unitPowerType = 4
          ]])
        elseif class == "DRUID" then
          local formName = GetSpellInfo(768) or ""
          table.insert(ret, ([[
            local index = GetShapeshiftForm() or 0
            local form = index > 0 and select(2, GetShapeshiftFormInfo(index)) == %q
            if form or comboUnit == 'vehicle' then
              unitPowerType = 4
            end
          ]]):format(formName))
        end
      -- Happiness
      elseif powerType == 27 then
        table.insert(ret, [[
          local power = UnitPower(unit, 4)
          local total = math.max(1, UnitPowerMax(unit, 4))
        ]])
      else
        table.insert(ret, [[
          local power = UnitPower(unit, powerType)
          local total = math.max(1, UnitPowerMax(unit, powerType))
        ]])
      end

      table.insert(ret, unitHelperFunctions.SpecificUnitCheck(trigger))

      local canEnableShowCost = (not trigger.use_powertype) and trigger.unit == "player";
      if (canEnableShowCost and trigger.use_showCost) then
        table.insert(ret, [[
          if (event == "UNIT_DISPLAYPOWER") then
            local cost = WeakAuras.GetSpellCost(powerTypeToCheck)
            if state.cost ~= cost then
              state.cost = cost
              state.changed = true
            end
          elseif ( (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_SUCCEEDED") and unit == "player") or event == "WA_UNIT_QUEUED_SPELL_CHANGED" then
            local cost = WeakAuras.GetSpellCost(powerTypeToCheck)
            if state.cost ~= cost then
              state.cost = cost
              state.changed = true
            end
          end
        ]])
      end

      return table.concat(ret)
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        desc = Private.actual_unit_types_cast_tooltip,
        test = "true",
        store = true
      },
      {
        name = "powertype",
        display = L["Power Type"],
        type = "select",
        values = function(trigger)
          if trigger and trigger.unit ~= "player" then
            return Private.power_types
          else
            return Private.power_types_player
          end
        end,
        init = "powerTypeToCheck",
        test = "true",
        store = true,
        conditionType = "select",
        reloadOptions = true
      },
      {
        name = "requirePowerType",
        display = L["Only if Primary"],
        type = "toggle",
        test = "unitPowerType == powerType",
        enable = function(trigger)
          return trigger.use_powertype
        end,
      },
      {
        name = "showCost",
        display = L["Overlay Cost of Casts"],
        type = "toggle",
        test = "true",
        enable = function(trigger)
          return (not trigger.use_powertype) and trigger.unit == "player";
        end,
        reloadOptions = true
      },
      {
        name = "power",
        display = L["Power"],
        type = "number",
        init = "power",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        progressTotal = "total"
      },
      {
        name = "value",
        hidden = true,
        init = "power",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "total",
        store = true,
        test = "true"
      },
      {
        name = "stacks",
        hidden = true,
        init = "power",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "percentpower",
        display = L["Power (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100 or nil",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "deficit",
        display = L["Power Deficit"],
        type = "number",
        init = "total - value",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        progressTotal = "total"
      },
      {
        name = "maxpower",
        display = WeakAuras.newFeatureString .. L["Max Power"],
        type = "number",
        init = "total",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "name",
        display = L["Unit Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        type = "header",
        name = "unitCharacteristicsHeader",
        display = L["Unit Characteristics"],
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        type = "string",
        multiline = true,
        preamble = "local nameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        multiline = true,
        store = true,
        init = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '')",
        conditionType = "string",
        preamble = "local npcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "npcIdChecker:Check(npcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.npcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
        enable = function(trigger)
          return trigger.powertype ~= 4
        end
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "specId",
        display = L["Specialization"],
        type = "multiselect",
        init = "WeakAuras.SpecForUnit(unit)",
        values = "spec_types_all",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" or trigger.unit == "player"
        end,
        desc = L["Requires syncing the specialization via LibGroupTalents."],
      },
      {
        name = "role",
        display = L["Spec Role"],
        type = "select",
        init = "WeakAuras.LGT:GetUnitRole(unit)",
        values = "role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" or trigger.unit == "player"
        end
      },
      {
        name = "raid_role",
        display = L["Raid Role"],
        type = "select",
        init = "WeakAuras.UnitRaidRole(unit)",
        values = "raid_role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "raidMarkIndex",
        display = L["Raid Mark"],
        type = "multiselect",
        values = "raid_mark_check_type",
        store = true,
        conditionType = "select",
        init = "GetRaidTargetIndex(unit) or 0"
      },
      {
        name = "raidMark",
        display = L["Raid Mark Icon"],
        store = true,
        hidden = true,
        test = "true",
        init = "raidMarkIndex > 0 and '{rt'..raidMarkIndex..'}' or ''"
      },
      {
        type = "header",
        name = "miscellaneousHeader",
        display = L["Miscellaneous"],
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
      },
      {
        name = "includePets",
        display = L["Include Pets"],
        type = "select",
        values = "include_pets_types",
        width = WeakAuras.normalWidth,
        test = "true",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "ignoreSelf",
        display = L["Ignore Self"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsUnit(\"player\", unit)"
      },
      {
        name = "ignoreDead",
        display = L["Ignore Dead"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsDeadOrGhost(unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        name = "inRange",
        display = L["In Range"],
        desc = L["Uses UnitInRange() to check if in range. Matches default raid frames out of range behavior, which is between 25 to 40 yards depending on your class and spec."],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitInRange(unit)"
      },
      {
        name = "nameplateType",
        display = L["Hostility"],
        type = "select",
        init = "WeakAuras.GetPlayerReaction(unit)",
        values = "hostility_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.powertype ~= 4
        end
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    overlayFuncs = {
      {
        name = L["Spell Cost"],
        func = function(trigger, state)
          return "back", type(state.cost) == "number" and state.cost;
        end,
        enable = function(trigger)
          return trigger.use_showCost and (not trigger.use_powertype) and trigger.unit == "player";
        end
      },
    },
    automaticrequired = true
  },
  ["Combat Log"] = {
    type = "combatlog",
    events = {
      ["events"] = {"COMBAT_LOG_EVENT_UNFILTERED"}
    },
    init = function(trigger)
      local ret = [[
        local use_cloneId = %s;
      ]];
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    name = L["Combat Log"],
    statesParameter = "all",
    args = {
      {}, -- timestamp ignored with _ argument
      {}, -- messageType ignored with _ argument (it is checked before the dynamic function)
      -- {}, -- we don't have hideCaster
      {
        type = "header",
        name = "sourceHeader",
        display = L["Source Info"],
      },
      {
        name = "sourceGUID",
        init = "arg",
        hidden = "true",
        test = "true",
        store = true,
        display = L["Source GUID"],
        formatter = "guid",
        formatterArgs = { color = "class" }
      },
      {
        name = "sourceUnit",
        display = L["Source Unit"],
        type = "unit",
        test = "(sourceGUID or '') == (UnitGUID(%q) or '') and sourceGUID",
        values = "actual_unit_types_with_specific",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "ENVIRONMENTAL")
        end,
        store = true,
        conditionType = "select",
        conditionTest = function(state, needle, op)
          return state and state.show and ((state.sourceGUID or '') == (UnitGUID(needle) or '')) == (op == "==")
        end
      },
      {
        name = "sourceName",
        display = L["Source Name"],
        type = "string",
        multiline = true,
        init = "arg",
        store = true,
        conditionType = "string",
        preamble = "local sourceNameChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "sourceNameChecker:Check(sourceName)",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
      },
      {
        name = "sourceNpcId",
        display = L["Source NPC Id"],
        type = "string",
        multiline = true,
        init = "tostring(tonumber(string.sub(sourceGUID or '', 8, 12), 16) or '')",
        store = true,
        conditionType = "string",
        preamble = "local sourceNpcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "sourceNpcIdChecker:Check(sourceNpcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.sourceNpcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
        enable = function(trigger)
          return not (trigger.subeventPrefix == "ENVIRONMENTAL")
        end,
      },
      {
        name = "sourceFlags",
        display = L["Source Affiliation"],
        type = "select",
        values = "combatlog_flags_check_type",
        init = "arg",
        store = true,
        test = "Private.ExecEnv.CheckCombatLogFlags(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlags(state.sourceFlags, needle)  == (op == "==")
          end
        end
      },
      {
        name = "sourceFlags2",
        display = L["Source Reaction"],
        type = "select",
        values = "combatlog_flags_check_reaction",
        test = "Private.ExecEnv.CheckCombatLogFlagsReaction(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlagsReaction(state.sourceFlags, needle)  == (op == "==")
          end
        end
      },
      {
        name = "sourceFlags3",
        display = L["Source Object Type"],
        type = "select",
        values = "combatlog_flags_check_object_type",
        test = "Private.ExecEnv.CheckCombatLogFlagsObjectType(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlagsObjectType(state.sourceFlags, needle) == (op == "==")
          end
        end
      },
      -- we don't have sourceRaidFlags
      {
        type = "header",
        name = "destHeader",
        display = L["Destination Info"],
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destGUID",
        init = "arg",
        hidden = "true",
        test = "true",
        store = true,
        display = L["Destination GUID"],
        formatter = "guid",
        formatterArgs = { color = "class" }
      },
      {
        name = "destUnit",
        display = L["Destination Unit"],
        type = "unit",
        test = "(destGUID or '') == (UnitGUID(%q) or '') and destGUID",
        values = "actual_unit_types_with_specific",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
        store = true,
        conditionType = "select",
        conditionTest = function(state, needle, op)
          return state and state.show and ((state.destGUID or '') == (UnitGUID(needle) or '')) == (op == "==")
        end
      },
      {
        name = "destName",
        display = L["Destination Name"],
        type = "string",
        multiline = true,
        init = "arg",
        store = true,
        conditionType = "string",
        preamble = "local destNameChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "destNameChecker:Check(destName)",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destNpcId",
        display = L["Destination NPC Id"],
        type = "string",
        multiline = true,
        init = "tostring(tonumber(string.sub(destGUID or '', 8, 12), 16) or '')",
        store = true,
        conditionType = "string",
        preamble = "local destNpcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "destNpcIdChecker:Check(destNpcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.destNpcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      { -- destName ignore for SPELL_CAST_START
        enable = function(trigger)
          return (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end
      },
      {
        name = "destFlags",
        display = L["Destination Affiliation"],
        type = "select",
        values = "combatlog_flags_check_type",
        init = "arg",
        store = true,
        test = "Private.ExecEnv.CheckCombatLogFlags(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlags(state.destFlags, needle) == (op == "==")
          end
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destFlags2",
        display = L["Destination Reaction"],
        type = "select",
        values = "combatlog_flags_check_reaction",
        test = "Private.ExecEnv.CheckCombatLogFlagsReaction(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlagsReaction(state.destFlags, needle) == (op == "==")
          end
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destFlags3",
        display = L["Destination Object Type"],
        type = "select",
        values = "combatlog_flags_check_object_type",
        test = "Private.ExecEnv.CheckCombatLogFlagsObjectType(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle, op)
          if state and state.show then
            return Private.ExecEnv.CheckCombatLogFlagsObjectType(state.destFlags, needle) == (op == "==")
          end
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {-- destFlags ignore for SPELL_CAST_START
        enable = function(trigger)
          return (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      -- we don't have destRaidFlags
      {
        type = "header",
        name = "subeventHeader",
        display = L["Subevent Info"],
        enable = function(trigger)
          return trigger.subeventPrefix and (
            trigger.subeventPrefix == "RANGE"
            or trigger.subeventPrefix == "ENVIRONMENTAL"
            or trigger.subeventPrefix:find("DAMAGE")
            or trigger.subeventPrefix:find("SPELL"))

            or trigger.subeventSuffix and (
            -- trigger.subeventSuffix == "_ABSORBED" -- we don't have that
            trigger.subeventSuffix == "_INTERRUPT"
              or trigger.subeventSuffix == "_DISPEL"
              or trigger.subeventSuffix == "_DISPEL_FAILED"
              or trigger.subeventSuffix == "_STOLEN"
              or trigger.subeventSuffix == "_AURA_BROKEN_SPELL"
              or trigger.subeventSuffix == "_DAMAGE"
              or trigger.subeventSuffix == "_HEAL"
              or trigger.subeventSuffix == "_ENERGIZE"
              or trigger.subeventSuffix == "_DRAIN"
              or trigger.subeventSuffix == "_LEECH"
              or trigger.subeventSuffix == "_DAMAGE"
              or trigger.subeventSuffix == "_MISSED"
              or trigger.subeventSuffix == "_EXTRA_ATTACKS"
              or trigger.subeventSuffix == "_CAST_FAILED"
              or trigger.subeventSuffix:find("DOSE")
              or trigger.subeventSuffix:find("AURA"))
        end,
      },
      {
        name = "spellId",
        display = L["Spell Id"],
        init = "arg",
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        preambleGroup = "spell",
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddExact(%q)"
        },
        test = "spellChecker:Check(spellId)",
        conditionType = "number",
        type = "spell",
        showExactOption = false,
        noProgressSource = true
      },
      {
        name = "spellName",
        display = L["Spell Name"],
        type = "spell",
        noValidation = true,
        init = "arg",
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        preambleGroup = "spell",
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddName(%q)"
        },
        test = "spellChecker:Check(spellId)",
        conditionType = "string"
      },
      {
        name = "spellSchool",
        display = WeakAuras.newFeatureString .. L["Spell School"],
        type = "select",
        values = "combatlog_spell_school_types_for_ui",
        sorted = true,
        test = "spellSchool == %d",
        init = "arg",
        conditionType = "select",
        store = true,
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end
      },
      {
        name = "environmentalType",
        display = L["Environment Type"],
        type = "select",
        init = "arg",
        values = "environmental_types",
        enable = function(trigger)
          return trigger.subeventPrefix == "ENVIRONMENTAL"
        end,
        store = true,
        conditionType = "select"
      },
      {
        name = "missType",
        display = L["Miss Type"],
        type = "select",
        init = "arg",
        values = "miss_types",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_MISSED" or trigger.subeventPrefix == "DAMAGE_SHIELD_MISSED")
        end,
        conditionType = "select",
        store = true
      },
      {
        name = "extraSpellId",
        display = WeakAuras.newFeatureString .. L["Extra Spell Id"],
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end,
        test = "GetSpellInfo(%q or '') == extraSpellName",
        type = "spell",
        showExactOption = false,
        store = true,
        conditionType = "number",
        noProgressSource = true
      },
      {
        name = "extraSpellName",
        display = L["Extra Spell Name"],
        type = "spell",
        noValidation = true,
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end,
        store = true,
        conditionType = "string"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end
      }, -- extraSchool ignored with _ argument
      {
        name = "auraType",
        display = L["Aura Type"],
        type = "select",
        init = "arg",
        values = "aura_types",
        store = true,
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix:find("AURA") or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_STOLEN")
        end,
        conditionType = "select"
      },
      {
        name = "amount",
        display = L["Amount"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventSuffix == "_HEAL" or trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "overkill",
        display = L["Overkill"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "overhealing",
        display = L["Overhealing"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventSuffix == "_HEAL"
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end
      }, -- damage school ignored with _ argument
      {
        name = "resisted",
        display = L["Resisted"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "blocked",
        display = L["Blocked"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "absorbed",
        display = L["Absorbed"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT" or trigger.subeventSuffix == "_HEAL")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "critical",
        display = L["Critical"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT" or trigger.subeventSuffix == "_HEAL")
        end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "glancing",
        display = L["Glancing"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "crushing",
        display = L["Crushing"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "bool"
      },
      -- we don't have isOffHand :(
      {
        name = "number",
        display = L["Number"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_EXTRA_ATTACKS" or trigger.subeventSuffix:find("DOSE"))
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE")
        end
      }, -- unknown argument for _ENERGIZE ignored
      {
        name = "powerType",
        display = L["Power Type"],
        type = "select",
        init = "arg",
        values = "power_types",
        store = true,
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH")
        end,
        conditionType = "select"
      },
      {
        name = "extraAmount",
        display = L["Extra Amount"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH")
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix == "_CAST_FAILED"
        end
      }, -- failedType ignored with _ argument - theoretically this is not necessary because it is the last argument in the event, but it is added here for completeness
      {
        type = "header",
        name = "miscellaneousHeader",
        display = L["Miscellaneous"],
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''"
      },
      {
        hidden = true,
        name = "icon",
        init = "(spellId and select(3, GetSpellInfo(spellId))) or 'Interface\\\\Icons\\\\INV_Misc_QuestionMark'",
        store = true,
        test = "true"
      },
    },
    countEvents = true,
    delayEvents = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Cooldown Progress (Spell)"] = {
    type = "spell",
    events = {},
    loadInternalEventFunc = function(trigger, untrigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0;
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if spellName == nil then return {} end
      local events = {
        "SPELL_COOLDOWN_CHANGED:" .. spellName,
        "COOLDOWN_REMAINING_CHECK:" .. spellName,
        "WA_DELAYED_PLAYER_ENTERING_WORLD"
      };
      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end
      return events;
    end,
    force_events = "SPELL_COOLDOWN_FORCE",
    name = L["Cooldown/Charges/Count"],
    loadFunc = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0;
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      WeakAuras.WatchSpellCooldown(spellName, trigger.use_matchedRune)
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end
      local ret = {}

      local showOnCheck = "false";
      if (trigger.genericShowOn == "showOnReady") then
        showOnCheck = "startTime and startTime == 0 or gcdCooldown";
      elseif (trigger.genericShowOn == "showOnCooldown") then
        showOnCheck = "startTime and startTime > 0 and not gcdCooldown";
      elseif (trigger.genericShowOn == "showAlways") then
        showOnCheck = "startTime ~= nil";
      end

      local trackSpecificCharge = trigger.use_trackcharge and trigger.trackcharge and trigger.trackcharge ~= ""
      local track = trigger.track or "auto"
      if track == "auto" and trackSpecificCharge then
        track = "charges"
      end

      table.insert(ret, ([=[
        local spellname = %s
        local ignoreRuneCD = %s
        local showgcd = %s;
        local ignoreSpellKnown = %s;
        local track = %q
        local effectiveSpellId = spellname
        local name, _, icon = GetSpellInfo(effectiveSpellId)
        local startTime, duration, gcdCooldown, readyTime, paused = WeakAuras.GetSpellCooldown(effectiveSpellId, ignoreRuneCD, showgcd, ignoreSpellKnown, track)
        local charges, maxCharges, spellCount, chargeGainTime, chargeLostTime = WeakAuras.GetSpellCharges(effectiveSpellId, ignoreSpellKnown)
        local stacks = spellCount and spellCount > 0 and spellCount or nil;
        if (charges == nil) then
          -- Use fake charges for spells that use GetSpellCooldown
          charges = (duration == 0 or gcdCooldown) and 1 or 0;
        end
        local genericShowOn = %s
        local expirationTime = startTime and duration and startTime + duration
        state.spellname = spellname;
      ]=]):format(
        spellName,
        (trigger.use_matchedRune and "true" or "false"),
        (trigger.use_showgcd and "true" or "false"),
        (trigger.use_ignoreSpellKnown and "true" or "false"),
        track,
        showOnCheck
      ))

      if (not trackSpecificCharge) then
        table.insert(ret, [=[
          if paused then
            if not state.paused then
              state.paused = true
              state.expirationTime = nil
              state.changed = true
            end
            if state.remaining ~= startTime then
              state.remaining = startTime
              state.changed = true
            end
          else
            if (state.expirationTime ~= expirationTime) then
              state.expirationTime = expirationTime;
              state.changed = true;
            end

            if state.paused then
              state.paused = false
              state.remaining = nil
              state.changed = true
            end
          end
          if (state.duration ~= duration) then
            state.duration = duration;
            state.changed = true;
          end
          state.progressType = 'timed';
        ]=])
      else -- Tracking charges
        local trackedCharge = tonumber(trigger.trackcharge) or 1;
        table.insert(ret, ([=[
          local trackedCharge = %s
          if (charges > trackedCharge) then
            if (state.expirationTime ~= 0) then
              state.expirationTime = 0;
              state.changed = true;
            end
            if (state.duration ~= 0) then
              state.duration = 0;
              state.changed = true;
            end
            state.value = nil;
            state.total = nil;
            state.progressType = 'timed';
          else
            if duration then
              expirationTime = expirationTime + (trackedCharge - charges) * duration
            end
            if (state.expirationTime ~= expirationTime) then
              state.expirationTime = expirationTime;
              state.changed = true;
            end
            if (state.duration ~= duration) then
              state.duration = duration;
              state.changed = true;
            end
            state.value = nil;
            state.total = nil;
            state.progressType = 'timed';
          end
        ]=]):format(trackedCharge - 1))
      end
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        table.insert(ret, ([[
          local remaining = 0;
          if (not paused and expirationTime and expirationTime > 0) then
            remaining = expirationTime - GetTime();
            local remainingCheck = %s;
            if(remaining >= remainingCheck and remaining > 0) then
              local event = "COOLDOWN_REMAINING_CHECK:" .. %s
              Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck, event);
            end
          end
        ]]):format(tonumber(trigger.remaining or 0) or 0, spellName))
      end

      return table.concat(ret)
    end,
    GetNameAndIcon = GetNameAndIconForSpellName,
    statesParameter = "one",
    progressType = "timed",
    args = {
      {
      }, -- Ignore first argument (id)
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        test = "true",
        showExactOption = true,
      },
      {
        name = "extra Cooldown Progress (Spell)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.track == "charges" then
              text = L["Tracking Charge CDs"]
            elseif trigger.track == "cooldown" then
              text = L["Tracking Only Cooldown"]
            end

            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end

            if trigger.use_matchedRune then
              if text ~= "" then text = text .. "; " end
              text = text ..L["Ignore Rune CDs"]
            end

            if trigger.use_ignoreSpellKnown then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Disabled Spell Known Check"]
            end

            if trigger.genericShowOn ~= "showOnReady" and trigger.track ~= "cooldown" then
              if trigger.use_trackcharge and trigger.trackcharge and trigger.trackcharge ~= "" then
                if text ~= "" then text = text .. "; " end
                text = text .. L["Tracking Charge %i"]:format(trigger.trackcharge)
              end
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "track",
        display = L["Track Cooldowns"],
        type = "select",
        values = "cooldown_types",
        collapse = "extra Cooldown Progress (Spell)",
        test = "true",
        required = true,
        default = "auto"
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "matchedRune",
        display = L["Ignore Rune CD"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "ignoreSpellKnown",
        display = L["Disable Spell Known Check"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "trackcharge",
        display = L["Show CD of Charge"],
        type = "number",
        enable = function(trigger)
          return (trigger.genericShowOn ~= "showOnReady") and trigger.track ~= "cooldown"
        end,
        test = "true",
        noOperator = true,
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end
      },
      {
        name = "charges",
        display = L["Charges"],
        type = "number",
        store = true,
        conditionType = "number",
        progressTotal = "maxCharges"
      },
      {
        name = "spellCount",
        display = L["Spell Count"],
        type = "number",
        store = true,
        conditionType = "number"
      },
      {
        name = "stacks",
        init = "stacks",
        hidden = true,
        test = "true",
        store = true
      },
      {
        hidden  = true,
        name = "maxCharges",
        store = true,
        display = L["Max Charges"],
        conditionType = "number",
        test = "true",
      },
      {
        hidden = true,
        name = "readyTime",
        display = L["Since Ready"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        name = "chargeGainTime",
        display = L["Since Charge Gain"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        name = "chargeLostTime",
        display = L["Since Charge Lost"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        name = "effectiveSpellId",
        display = L["Effective Spell Id"],
        conditionType = "number",
        store = true,
        test = "true",
        operator_types = "only_equal"
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (state.paused or (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime())) == (needle == 1)
        end,
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        name = "spellUsable",
        display = L["Spell Usable"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
        return state and state.show and
          ((IsUsableSpell((type(state.spellname) == "number" and GetSpellInfo(state.spellname)) or state.spellname) == 1 and true or false) == (needle == 1))
        end,
        conditionEvents = AddTargetConditionEvents({
          "SPELL_UPDATE_USABLE",
          "UNIT_MANA:player", "UNIT_RAGE:player", "UNIT_FOCUS:player", "UNIT_ENERGY:player", "UNIT_RUNIC_POWER:player"
        }),
      },
      {
        name = "insufficientResources",
        display = L["Insufficient Resources"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
        return state and state.show and
          ((select(2, IsUsableSpell((type(state.spellname) == "number" and GetSpellInfo(state.spellname)) or state.spellname)) == 1 and true or false) == (needle == 1))
        end,
        conditionEvents = AddTargetConditionEvents({
          "SPELL_UPDATE_USABLE",
          "UNIT_MANA:player", "UNIT_RAGE:player", "UNIT_FOCUS:player", "UNIT_ENERGY:player", "UNIT_RUNIC_POWER:player"
        }),
      },
      {
        name = "spellInRange",
        display = L["Spell in Range"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (UnitExists('target') and state.spellname and WeakAuras.IsSpellInRange(state.spellname, 'target') == needle)
        end,
        conditionEvents = AddTargetConditionEvents({
          "WA_SPELL_RANGECHECK",
        }),
      },
      {
        hidden = true,
        test = "genericShowOn"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
    },
    hasSpellID = true,
    automaticrequired = true,
  },
  ["Cooldown Ready (Spell)"] = {
    type = "spell",
    events = {},
    loadInternalEventFunc = function(trigger, untrigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if spellName == nil then return {} end
      return { "SPELL_COOLDOWN_READY:" .. spellName }
    end,
    name = L["Cooldown Ready Event"],
    loadFunc = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      WeakAuras.WatchSpellCooldown(spellName, false)
    end,
    init = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end

      local ret = [=[
        local triggerSpellName = %s
        local name, _, icon = GetSpellInfo(triggerSpellName)
      ]=]
      return ret:format(spellName)
    end,
    GetNameAndIcon = GetNameAndIconForSpellName,
    statesParameter = "one",
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        init = "arg",
        showExactOption = true,
        test = "true"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
    },
    hasSpellID = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Charges Changed"] = {
    type = "spell",
    events = {},
    loadInternalEventFunc = function(trigger, untrigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if spellName == nil then return {} end
      return { "SPELL_CHARGES_CHANGED:" .. spellName }
    end,
    name = L["Charges Changed Event"],
    loadFunc = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      WeakAuras.WatchSpellCooldown(spellName);
    end,
    init = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if not trigger.use_exact_spellName then
        spellName = type(spellName) == "number" and GetSpellInfo(spellName) or spellName;
      end
      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end
      local ret = [=[
        local triggerSpellName = %s
        local name, _, icon = GetSpellInfo(triggerSpellName)
      ]=]
      return ret:format(spellName)
    end,
    statesParameter = "one",
    GetNameAndIcon = GetNameAndIconForSpellName,
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        init = "arg",
        showExactOption = true,
        test = "true"
      },
      {
        name = "direction",
        required = true,
        display = L["Charge gained/lost"],
        type = "select",
        values = "charges_change_type",
        init = "arg",
        test = "Private.ExecEnv.CheckChargesDirection(direction, %q)",
        store = true,
        conditionType = "select",
        conditionValues = "charges_change_condition_type";
        conditionTest = function(state, needle)
          return state and state.show and state.direction and Private.ExecEnv.CheckChargesDirection(state.direction, needle)
        end,
      },
      {
        name = "charges",
        display = L["Charges"],
        type = "number",
        init = "arg",
        store = true,
        conditionType = "number"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
    },
    hasSpellID = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Cooldown Progress (Item)"] = {
    type = "item",
    events = {},
    internal_events = function(trigger, untrigger)
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or string.format("%q", trigger.itemName or "0")
      local events = {
        "ITEM_COOLDOWN_READY:" .. itemName,
        "ITEM_COOLDOWN_CHANGED:" .. itemName,
        "ITEM_COOLDOWN_STARTED:" .. itemName,
        "COOLDOWN_REMAINING_CHECK:" .. itemName,
      }
      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end
      return events
    end,
    force_events = "ITEM_COOLDOWN_FORCE",
    name = L["Cooldown Progress (Item)"],
    loadFunc = function(trigger)
      WeakAuras.WatchItemCooldown(trigger.itemName or 0)
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or string.format("%q", trigger.itemName or "0")
      local ret = [=[
        local itemname = %s;
        local name = GetItemInfo(itemname or 0) or "Invalid"
        local icon = GetItemIcon(itemname) or ""
        local showgcd = %s
        local startTime, duration, enabled, gcdCooldown = WeakAuras.GetItemCooldown(itemname, showgcd);
        local expirationTime = startTime + duration
        local genericShowOn = %s
        state.itemname = itemname;
      ]=];
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        local ret2 = [[
          local remaining = expirationTime > 0 and (expirationTime - GetTime()) or 0;
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            local event = "COOLDOWN_REMAINING_CHECK:" .. %s
            Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck, event);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0, itemName);
      end
      return ret:format(itemName,
                        trigger.use_showgcd and "true" or "false",
                        "[[" .. (trigger.genericShowOn or "") .. "]]");
    end,
    GetNameAndIcon = function(trigger)
      local name = GetItemInfo(trigger.itemName or 0)
      local icon = GetItemIcon(trigger.itemName or 0)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        test = "true"
      },
      --[[{ maybe some day
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "itemId",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },]]
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end,
        init = "remaining"
      },
      {
        name = "extra Cooldown Progress (Item)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Item)"
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        hidden = true,
        name = "enabled",
        store = true,
        test = "true",
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime() or state.enabled == 0) == (needle == 1)
        end,
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        store = true,
        test = "true"
      },
      {
        name = "duration",
        hidden = true,
        init = "duration",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        hidden = true,
        test = "(genericShowOn == \"showOnReady\" and (startTime == 0 and enabled == 1 or gcdCooldown))" ..
        "or (genericShowOn == \"showOnCooldown\" and (startTime > 0 or enabled == 0) and not gcdCooldown) " ..
        "or (genericShowOn == \"showAlways\")"
      }
    },
    hasItemID = true,
    automaticrequired = true,
    progressType = "timed"
  },
  ["Cooldown Progress (Equipment Slot)"] = {
    type = "item",
    events = {
      ["unit_events"] = {
        ["player"] = {"UNIT_INVENTORY_CHANGED"}
      }
    },
    internal_events = function(trigger, untrigger)
      local slot = trigger.itemSlot or 0
      local events = {
        "ITEM_SLOT_COOLDOWN_STARTED:" .. slot,
        "ITEM_SLOT_COOLDOWN_CHANGED:" .. slot,
        "COOLDOWN_REMAINING_CHECK:" .. slot,
        "ITEM_SLOT_COOLDOWN_ITEM_CHANGED:" .. slot,
        "ITEM_SLOT_COOLDOWN_READY:" .. slot,
        "WA_DELAYED_PLAYER_ENTERING_WORLD"
      }

      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end

      return events
    end,
    force_events = "ITEM_COOLDOWN_FORCE",
    name = L["Cooldown Progress (Slot)"],
    loadFunc = function(trigger)
      WeakAuras.WatchItemSlotCooldown(trigger.itemSlot);
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      local ret = [[
        local showgcd = %s
        local itemSlot = %s
        local startTime, duration, enable, gcdCooldown = WeakAuras.GetItemSlotCooldown(itemSlot, showgcd)
        local expirationTime = startTime + duration
        local genericShowOn = %s
        local remaining = startTime + duration - GetTime();

        local name = ""
        local item = GetInventoryItemID("player", itemSlot or 0)
        if item then
          name = GetItemInfo(item)
        end
        local icon = GetInventoryItemTexture("player", itemSlot or 0)
        local stacks = GetInventoryItemCount("player", itemSlot or 0)
        if ((stacks == 1) and (not GetInventoryItemTexture("player", itemSlot or 0))) then
          stacks = 0
        end
      ]];
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        local ret2 = [[
          local remaining = expirationTime > 0 and (expirationTime - GetTime()) or 0;
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            local event = "COOLDOWN_REMAINING_CHECK:" .. %s
            Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck, event);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0, trigger.itemSlot or 0);
      end
      return ret:format(trigger.use_showgcd and "true" or "false",
                        trigger.itemSlot or "0",
                        "[[" .. (trigger.genericShowOn or "") .. "]]");
    end,
    GetNameAndIcon = function(trigger)
      local item = GetInventoryItemID("player", trigger.itemSlot or 0);
      local name
      if (item) then
        name = GetItemInfo(item)
      end
      local icon = GetInventoryItemTexture("player", trigger.itemSlot or 0)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "item",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },
      {
        name = "itemSlot",
        required = true,
        display = L["Equipment Slot"],
        type = "select",
        values = "item_slot_types",
        test = "true"
      },
      {
        name = "extra Cooldown Progress (Equipment Slot)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Equipment Slot)"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end,
        init = "remaining"
      },
      {
        name = "testForCooldown",
        display = L["is useable"],
        type = "toggle",
        test = "enable == 1"
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        store = true,
        test = "true"
      },
      {
        name = "duration",
        hidden = true,
        init = "duration",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      --[[{ maybe some day
        name = "itemId",
        display = L["ItemId"],
        hidden = true,
        init = "item",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },]]
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "stacks",
        display = L["Stacks"],
        init = "stacks",
        hidden = true,
        test = "true",
        store = true,
        conditionType = "number"
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime()) == (needle == 1);
        end,
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        test = "(genericShowOn == \"showOnReady\" and (startTime == 0 or gcdCooldown)) " ..
        "or (genericShowOn == \"showOnCooldown\" and startTime > 0 and not gcdCooldown) " ..
        "or (genericShowOn == \"showAlways\")"
      }
    },
    automaticrequired = true,
    hasItemID = true,
    progressType = "timed"
  },
  ["Cooldown Ready (Item)"] = {
    type = "item",
    events = {},
    internal_events = function(trigger)
      return { "ITEM_COOLDOWN_READY:" .. (trigger.itemName or 0) }
    end,
    name = L["Cooldown Ready Event (Item)"],
    loadFunc = function(trigger)
      WeakAuras.WatchItemCooldown(trigger.itemName or 0)
    end,
    init = function(trigger)
      local ret = [[
        local itemName = %s
        local name = GetItemInfo(itemName) or "Invalid"
        local icon = GetItemIcon(itemName) or ""
      ]]

      local itemName = type(trigger.itemName) == "number" and trigger.itemName or string.format("%q", trigger.itemName or "0")
      return ret:format(itemName)
    end,
    GetNameAndIcon = function(trigger)
      local name = GetItemInfo(trigger.itemName or 0)
      local icon = GetItemIcon(trigger.itemName or 0)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        init = "arg"
      },
      --[[{ maybe some day
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "itemId",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },]]
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
    },
    hasItemID = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Cooldown Ready (Equipment Slot)"] = {
    type = "item",
    events = {},
    internal_events = function(trigger)
      return {
        "ITEM_SLOT_COOLDOWN_READY:" .. (trigger.itemSlot or 0)
      }
    end,
    name = L["Cooldown Ready Event (Slot)"],
    loadFunc  = function(trigger)
      WeakAuras.WatchItemSlotCooldown(trigger.itemSlot);
    end,
    init = function(trigger)
      local ret = [[
        local itemSlot = %s
        local item = GetInventoryItemID("player", itemSlot)
        local name = ""
        if (item) then
          name = GetItemInfo(item)
        end
        local icon = GetInventoryItemTexture("player", itemSlot)
      ]]

      return ret:format(trigger.itemSlot or 0)
    end,
    GetNameAndIcon = function(trigger)
      local item = GetInventoryItemID("player", trigger.itemSlot or 0)
      local name = item and GetItemInfo(item) or nil
      local icon = GetInventoryItemTexture("player", trigger.itemSlot or 0)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemSlot",
        required = true,
        display = L["Equipment Slot"],
        type = "select",
        values = "item_slot_types",
        init = "arg"
      },
      {
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "item",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
    },
    hasItemID = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["GTFO"] = {
    type = "addons",
    events = {
      ["events"] = {"GTFO_DISPLAY"}
    },
    name = L["GTFO Alert"],
    statesParameter = "one",
    args = {
      {
        name = "alertType",
        display = L["Alert Type"],
        type = "select",
        init = "arg",
        values = "gtfo_types",
        store = true,
        conditionType = "select"
      },
    },
    timedrequired = true,
    progressType = "timed"
  },
  ["Global Cooldown"] = {
    type = "spell",
    events = {},
    internal_events = {
      "GCD_START",
      "GCD_CHANGE",
      "GCD_END",
      "GCD_UPDATE",
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "GCD_UPDATE",
    name = L["Global Cooldown"],
    loadFunc = function(trigger)
      WeakAuras.WatchGCD();
    end,
    init = function(trigger)
      local ret = [[
        local inverse = %s;
        local duration, expirationTime, name, icon = WeakAuras.GetGCDInfo()
        local hasSpellName = WeakAuras.GcdSpellName();
      ]];
      return ret:format(trigger.use_inverse and "true" or "false");
    end,
    statesParameter = "one",
    args = {
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "duration",
        hidden = true,
        init = "duration",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        test = "true",
        store = true
      },
      {
        hidden = true,
        test = "(inverse and duration == 0) or (not inverse and duration > 0 and hasSpellName)"
      }
    },
    hasSpellID = true,
    automaticrequired = true,
    progressType = "timed"
  },
  ["Swing Timer"] = {
    type = "unit",
    events = {},
    internal_events = {
      "SWING_TIMER_UPDATE"
    },
    force_events = "SWING_TIMER_UPDATE",
    name = L["Swing Timer"],
    loadFunc = function()
      WeakAuras.InitSwingTimer();
    end,
    init = function(trigger)
      local ret = [=[
        local inverse = %s;
        local hand = %q;
        local triggerRemaining = %s
        local duration, expirationTime, name, icon = WeakAuras.GetSwingTimerInfo(hand)
        local remaining = expirationTime and expirationTime - GetTime()
        local remainingCheck = not triggerRemaining or remaining and remaining %s triggerRemaining

        if triggerRemaining and remaining and remaining >= triggerRemaining and remaining > 0 then
          Private.ExecEnv.ScheduleScan(expirationTime - triggerRemaining, "SWING_TIMER_UPDATE")
        end
      ]=];
      return ret:format(
        (trigger.use_inverse and "true" or "false"),
        trigger.hand or "main",
        trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
        trigger.remaining_operator or "<"
      );
    end,
    args = {
      {
        name = "note",
        type = "description",
        display = "",
        text = function()
          return L["Note: Due to how complicated the swing timer behavior is and the lack of APIs from Blizzard, results are inaccurate in edge cases."]
        end,

      },
      {
        name = "hand",
        required = true,
        display = L["Weapon"],
        type = "select",
        values = "swing_types",
        test = "true"
      },
      {
        name = "duration",
        hidden = true,
        init = "duration",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        test = "true",
        store = true
      },
      {
        name = "name",
        hidden = true,
        init = "name",
        test = "true",
        store = true
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return not trigger.use_inverse end,
        test = "true"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "(inverse and duration == 0) or (not inverse and duration > 0)"
      },
      {
        hidden = true,
        test = "remainingCheck"
      }
    },
    automaticrequired = true,
    progressType = "timed",
    statesParameter = "one"
  },
  ["Action Usable"] = {
    type = "spell",
    events = function()
      local events = {
        "SPELL_UPDATE_USABLE",
        "ACTIONBAR_UPDATE_USABLE",
        "PLAYER_TARGET_CHANGED",
      }
      local unit_events
      if UnitPowerType("player") == 6 then
        tinsert(events, "RUNE_POWER_UPDATE")
        tinsert(events, "RUNE_TYPE_UPDATE")
        unit_events = {}
      end
      return {
        ["events"] = events,
        ["unit_events"] = unit_events or {
          ["player"] = {
          "UNIT_POWER",
          "UNIT_ENERGY",
          "UNIT_MANA",
          "UNIT_RAGE"
          }
        }
      }
    end,
    loadInternalEventFunc = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if type(trigger.spellName) == "number" then
        spellName = GetSpellInfo(spellName)
      end
      if spellName == nil then return {} end
      return { "SPELL_COOLDOWN_CHANGED:" .. spellName }
    end,
    force_events = "SPELL_UPDATE_USABLE",
    name = L["Spell Usable"],
    statesParameter = "one",
    loadFunc = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if type(trigger.spellName) == "number" then
        spellName = GetSpellInfo(spellName)
      end
      WeakAuras.WatchSpellCooldown(spellName, false);
    end,
    init = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if type(trigger.spellName) == "number" then
        spellName = GetSpellInfo(spellName) or ""
      end
      local ret = [=[
        local spellName = %s
        local effectiveSpellId = spellName
        local name, _, icon = GetSpellInfo(effectiveSpellId)
      ]=]

      if trigger.use_ignoreSpellCooldown then
        ret = ret .. [=[local active = IsUsableSpell(spellName or "")]=]
      else
        ret = ret .. [=[
        local startTime, duration, gcdCooldown, readyTime, paused = WeakAuras.GetSpellCooldown(effectiveSpellId)
        local charges, maxCharges, spellCount, chargeGainTime, chargeLostTime = WeakAuras.GetSpellCharges(effectiveSpellId)
        local stacks = spellCount and spellCount > 0 and spellCount or nil
        if (charges == nil) then
          charges = (duration == 0 or gcdCooldown) and 1 or 0;
        end
        local ready = (startTime == 0 and not paused) or charges > 0
        local active = IsUsableSpell(spellName or "") and ready
        ]=]
      end
      if(trigger.use_targetRequired) then
        ret = ret.."active = active and WeakAuras.IsSpellInRange(spellName or '', 'target')\n";
      end
      if(trigger.use_inverse) then
        ret = ret.."active = not active\n";
      end

      if (type(spellName) == "string") then
        spellName = string.format("%q", spellName)
      end

      return ret:format(spellName)
    end,
    GetNameAndIcon = GetNameAndIconForSpellName,
    args = {
      {
        name = "spellName",
        display = L["Spell"],
        required = true,
        type = "spell",
        test = "true",
        showExactOption = true,
        store = true
      },
      -- This parameter uses the IsSpellInRange API function, but it does not check spell range at all
      -- IsSpellInRange returns nil for invalid targets, 0 for out of range, 1 for in range (0 and 1 are both "positive" values)
      {
        name = "targetRequired",
        display = L["Require Valid Target"],
        type = "toggle",
        test = "true"
      },
      {
        name = "ignoreSpellCooldown",
        display = L["Ignore Spell Cooldown/Charges"],
        type = "toggle",
        test = "true"
      },
      {
        name = "charges",
        display = L["Charges"],
        type = "number",
        enable = function(trigger) return not trigger.use_inverse and not trigger.use_ignoreSpellCooldown end,
        store = true,
        conditionType = "number",
      },
      {
        name = "spellCount",
        display = L["Spell Count"],
        type = "number",
        enable = function(trigger) return not trigger.use_ignoreSpellCooldown end,
        store = true,
        conditionType = "number",
      },
      {
        hidden = true,
        name = "readyTime",
        display = L["Since Ready"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true",
        enable = function(trigger) return not trigger.use_ignoreSpellCooldown end,
      },
      {
        hidden = true,
        name = "chargeGainTime",
        display = L["Since Charge Gain"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true",
        enable = function(trigger) return not trigger.use_ignoreSpellCooldown end,
      },
      {
        hidden = true,
        name = "chargeLostTime",
        display = L["Since Charge Lost"],
        conditionType = "elapsedTimer",
        store = true,
        test = "true",
        enable = function(trigger) return not trigger.use_ignoreSpellCooldown end,
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        reloadOptions = true
      },
      {
        name = "spellInRange",
        display = L["Spell in Range"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (UnitExists('target') and state.spellName and WeakAuras.IsSpellInRange(state.spellName, 'target') == needle)
        end,
        conditionEvents = AddTargetConditionEvents({
          "WA_SPELL_RANGECHECK",
        })
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "stacks",
        display = L["Stacks"],
        hidden = true,
        init = "stacks",
        test = "true",
        store = true,
        conditionType = "number",
        enable = function(trigger) return not trigger.use_ignoreSpellCooldown end,
      },
      {
        hidden = true,
        test = "active"
      }
    },
    hasSpellID = true,
    automaticrequired = true,
    progressType = "none"
  },
  ["Talent Known"] = {
    type = "unit",
    events = {
      ["events"] = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"}
    },
    force_events = "PLAYER_TALENT_UPDATE",
    name = L["Talent Known"],
    init = function(trigger)
      local inverse = trigger.use_inverse
      local ret = {}
      if (trigger.use_talent) then
        -- Single selection
        local index = trigger.talent and trigger.talent.single;
        local tier = index and ceil(index / MAX_NUM_TALENTS)
        local column = index and ((index - 1) % MAX_NUM_TALENTS + 1)
        table.insert(ret, ([[
          local tier = %s;
          local column = %s;
          local active = false
          local name, icon, _, _, rank = GetTalentInfo(tier, column)
          if rank and rank > 0 then
            active = true;
            activeName = name;
            activeIcon = icon;
          end
        ]]):format(tier or 0, column or 0))
        if (inverse) then
          table.insert(ret, [[
            active = not (active);
          ]])
        end
      elseif (trigger.use_talent == false) then
        if (trigger.talent.multi) then
          table.insert(ret, [[
            local active = true
            local activeIcon, activeName, _
          ]])
          table.insert(ret, [[
            local tier
            local column
          ]])
          for index, value in pairs(trigger.talent.multi) do
            local tier = index and ceil(index / MAX_NUM_TALENTS)
            local column = index and ((index - 1) % MAX_NUM_TALENTS + 1)
            table.insert(ret, ([[
              if (not active) then
                tier = %s
                column = %s
                local name, icon, _, _, rank = GetTalentInfo(tier, column)
                if rank > 0 then
                  active = true;
                  activeName = name;
                  activeIcon = icon;
                end
              end
            ]]):format(tier, column))
          end
          if (inverse) then
            table.insert(ret, [[
              active = not (active);
            ]])
          end
        end
      end
      return table.concat(ret)
    end,
    args = {
      {
        name = "talent",
        display = L["Talent"],
        type = "multiselect",
        values = function(trigger)
          local class = select(2, UnitClass("player"));
          if Private.talent_types_specific and Private.talent_types_specific[class] then
            return Private.talent_types_specific[class];
          end
        end,
        test = "active",
        reloadOptions = true,
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
      },
      {
        hidden = true,
        name = "icon",
        init = "activeIcon",
        store = "true",
        test = "true"
      },
      {
        hidden = true,
        name = "name",
        init = "activeName",
        store = "true",
        test = "true"
      },
    },
    automaticrequired = true,
    statesParameter = "one",
    progressType = "none"
  },
  ["Class/Spec"] = {
    type = "unit",
    events = {},
    internal_events = {"UNIT_SPEC_CHANGED_player", "WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "UNIT_SPEC_CHANGED_player",
    name = L["Class and Specialization"],
    init = function(trigger)
      local class = select(2, UnitClass("player")) or "UNKNOWN"
      return ([[
        local specName = Private.ExecEnv.GetUnitTalentSpec("player") or "Unknown"
        local specId = Private.ExecEnv.GetSpecID("%s" .. specName)
        local specIcon = Private.ExecEnv.GetSpecIcon(specId)
      ]]):format(class)
    end,
    args = {
      {
        name = "specId",
        display = L["Class and Specialization"],
        type = "multiselect",
        values = "spec_types_all",
        store = "true",
        conditionType = "select",
      },
      {
        hidden = true,
        name = "icon",
        init = "specIcon",
        store = "true",
        test = "true"
      },
      {
        hidden = true,
        name = "name",
        init = "specName",
        store = "true",
        test = "true"
      },
    },
    automaticrequired = true,
    statesParameter = "one",
    progressType = "none"
  },
  ["Totem"] = {
    type = "spell",
    events = {
      ["events"] = {
        "PLAYER_TOTEM_UPDATE",
        "PLAYER_ENTERING_WORLD"
      }
    },
    internal_events = {
      "COOLDOWN_REMAINING_CHECK",
    },
    force_events = "PLAYER_ENTERING_WORLD",
    name = L["Totem"],
    statesParameter = "full",
    progressType = "timed",
    triggerFunction = function(trigger)
      local ret = [[return
      function (states)
        local totemType = %s;
        local triggerTotemName = %q
        local triggerTotemPattern = %q
        local triggerTotemPatternOperator = %q
        local triggerTotemIcon = %s
        local triggerTotemIconOperator = %q
        local clone = %s
        local inverse = %s
        local remainingCheck = %s

        local function checkActive(remaining)
          return remaining %s remainingCheck;
        end

        if (totemType) then -- Check a specific totem slot
          local _, totemName, startTime, duration, icon = GetTotemInfo(totemType);
          active = (startTime and startTime ~= 0);

          if not Private.ExecEnv.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator) then
            active = false;
          end

          if not Private.ExecEnv.CheckTotemIcon(icon, triggerTotemIcon, triggerTotemIconOperator) then
            active = false
          end

          if (inverse) then
            active = not active;
            if (triggerTotemName) then
              icon = select(3, GetSpellInfo(triggerTotemName));
            end
          elseif (active and remainingCheck) then
            local expirationTime = startTime and (startTime + duration) or 0;
            local remainingTime = expirationTime - GetTime()
            if (remainingTime >= remainingCheck) then
              Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck);
            end
            active = checkActive(remainingTime);
          end
          states[""] = states[""] or {}
          local state = states[""];
          state.show = active;
          state.changed = true;
          if (active) then
            state.name = totemName;
            state.totemName = totemName;
            state.progressType = "timed";
            state.duration = duration;
            state.expirationTime = startTime and (startTime + duration);
            state.icon = icon;
          end
        elseif inverse then -- inverse without a specific slot
          local found = false;
          for i = 1, 4 do
            local _, totemName, startTime, duration, icon = GetTotemInfo(i);
            if ((startTime and startTime ~= 0)
              and Private.ExecEnv.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator)
              and Private.ExecEnv.CheckTotemIcon(icon, triggerTotemIcon, triggerTotemIconOperator)
            ) then
              found = true;
            end
          end
          local cloneId = "";
          states[cloneId] = states[cloneId] or {};
          local state = states[cloneId];
          state.show = not found;
          state.changed = true;
          state.name = triggerTotemName;
          state.totemName = triggerTotemName;
          if (triggerTotemName) then
            state.icon = select(3, GetSpellInfo(triggerTotemName));
          end
        else -- check all slots
          for i = 1, 4 do
            local _, totemName, startTime, duration, icon = GetTotemInfo(i);
            active = (startTime and startTime ~= 0);

            if not Private.ExecEnv.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator)
              or not Private.ExecEnv.CheckTotemIcon(icon, triggerTotemIcon, triggerTotemIconOperator)
            then
              active = false;
            end
            if (active and remainingCheck) then
              local expirationTime = startTime and (startTime + duration) or 0;
              local remainingTime = expirationTime - GetTime()
              if (remainingTime >= remainingCheck) then
                Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck);
              end
              active = checkActive(remainingTime);
            end

            local cloneId = clone and tostring(i) or "";
            states[cloneId] = states[cloneId] or {};
            local state = states[cloneId];
            state.show = active;
            state.changed = true;
            if (active) then
              state.name = totemName;
              state.totemName = totemName;
              state.progressType = "timed";
              state.duration = duration;
              state.expirationTime = startTime and (startTime + duration);
              state.icon = icon;
            end
            if (active and not clone) then
              break;
            end
          end
        end
        return true;
      end
      ]];
      local totemName = tonumber(trigger.totemName) and GetSpellInfo(tonumber(trigger.totemName)) or trigger.totemName;
      ret = ret:format(trigger.use_totemType and tonumber(trigger.totemType) or "nil",
        trigger.use_totemName and totemName or "",
        trigger.use_totemNamePattern and trigger.totemNamePattern or "",
        trigger.use_totemNamePattern and trigger.totemNamePattern_operator or "",
        trigger.use_icon and trigger.icon or "nil",
        trigger.use_icon and trigger.icon_operator or "",
        trigger.use_clones and "true" or "false",
        trigger.use_inverse and "true" or "false",
        trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
        trigger.use_remaining and trigger.remaining_operator or "<");
      return ret;
    end,
    args = {
      {
        name = "totemType",
        display = L["Totem Number"],
        type = "select",
        values = "totem_types"
      },
      {
        name = "totemName",
        display = L["Totem Name"],
        type = "string",
        conditionType = "string",
        store = true,
        desc = L["Enter a name or a spellId"]
      },
      {
        name = "totemNamePattern",
        display = L["Totem Name Pattern Match"],
        type = "longstring",
      },
      {
        name = "icon",
        display = L["Totem Icon"],
        type = "number",
        conditionType = "number",
        operator_types = "only_equal",
        store = true,
      },
      {
        name = "clones",
        display = L["Clone per Match"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return not trigger.use_totemType end,
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return not(trigger.use_inverse) end
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return (trigger.use_totemName or trigger.use_totemNamePattern) and not trigger.use_clones end
      }
    },
    automaticrequired = true
  },
  ["Item Count"] = {
    type = "item",
    events = {
      ["events"] = {
        "BAG_UPDATE",
        "BAG_UPDATE_COOLDOWN",
        "PLAYER_ENTERING_WORLD"
      }
    },
    internal_events = {
      "ITEM_COUNT_UPDATE",
    },
    force_events = "BAG_UPDATE",
    name = L["Item Count"],
    loadFunc = function(trigger)
      if(trigger.use_includeCharges) then
        WeakAuras.RegisterItemCountWatch();
      end
    end,
    init = function(trigger)
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or string.format("%q", trigger.itemName or "0")
      local ret = [[
        local itemName = %s
        local exactSpellMatch = %s
        if not exactSpellMatch and tonumber(itemName) then
          itemName = GetItemInfo(itemName)
        end
        local count = GetItemCount(itemName or "", %s, %s);
      ]];
      return ret:format(
        itemName,
        trigger.use_exact_itemName and "true" or "nil",
        trigger.use_includeBank and "true" or "nil",
        trigger.use_includeCharges and "true" or "nil"
      )
    end,
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        showExactOption = true,
        test = "true"
      },
      --[[{ maybe some day
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "itemId",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },]]
      {
        name = "name",
        display = L["Name"],
        init = "itemName",
        type = "string",
        hidden = true,
        store = true,
        test = "true",
        conditionType = "string"
      },
      {
        name = "includeBank",
        display = L["Include Bank"],
        type = "toggle",
        test = "true"
      },
      {
        name = "includeCharges",
        display = L["Include Charges"],
        type = "toggle",
        test = "true"
      },
      {
        name = "count",
        display = L["Item Count"],
        type = "number"
      },
      {
        name = "stacks",
        display = L["Stacks"],
        init = "count",
        hidden = true,
        store = true,
        test = "true",
        conditionType = "number"
      },
      {
        name = "value",
        init = "count",
        hidden = true,
        store = true,
        test = "true",
        display = L["Progress Value"],
        conditionType = "number"
      },
      {
        name = "total",
        init = 0,
        hidden = true,
        store = true,
        test = "true",
        display = L["Progress Total"],
        conditionType = "number"
      },
      {
        name = "progressType",
        init = "'static'",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        name = "icon",
        init = "GetItemIcon(itemName or '')",
        hidden = true,
        store = true,
        test = "true"
      },
      {
        name = "name",
        init = "itemName and itemName ~= '' and GetItemInfo(itemName) or itemName",
        hidden = true,
        store = true,
        test = "true"
      },
    },
    statesParameter = "one",
    hasItemID = true,
    automaticrequired = true,
    progressType = "static"
  },
  ["Stance/Form/Aura"] = {
    type = "unit",
    events = {
      ["events"] = {
        "UPDATE_SHAPESHIFT_FORM",
        "UPDATE_SHAPESHIFT_COOLDOWN"
      }
    },
    internal_events = { "WA_DELAYED_PLAYER_ENTERING_WORLD" },
    force_events = "WA_DELAYED_PLAYER_ENTERING_WORLD",
    name = L["Stance/Form/Aura"],
    init = function(trigger)
      local inverse = trigger.use_inverse;
      local ret = {[[
        local form = GetShapeshiftForm()
        local active = false
      ]]}
      if trigger.use_form and trigger.form and trigger.form.single then
        -- Single selection
        table.insert(ret, ([[
          local trigger_form = %d
          active = form == trigger_form
        ]]):format(trigger.form.single))
        if inverse then
          table.insert(ret, [[
            active = not active
          ]])
        end
      elseif trigger.use_form == false and trigger.form and trigger.form.multi then
        for index in pairs(trigger.form.multi) do
          table.insert(ret, ([[
            if not active then
              local index = %d
              active = form == index
            end
          ]]):format(index))
        end
        if inverse then
          table.insert(ret, [[
            active = not active
          ]])
        end
      elseif trigger.use_form == nil then
        table.insert(ret, [[
          active = true
        ]])
      end
      return table.concat(ret)
    end,
    statesParameter = "one",
    args = {
      {
        name = "note",
        type = "description",
        display = "",
        text = function()
          return L["Note: This trigger internally stores the shapeshift position, and thus is incompatible with learning stances on the fly, like e.g. the Gladiator Rune."]
        end,
      },
      {
        name = "form",
        display = L["Form"],
        type = "multiselect",
        values = "form_types",
        test = "active",
        store = true,
        conditionType = "select"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return type(trigger.use_form) == "boolean" end
      },
    },
    nameFunc = function(trigger)
      local _, class = UnitClass("player");
      local name
      if(class == trigger.class) then
        local form = GetShapeshiftForm();
        if form > 0 then
          local _, name = GetShapeshiftFormInfo(form);
        else
          name = "Humanoid";
        end
        return name;
      else
        local types = WeakAuras[class:lower().."_form_types"];
        if(types) then
          return types[GetShapeshiftForm()];
        end
      end
    end,
    iconFunc = function(trigger)
      local icon = "Interface\\Icons\\Spell_Nature_WispSplode"
      local form = GetShapeshiftForm()
      if form and form > 0 then
        icon = GetShapeshiftFormInfo(form);
      end
      return icon or "Interface\\Icons\\Spell_Nature_WispSplode"
    end,
    automaticrequired = true,
    progressType = "none"
  },
  ["Weapon Enchant"] = {
    type = "item",
    events = {},
    internal_events = {
      "TENCH_UPDATE",
    },
    force_events = "TENCH_UPDATE",
    name = L["Weapon Enchant / Fishing Lure"],
    init = function(trigger)
      WeakAuras.TenchInit();

      local ret = [[
        local triggerWeaponType = %q
        local triggerName = %q
        local triggerStack = %s
        local triggerRemaining = %s
        local triggerShowOn = %q
        local expirationTime, duration, name, icon, stacks

        if triggerWeaponType == "main" then
          expirationTime, duration, name, shortenedName, icon, stacks = WeakAuras.GetMHTenchInfo()
        elseif triggerWeaponType == "off" then
          expirationTime, duration, name, shortenedName, icon, stacks = WeakAuras.GetOHTenchInfo()
        elseif triggerWeaponType == "ranged" then
          expirationTime, duration, name, shortenedName, icon, stacks = WeakAuras.GetRangeTenchInfo()
        end

        local remaining = expirationTime and expirationTime - GetTime()

        local nameCheck = triggerName == "" or name and triggerName == name or shortenedName and triggerName == shortenedName
        local stackCheck = not triggerStack or stacks and stacks %s triggerStack
        local remainingCheck = not triggerRemaining or remaining and remaining %s triggerRemaining
        local found = expirationTime and nameCheck and stackCheck and remainingCheck

        if(triggerRemaining and remaining and remaining >= triggerRemaining and remaining > 0) then
          Private.ExecEnv.ScheduleScan(expirationTime - triggerRemaining, "TENCH_UPDATE");
        end

        if not found then
          expirationTime = nil
          duration = nil
          remaining = nil
        end
      ]];

      local showOnActive = trigger.showOn == 'showOnActive' or not trigger.showOn

      return ret:format(trigger.weapon or "main",
      trigger.use_enchant and trigger.enchant or "",
      showOnActive and trigger.use_stacks and tonumber(trigger.stacks or 0) or "nil",
      showOnActive and trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
      trigger.showOn or "showOnActive",
      trigger.stacks_operator or "<",
      trigger.remaining_operator or "<")
    end,
    args = {
      {
        name = "weapon",
        display = L["Weapon"],
        type = "select",
        values = "weapon_types",
        test = "true",
        default = "main",
        required = true
      },
      {
        name = "enchant",
        display = L["Weapon Enchant"],
        desc = L["Enchant Name or ID"],
        type = "string",
        test = "true"
      },
      {
        name = "enchantID",
        hidden = true,
        test = "true",
        display = L["Enchant ID"],
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
        noProgressSource = true
      },
      {
        name = "stacks",
        display = L["Stack Count"],
        type = "number",
        conditionType = "number",
        test = "true",
        store = true
      },
      {
        name = "duration",
        hidden = true,
        init = "duration",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "duration and 'timed'",
        test = "true",
        store = true
      },
      {
        name = "name",
        hidden = true,
        init = "name",
        test = "true",
        store = true
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "enchanted",
        display = L["Enchanted"],
        hidden = true,
        init = "found == true",
        test = "true",
        store = true,
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and state.enchanted == (needle == 1)
        end,
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        test = "true",
        enable = function(trigger)
          return not trigger.showOn or trigger.showOn == "showOnActive"
        end
      },
      {
        name = "showOn",
        display = L["Show On"],
        type = "select",
        values = "weapon_enchant_types",
        test = 'true',
        default = "showOnActive",
        required = true
      },
      {
        hidden = true,
        test = "(triggerShowOn == 'showOnActive' and found) " ..
        "or (triggerShowOn == 'showOnMissing' and not found) "  ..
        "or (triggerShowOn == 'showAlways')"
      }
    },
    automaticrequired = true,
    progressType = "timed",
    statesParameter = "one"
  },
  ["Chat Message"] = {
    type = "event",
    events = function(trigger)
      if trigger.use_messageType and trigger.messageType and Private.chat_message_types[trigger.messageType] then
        local events = {trigger.messageType}
        if Private.chat_message_leader_event[trigger.messageType] then
          table.insert(events, Private.chat_message_leader_event[trigger.messageType])
        end
        if trigger.messageType == "CHAT_MSG_EMOTE" then
          table.insert(events, "CHAT_MSG_TEXT_EMOTE")
        end
        return { events = events }
      end
      return {
      ["events"] = {
        "CHAT_MSG_BATTLEGROUND",
        "CHAT_MSG_BATTLEGROUND_LEADER",
        "CHAT_MSG_BG_SYSTEM_ALLIANCE",
        "CHAT_MSG_BG_SYSTEM_HORDE",
        "CHAT_MSG_BG_SYSTEM_NEUTRAL",
        "CHAT_MSG_BN_WHISPER",
        "CHAT_MSG_CHANNEL",
        "CHAT_MSG_EMOTE",
        "CHAT_MSG_GUILD",
        "CHAT_MSG_MONSTER_EMOTE",
        "CHAT_MSG_MONSTER_PARTY",
        "CHAT_MSG_MONSTER_SAY",
        "CHAT_MSG_MONSTER_WHISPER",
        "CHAT_MSG_MONSTER_YELL",
        "CHAT_MSG_OFFICER",
        "CHAT_MSG_PARTY",
        "CHAT_MSG_PARTY_LEADER",
        "CHAT_MSG_RAID",
        "CHAT_MSG_RAID_LEADER",
        "CHAT_MSG_RAID_BOSS_EMOTE",
        "CHAT_MSG_RAID_BOSS_WHISPER",
        "CHAT_MSG_RAID_WARNING",
        "CHAT_MSG_SAY",
        "CHAT_MSG_WHISPER",
        "CHAT_MSG_YELL",
        "CHAT_MSG_SYSTEM",
        "CHAT_MSG_TEXT_EMOTE",
        "CHAT_MSG_LOOT",
      }
    }
    end,
    name = L["Chat Message"],
    init = function(trigger)
      local ret = [[
        if (event:find('LEADER')) then
          event = event:sub(1, -8);
        end
        if (event == 'CHAT_MSG_TEXT_EMOTE') then
          event = 'CHAT_MSG_EMOTE';
        end
        local use_cloneId = %s;
      ]];
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    statesParameter = "all",
    args = {
      {
        name = "messageType",
        display = L["Message Type"],
        type = "select",
        values = "chat_message_types",
        sorted = true,
        test = "event == %q",
      },
      {
        name = "message",
        display = L["Message"],
        init = "arg",
        type = "longstring",
        canBeCaseInsensitive = true,
        store = true,
        conditionType = "string",
      },
      {
        name = "sourceName",
        display = L["Source Name"],
        init = "arg",
        type = "string",
        store = true,
        conditionType = "string",
      },
      { -- language Name
      },
      { -- Channel Name
      },
      {
        name = "destName",
        display = L["Destination Name"],
        init = "arg",
        type = "string",
        store = true,
        conditionType = "string",
      },
      {
        -- flags
      },
      {
        -- zone Channel id
      },
      {
        -- channel index
      },
      {
        -- channel base name
      },
      {
        -- language id
      },
      {
        -- line id
      },
      {
        name = "sourceGUID",
        display = L["Source GUID"],
        init = "arg",
        store = true,
        hidden = true,
        test = "true",
        formatter = "guid",
        formatterArgs = { color = "class" }
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''",
        reloadOptions = true
      },
    },
    countEvents = true,
    delayEvents = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Spell Cast Succeeded"] = {
    type = "event",
    events = function(trigger)
      local result = {}
      local unit = trigger.unit
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_SUCCEEDED")
      return result
    end,
    name = L["Spell Cast Succeeded"],
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        init = "arg",
        display = L["Caster Unit"],
        type = "unit",
        test = "true",
        values = "actual_unit_types_cast",
        store = true,
        conditionType = "select",
        conditionTest = function(state, needle, op)
          return state and state.show and (UnitIsUnit(needle, state.unit or '') == (op == "=="))
        end
      },
      { -- castGUID
      },
      {
        name = "spellNames",
        init = "arg",
        display = L["Name(s)"],
        type = "spell",
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddName(%q)"
        },
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        preambleGroup = "spell",
        test = "spellChecker:Check(spellNames)",
        noValidation = true,
      },
      {
        name = "spellId",
        display = L["Exact Spell ID(s)"],
        type = "spell",
        init = "spellNames",
        store = true,
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddName(%q)"
        },
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        preambleGroup = "spell",
        test = "spellChecker:CheckName(spellNames)",
        --conditionType = "number", -- Disabled because input would be string and would break imports to retail
        noProgressSource = true
      },
      {
        name = "icon",
        hidden = true,
        init = "(spellId and select(3, GetSpellInfo(spellId))) or 'Interface\\\\Icons\\\\INV_Misc_QuestionMark'",
        store = true,
        test = "true"
      },
      {
        name = "name",
        hidden = true,
        init = "GetSpellInfo(spellId or 0)",
        store = true,
        test = "true"
      },
    },
    countEvents = true,
    delayEvents = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Ready Check"] = {
    type = "event",
    events = {
      ["events"] = {"READY_CHECK"}
    },
    name = L["Ready Check"],
    args = {},
    statesParameter = "one",
    delayEvents = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Combat Events"] = {
    type = "event",
    events = {
      ["events"] = {
        "PLAYER_REGEN_ENABLED",
        "PLAYER_REGEN_DISABLED"
      }
    },
    name = L["Entering/Leaving Combat"],
    args = {
      {
        name = "eventtype",
        required = true,
        display = L["Type"],
        type = "select",
        values = "combat_event_type",
        test = "event == %q"
      }
    },
    statesParameter = "one",
    countEvents = true,
    delayEvents = true,
    timedrequired = true,
    progressType = "timed"
  },
  ["Death Knight Rune"] = {
    type = "unit",
    events = {
      ["events"] = {
        "RUNE_POWER_UPDATE",
        "RUNE_TYPE_UPDATE"
      }
    },
    internal_events = {
      "RUNE_COOLDOWN_READY",
      "RUNE_COOLDOWN_CHANGED",
      "RUNE_COOLDOWN_STARTED",
      "COOLDOWN_REMAINING_CHECK",
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "RUNE_COOLDOWN_FORCE",
    name = L["Death Knight Rune"],
    loadFunc = function(trigger)
      trigger.rune = trigger.rune or 0;
      if (trigger.use_rune) then
        WeakAuras.WatchRuneCooldown(trigger.rune);
      else
        for i = 1, 6 do
          WeakAuras.WatchRuneCooldown(i);
        end
      end
    end,
    init = function(trigger)
      trigger.rune = trigger.rune or 0;
      WeakAuras.WatchRuneCooldown(trigger.rune);
      local ret = [[
        local rune = %s;
        local genericShowOn = %s
        local includeDeathRunes = %s;
        local startTime, duration = WeakAuras.GetRuneCooldown(rune);
        local numBloodRunes = 0;
        local numUnholyRunes = 0;
        local numFrostRunes = 0;
        local numDeathRunes = 0;
        local numRunes = 0;
        local isDeathRune = GetRuneType(rune) == 4
        for index = 1, 6 do
          local startTime = GetRuneCooldown(index);
          if startTime == 0 then
            numRunes = numRunes + 1;
            local runeType = GetRuneType(index)
            if runeType == 1 then
              numBloodRunes = numBloodRunes + 1;
            elseif runeType == 2 then
              numFrostRunes = numFrostRunes + 1;
            elseif runeType == 3 then
              numUnholyRunes = numUnholyRunes + 1;
            elseif runeType == 4 then
              numDeathRunes = numDeathRunes + 1;
            end
          end
        end
        if includeDeathRunes then
          numBloodRunes  = numBloodRunes  + numDeathRunes;
          numUnholyRunes = numUnholyRunes + numDeathRunes;
          numFrostRunes  = numFrostRunes  + numDeathRunes;
        end
      ]];
      if trigger.use_remaining then
        local ret2 = [[
          local expirationTime = startTime + duration
          local remaining = expirationTime - GetTime();
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            Private.ExecEnv.ScheduleScan(expirationTime - remainingCheck);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0);
      end
      return ret:format(
        trigger.rune,
        "[[" .. (trigger.genericShowOn or "") .. "]]",
        (trigger.use_includeDeathRunes and "true" or "false")
      );
    end,
    statesParameter = "one",
    args = {
      {
        name = "rune",
        display = L["Rune"],
        type = "select",
        values = "rune_specific_types",
        test = "(genericShowOn == \"showOnReady\" and (startTime == 0)) " ..
        "or (genericShowOn == \"showOnCooldown\" and startTime > 0) " ..
        "or (genericShowOn == \"showAlways\")",
        reloadOptions = true
      },
      {
        name = "isDeathRune",
        display = L["Is Death Rune"],
        type = "tristate",
        init = "isDeathRune",
        store = true,
        conditionType = "bool",
        enable = function(trigger) return trigger.use_rune end,
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return trigger.use_rune and not(trigger.genericShowOn == "showOnReady") end
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        enable = function(trigger) return trigger.use_rune end,
        required = true
      },
      {
        name = "runesCount",
        display = L["Rune Count"],
        type = "number",
        init = "numRunes",
        enable = function(trigger) return not trigger.use_rune end
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (state.expirationTime and state.expirationTime > GetTime()) == (needle == 1)
        end,
        enable = function(trigger) return trigger.use_rune end
      },
      {
        name = "bloodRunes",
        display = L["Rune Count - Blood"],
        type = "number",
        init = "numBloodRunes",
        store = true,
        conditionType = "number",
        enable = function(trigger) return not trigger.use_rune end,
      },
      {
        name = "frostRunes",
        display = L["Rune Count - Frost"],
        type = "number",
        init = "numFrostRunes",
        store = true,
        conditionType = "number",
        enable = function(trigger) return not trigger.use_rune end,
      },
      {
        name = "unholyRunes",
        display = L["Rune Count - Unholy"],
        type = "number",
        init = "numUnholyRunes",
        store = true,
        conditionType = "number",
        enable = function(trigger) return not trigger.use_rune end,
      },
      {
        name = "includeDeathRunes",
        display = L["Include Death Runes"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return trigger.use_bloodRunes or trigger.use_unholyRunes or trigger.use_frostRunes end,
      },
    },
    durationFunc = function(trigger)
      if trigger.use_rune then
        local startTime, duration = WeakAuras.GetRuneCooldown(trigger.rune)
        return duration, startTime + duration
      else
        local numRunes = 0;
        for index = 1, 6 do
          if GetRuneCooldown(index) == 0 then
            numRunes = numRunes + 1;
          end
        end
        return numRunes, 6, true;
      end
    end,
    stacksFunc = function(trigger)
      local numRunes = 0;
      for index = 1, 6 do
        if GetRuneCooldown(index) == 0 then
          numRunes = numRunes  + 1;
        end
      end
      return numRunes;
    end,
    nameFunc = function(trigger)
      local runeNames = { L["Blood"], L["Frost"], L["Unholy"], L["Death"] }
      return runeNames[GetRuneType(trigger.rune)];
    end,
    iconFunc = function(trigger)
      if trigger.rune then
        local runeIcons = {
          "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
          "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
          "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
          "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death"
        };
        return runeIcons[GetRuneType(trigger.rune)];
      end
    end,
    automaticrequired = true,
    progressType = function(trigger)
      if trigger.use_rune then
        return "timed"
      else
        return "static"
      end
    end
  },
  ["Item Equipped"] = {
    type = "item",
    events = {
      ["events"] = {
        "PLAYER_EQUIPMENT_CHANGED",
      },
      ["unit_events"] = {
        ["player"] = {"UNIT_INVENTORY_CHANGED"}
      }
    },
    internal_events = { "WA_DELAYED_PLAYER_ENTERING_WORLD", },
    force_events = "UNIT_INVENTORY_CHANGED",
    name = L["Item Equipped"],
    init = function(trigger)
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or string.format("%q", trigger.itemName or "0")

      local ret = [[
        local inverse = %s
        local triggerItemName = %s
        local icon = GetItemIcon(triggerItemName) or ""
        local itemSlot = %s
      ]]

      ret = ret ..[[
        local itemName = triggerItemName
        local equipped = WeakAuras.CheckForItemEquipped(triggerItemName, itemSlot)
      ]]

      return ret:format(trigger.use_inverse and "true" or "false", itemName, trigger.use_itemSlot and trigger.itemSlot or "nil");
    end,
    GetNameAndIcon = function(trigger)
      local name = GetItemInfo(trigger.itemName or 0)
      local icon = GetItemIcon(trigger.itemName or 0)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemName",
        display = L["Item"],
        type = "item",
        required = true,
        test = "true",
        only_exact = true
      },
      --[[{ maybe some day
        name = "itemId",
        display = WeakAuras.newFeatureString .. L["ItemId"],
        hidden = true,
        init = "itemId",
        test = "true",
        store = true,
        conditionType = "number",
        operator_types = "only_equal",
      },]]
      {
        name = "itemSlot",
        display = WeakAuras.newFeatureString .. L["Item Slot"],
        type = "select",
        values = "item_slot_types",
        test = "true",
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "itemName",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        hidden = true,
        test = "(inverse and not equipped) or (equipped and not inverse)"
      }
    },
    hasItemID = true,
    automaticrequired = true,
    progressType = "none"
  },
  ["Equipment Set"] = {
    type = "item",
    events = {
      ["events"] = {
        "PLAYER_EQUIPMENT_CHANGED",
        "WEAR_EQUIPMENT_SET",
        "EQUIPMENT_SETS_CHANGED",
        "EQUIPMENT_SWAP_FINISHED",
      }
    },
    internal_events = {"WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "PLAYER_EQUIPMENT_CHANGED",
    name = L["Equipment Set Equipped"],
    init = function(trigger)
      trigger.itemSetName = trigger.itemSetName or "";
      local itemSetName = type(trigger.itemSetName) == "string" and ("[=[" .. trigger.itemSetName .. "]=]") or "nil";

      local ret = [[
        local useItemSetName = %s;
        local triggerItemSetName = %s;
        local inverse = %s;
        local partial = %s;

        local itemSetName, icon, numEquipped, numItems = WeakAuras.GetEquipmentSetInfo(useItemSetName and triggerItemSetName or nil, partial);
      ]];

      return ret:format(trigger.use_itemSetName and "true" or "false", itemSetName, trigger.use_inverse and "true" or "false", trigger.use_partial and "true" or "false");
    end,
    GetNameAndIcon = function(trigger)
      local name, icon = WeakAuras.GetEquipmentSetInfo(trigger.use_itemSetName and trigger.itemSetName or nil, true)
      return name, icon
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemSetName",
        display = L["Equipment Set"],
        type = "string",
        test = "true",
        store = true,
        conditionType = "string",
        init = "itemSetName"
      },
      {
        name = "partial",
        display = L["Allow partial matches"],
        type = "toggle",
        test = "true"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "value",
        init = "numEquipped",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        name = "total",
        init = "numItems",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        name = "progressType",
        init = "'static'",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        hidden = true,
        test = "(inverse and itemSetName == nil) or (not inverse and itemSetName)"
      }
    },
    hasItemID = true,
    automaticrequired = true,
    progressType = "static"
  },
  ["Threat Situation"] = {
    type = "unit",
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      if unit and unit ~= "none" then
        AddUnitEventForEvents(result, unit, "UNIT_THREAT_LIST_UPDATE")
      else
        AddUnitEventForEvents(result, "player", "UNIT_THREAT_SITUATION_UPDATE")
      end
      return result
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      if unit and unit ~= "none" then
        AddUnitChangeInternalEvents(unit, result)
      end
      return result
    end,
    loadFunc = function(trigger)
      local unit = trigger.unit
      if unit and unit ~= "none" then
        AddWatchedUnits(unit)
      end
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    name = L["Threat Situation"],
    init = function(trigger)
      trigger.unit = trigger.unit or "target";
      local ret = [[
        unit = string.lower(unit)
        local name = UnitName(unit, false) or (unit == "none" and "Unknown")
        local ok = true
        local aggro, status, threatpct, rawthreatpct, threatvalue, threattotal
        if unit and unit ~= "none" then
          aggro, status, threatpct, rawthreatpct, threatvalue = WeakAuras.UnitDetailedThreatSituation('player', unit)
          threattotal = (threatvalue or 0) * 100 / (threatpct ~= 0 and threatpct or 1)
        else
          status = UnitThreatSituation('player')
          aggro = status == 2 or status == 3
          threatpct, rawthreatpct, threatvalue, threattotal = 100, 100, 0, 100
        end
      ]];
      return ret .. unitHelperFunctions.SpecificUnitCheck(trigger);
    end,
    progressType = "static",
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        display = L["Unit"],
        required = true,
        type = "unit",
        init = "arg",
        values = "threat_unit_types",
        test = "true",
        store = true,
        default = "target"
      },
      {
        name = "status",
        display = L["Status"],
        type = "select",
        values = "unit_threat_situation_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "aggro",
        display = L["Aggro"],
        type = "tristate",
        store = true,
        conditionType = "bool",
      },
      {
        name = "threatpct",
        display = L["Threat Percent"],
        desc = L["Your threat on the mob as a percentage of the amount required to pull aggro. Will pull aggro at 100."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.unit ~= "none" end,
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "rawthreatpct",
        display = L["Raw Threat Percent"],
        desc = L["Your threat as a percentage of the tank's current threat."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.unit ~= "none" end,
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "threatvalue",
        display = L["Threat Value"],
        desc = L["Your total threat on the mob."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.unit ~= "none" end,
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        type = "header",
        name = "unitCharacteristicsHeader",
        display = L["Unit Characteristics"],
      },
      {
        name = "name",
        display = L["Unit Name"],
        type = "string",
        store = true,
        multiline = true,
        preamble = "local nameChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "nameChecker:Check(name)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."]
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        multiline = true,
        store = true,
        init = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '')",
        conditionType = "string",
        preamble = "local npcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "npcIdChecker:Check(npcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.npcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."]
      },
      {
        name = "value",
        hidden = true,
        init = "threatvalue",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "threattotal",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        test = "status ~= nil and ok"
      },
      {
        hidden = true,
        test = "((WeakAuras.UnitExistsFixed(unit, false) or unit == 'none') and specificUnitCheck)"
      }
    },
    automaticrequired = true
  },
  ["Crowd Controlled"] = {
    type = "unit",
    events = {
      ["unit_events"] = {
        ["player"] = {"UNIT_AURA"}
      }
    },
    force_events = "UNIT_AURA",
    name = L["Crowd Controlled"],
    args = {
      {
        name = "controlled",
        display = L["Crowd Controlled"],
        type = "tristate",
        init = "not HasFullControl()"
      }
    },
    automaticrequired = true,
  },
  ["Cast"] = {
    type = "unit",
    events = function(trigger)
      local result = {}
      local unit = trigger.unit
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_START")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_DELAYED")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_STOP")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_START")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_UPDATE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_STOP")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_INTERRUPTIBLE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_INTERRUPTED")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      AddUnitEventForEvents(result, unit, "UNIT_TARGET")
      return result
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      if unit == "nameplate" and trigger.use_onUpdateUnitTarget then
        tinsert(result, "WA_UNIT_TARGET_NAME_PLATE")
      end
      AddRemainingCastInternalEvents(unit, result)
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddUnitChangeInternalEvents(unit, result, includePets)
      if includePets ~= "PetsOnly" then
        AddUnitRoleChangeInternalEvents(unit, result)
      end
      return result
    end,
    loadFunc = function(trigger)
      if trigger.use_showLatency and trigger.unit == "player" then
        WeakAuras.WatchForCastLatency()
      end
      if trigger.unit == "nameplate" and trigger.use_onUpdateUnitTarget then
        WeakAuras.WatchForNameplateTargetChange()
      end
      local includePets = trigger.use_includePets == true and trigger.includePets or nil
      AddWatchedUnits(trigger.unit, includePets)
    end,
    force_events = unitHelperFunctions.UnitChangedForceEventsWithPets,
    progressType = "timed",
    name = L["Cast"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = [=[
        unit = string.lower(unit)
        local destUnit = unit .. '-target'
        local sourceName, sourceRealm = WeakAuras.UnitNameWithRealm(unit)
        local destName, destRealm = WeakAuras.UnitNameWithRealm(destUnit)
        destName = destName or ""
        destRealm = destRealm or ""
        local smart = %s
        local remainingCheck = %s
        local inverseTrigger = %s

        local show, expirationTime, castType, spell, icon, startTime, endTime, interruptible, remaining, _

        spell, _, _, icon, startTime, endTime, _, _, interruptible = UnitCastingInfo(unit)
        if spell then
          castType = "cast"
        else
          spell, _, _, icon, startTime, endTime, _, interruptible = UnitChannelInfo(unit)
          if spell then
            castType = "channel"
          end
        end
        interruptible = not interruptible
        expirationTime = endTime and endTime > 0 and (endTime / 1000) or 0
        remaining = expirationTime - GetTime()

        if remainingCheck and remaining >= remainingCheck and remaining > 0 then
          Private.ExecEnv.ScheduleCastCheck(expirationTime - remainingCheck, unit)
        end
      ]=];
      ret = ret:format(trigger.unit == "group" and "true" or "false",
                        trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
                        trigger.use_inverse and "true" or "false");

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = function(trigger)
          if trigger.use_inverse then
            return Private.actual_unit_types_with_specific
          else
            return Private.actual_unit_types_cast
          end
        end,
        desc = Private.actual_unit_types_cast_tooltip,
        test = "true",
        store = true
      },
      {
        name = "spellNames",
        display = L["Name(s)"],
        type = "spell",
        enable = function(trigger) return not trigger.use_inverse end,
        preambleGroup = "spell",
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddName(%q)"
        },
        test = "spellChecker:CheckName(spell)",
        noValidation = true,
      },
      {
        name = "spellIds",
        display = L["Exact Spell ID(s)"],
        type = "spell",
        enable = function(trigger) return not trigger.use_inverse end,
        preambleGroup = "spell",
        preamble = "local spellChecker = Private.ExecEnv.CreateSpellChecker()",
        multiEntry = {
          operator = "preamble",
          preambleAdd = "spellChecker:AddName(GetSpellInfo(%q))"
        },
        test = "spellChecker:CheckName(spell)",
      },
      {
        name = "spellId",
        display = L["Spell ID"],
        conditionType = "number",
        store = true,
        test = "true",
        hidden = true,
        noProgressSource = true
      },
      {
        name = "spell",
        display = L["Spellname"],
        type = "string",
        conditionType = "string",
        store = true,
        test = "true",
        hidden = true
      },
      {
        name = "castType",
        display = L["Cast Type"],
        type = "select",
        values = "cast_types",
        enable = function(trigger) return not trigger.use_inverse end,
        store = true,
        conditionType = "select"
      },
      {
        name = "interruptible",
        display = L["Interruptible"],
        type = "tristate",
        enable = function(trigger) return not trigger.use_inverse end,
        store = true,
        conditionType = "bool",
      },

      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "name",
        hidden = true,
        init = "spell",
        test = "true",
        store = true
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        name = "duration",
        hidden = true,
        init = "endTime and startTime and (endTime - startTime)/1000 or 0",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        test = "true",
        store = true
      },
      {
        name = "inverse",
        hidden = true,
        init = "castType == 'cast'",
        test = "true",
        store = true
      },
      {
        name = "autoHide",
        hidden = true,
        init = "true",
        test = "true",
        store = true,
        enable = function(trigger)
          return not trigger.use_inverse
        end
      },
      {
        type = "header",
        name = "unitCharacteristicsHeader",
        display = L["Unit Characteristics"],
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        multiline = true,
        store = true,
        init = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '')",
        conditionType = "string",
        preamble = "local npcIdChecker = Private.ExecEnv.ParseStringCheck(%q)",
        test = "npcIdChecker:Check(npcId)",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseStringCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.npcId)
        end,
        operator_types = "none",
        desc = L["Supports multiple entries, separated by commas. Prefix with '-' for negation."],
        enable = function(trigger)
          return not trigger.use_inverse
        end,
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return not trigger.use_inverse
        end
      },
      {
        name = "role",
        display = L["Spec Role"],
        type = "select",
        init = "WeakAuras.LGT:GetUnitRole(unit)",
        values = "role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
                 or trigger.unit == "player" and not trigger.use_inverse
        end
      },
      {
        name = "raid_role",
        display = L["Raid Role"],
        type = "select",
        init = "WeakAuras.UnitRaidRole(unit)",
        values = "raid_role_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party" and not trigger.use_inverse
        end
      },
      {
        name = "raidMarkIndex",
        display = L["Raid Mark"],
        type = "multiselect",
        values = "raid_mark_check_type",
        store = true,
        conditionType = "select",
        init = "GetRaidTargetIndex(unit) or 0"
      },
      {
        name = "raidMark",
        display = L["Raid Mark Icon"],
        store = true,
        hidden = true,
        test = "true",
        init = "raidMarkIndex > 0 and '{rt'..raidMarkIndex..'}' or ''"
      },
      {
        name = "nameplateType",
        display = L["Hostility"],
        type = "select",
        init = "WeakAuras.GetPlayerReaction(unit)",
        values = "hostility_types",
        store = true,
        conditionType = "select",
      },
      {
        name = "sourceUnit",
        init = "unit",
        display = L["Caster"],
        type = "unit",
        values = "actual_unit_types_with_specific",
        conditionType = "unit",
        conditionTest = function(state, unit, op)
          return state and state.show and state.unit and (UnitIsUnit(state.sourceUnit, unit) == (op == "=="))
        end,
        store = true,
        hidden = true,
        enable = function(trigger) return not trigger.use_inverse end,
        test = "true"
      },
      {
        name = "sourceName",
        display = L["Caster Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "sourceRealm",
        display = L["Caster Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "sourceNameRealm",
        display = L["Source Unit Name/Realm"],
        type = "string",
        multiline = true,
        preamble = "local sourceNameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
        test = "sourceNameRealmChecker:Check(sourceName, sourceRealm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.sourceName, state.sourceRealm)
        end,
        operator_types = "none",
        enable = function(trigger) return not trigger.use_inverse end,
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "destUnit",
        display = L["Caster's Target"],
        type = "unit",
        values = "actual_unit_types_with_specific",
        conditionType = "unit",
        conditionTest = function(state, unit, op)
          return state and state.show and state.destUnit and (UnitIsUnit(state.destUnit, unit) == (op == "=="))
        end,
        store = true,
        enable = function(trigger) return not trigger.use_inverse end,
        test = "UnitIsUnit(destUnit, [[%s]])"
      },
      {
        name = "destName",
        display = L["Name of Caster's Target"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "destRealm",
        display = L["Realm of Caster's Target"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "destNameRealm",
        display = L["Name/Realm of Caster's Target"],
        type = "string",
        multiline = true,
        preamble = "local destNameRealmChecker = Private.ExecEnv.ParseNameCheck(%q)",
        test = "destNameRealmChecker:Check(destName, destRealm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.destName, state.destRealm)
        end,
        operator_types = "none",
        enable = function(trigger) return not trigger.use_inverse end,
        desc = constants.nameRealmFilterDesc,
      },
      {
        type = "header",
        name = "miscellaneousHeader",
        display = L["Miscellaneous"],
      },
      {
        name = "showLatency",
        display = L["Overlay Latency"],
        type = "toggle",
        test = "true",
        enable = function(trigger)
          return trigger.unit == "player" and not trigger.use_inverse
        end,
        reloadOptions = true
      },
      {
        name = "includePets",
        display = L["Include Pets"],
        type = "select",
        values = "include_pets_types",
        width = WeakAuras.normalWidth,
        test = "true",
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end
      },
      {
        name = "ignoreSelf",
        display = L["Ignore Self"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "nameplate" or trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsUnit(\"player\", unit)"
      },
      {
        name = "onUpdateUnitTarget",
        display = WeakAuras.newFeatureString .. L["Advanced Caster's Target Check"],
        desc = L["Check nameplate's target every 0.2s"],
        type = "toggle",
        test = "true",
        enable = function(trigger)
          return trigger.unit == "nameplate"
        end
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        reloadOptions = true
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and ((not inverseTrigger and spell) or (inverseTrigger and not spell)) and specificUnitCheck"
      }
    },
    overlayFuncs = {
      {
        name = L["Latency"],
        func = function(trigger, state)
          local latency = WeakAuras.GetCastLatency()
          if not latency then return 0, 0 end
          return 0, latency
        end,
        enable = function(trigger)
          return trigger.use_showLatency and trigger.unit == "player"
        end
      },
    },
    GetNameAndIcon = function(trigger)
      local name, icon, spellId, _
      if trigger.use_spellNames and type(trigger.spellNames) == "table" then
        for _, spellName in ipairs(trigger.spellNames) do
          spellId = WeakAuras.SafeToNumber(spellName)
          if spellId then
            name, _, icon = GetSpellInfo(spellName)
            if name and icon then
              return name, icon
            end
          elseif not tonumber(spellName) then
            name, _, icon = GetSpellInfo(spellName)
            if name and icon then
              return name, icon
            end
          end
        end
      end
      if trigger.use_spellIds and type(trigger.spellIds) == "table" then
        for _, spellIdString in ipairs(trigger.spellIds) do
          spellId = WeakAuras.SafeToNumber(spellIdString)
          if spellId then
            name, _, icon = GetSpellInfo(spellIdString)
            if name and icon then
              return name, icon
            end
          end
        end
      end
    end,
    automaticrequired = true,
  },
  ["Character Stats"] = {
    type = "unit",
    name = L["Character Stats"],
    events = {
      ["events"] = {
        "COMBAT_RATING_UPDATE",
        "PLAYER_TARGET_CHANGED"
      },
      ["unit_events"] = {
        ["player"] = {"UNIT_STATS", "UNIT_ATTACK_POWER", "UNIT_AURA", "PLAYER_DAMAGE_DONE_MODS", "UNIT_RESISTANCES"}
      }
    },
    internal_events = function(trigger, untrigger)
      local events = { "WA_DELAYED_PLAYER_ENTERING_WORLD" }
      if trigger.use_moveSpeed then
        tinsert(events, "PLAYER_MOVE_SPEED_UPDATE")
      end
      return events
    end,
    loadFunc = function(trigger)
      if trigger.use_moveSpeed then
        WeakAuras.WatchForPlayerMoving()
      end
    end,
    force_events = "CONDITIONS_CHECK",
    statesParameter = "one",
    args = {
      {
        type = "header",
        name = "primaryStatsHeader",
        display = L["Primary Stats"],
      },
      {
        name = "strength",
        display = L["Strength"],
        type = "number",
        init = "UnitStat('player', 1)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "agility",
        display = L["Agility"],
        type = "number",
        init = "UnitStat('player', 2)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "stamina",
        display = L["Stamina"],
        type = "number",
        init = "UnitStat('player', 3)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "intellect",
        display = L["Intellect"],
        type = "number",
        init = "UnitStat('player', 4)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "spirit",
        display = L["Spirit"],
        type = "number",
        init = "UnitStat('player', 5)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        type = "header",
        name = "secondaryStatsHeader",
        display = L["Secondary Stats"],
      },
      {
        name = "criticalrating",
        display = L["Critical Rating"],
        type = "number",
        init = "max(GetCombatRating(CR_CRIT_MELEE), GetCombatRating(CR_CRIT_RANGED), GetCombatRating(CR_CRIT_SPELL))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "criticalpercent",
        display = L["Critical (%)"],
        type = "number",
        init = "WeakAuras.GetCritChance()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "hitrating",
        display = L["Hit Rating"],
        type = "number",
        init = "max(GetCombatRating(CR_HIT_MELEE), GetCombatRating(CR_HIT_RANGED), GetCombatRating(CR_HIT_SPELL))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "hitpercent",
        display = L["Hit (%)"],
        type = "number",
        init = "WeakAuras.GetHitChance()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "hasterating",
        display = L["Haste Rating"],
        type = "number",
        init = "max(GetCombatRating(CR_HASTE_SPELL), GetCombatRating(CR_HASTE_MELEE), GetCombatRating(CR_HASTE_RANGED))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "hastepercent",
        display = L["Haste (%)"],
        type = "number",
        init = "max(GetCombatRatingBonus(CR_HASTE_SPELL), GetCombatRatingBonus(CR_HASTE_MELEE), GetCombatRatingBonus(CR_HASTE_RANGED))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "expertiserating",
        display = L["Expertise Rating"],
        type = "number",
        init = "GetCombatRating(CR_EXPERTISE)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "expertisebonus",
        display = L["Expertise Bonus"],
        type = "number",
        init = "GetCombatRatingBonus(CR_EXPERTISE)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "armorpenrating",
        display = L["Armor Peneration Rating"],
        type = "number",
        init = "GetCombatRating(CR_ARMOR_PENETRATION)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "armorpenpercent",
        display = L["Armor Peneration (%)"],
        type = "number",
        init = "GetArmorPenetration()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "spellpenpercent",
        display = L["Spell Peneration (%)"],
        type = "number",
        init = "GetSpellPenetration()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "resiliencerating",
        display = L["Resilience Rating"],
        type = "number",
        init = "GetCombatRating(CR_CRIT_TAKEN_MELEE)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "resiliencepercent",
        display = L["Resilience (%)"],
        type = "number",
        init = "GetCombatRatingBonus(CR_CRIT_TAKEN_MELEE)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
            {
        name = "attackpower",
        display = L["Attack Power"],
        type = "number",
        init = "WeakAuras.GetEffectiveAttackPower()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "spellpower",
        display = L["Spell Power"],
        type = "number",
        init = "WeakAuras.GetEffectiveSpellPower()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "rangedattackpower",
        display = L["Ranged Attack Power"],
        type = "number",
        init = "WeakAuras.GetEffectiveRangedAttackPower()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        type = "header",
        name = "resistanceHeader",
        display = L["Resistances"],
      },
      {
        name = "resistancefire",
        display = L["Fire Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 2))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "resistancenature",
        display = L["Nature Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 3))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "resistancefrost",
        display = L["Frost Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 4))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "resistanceshadow",
        display = L["Shadow Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 5))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "resistancearcane",
        display = L["Arcane Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 6))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        type = "header",
        name = "tertiaryStatsHeader",
        display = L["Tertiary Stats"],
      },
      {
        name = "moveSpeed",
        display = L["Continuously update Movement Speed"],
        type = "boolean",
        test = true,
        width = WeakAuras.doubleWidth
      },
      {
        name = "movespeedpercent",
        display = L["Current Movement Speed (%)"],
        type = "number",
        init = "GetUnitSpeed('player') / 7 * 100",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        type = "header",
        name = "defensiveStatsHeader",
        display = L["Defensive Stats"],
      },
      {
        name = "dodgerating",
        display = L["Dodge Rating"],
        type = "number",
        init = "GetCombatRating(CR_DODGE)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "dodgepercent",
        display = L["Dodge (%)"],
        type = "number",
        init = "GetDodgeChance()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "parryrating",
        display = L["Parry Rating"],
        type = "number",
        init = "GetCombatRating(CR_PARRY)",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "parrypercent",
        display = L["Parry (%)"],
        type = "number",
        init = "GetParryChance()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "blockpercent",
        display = L["Block (%)"],
        type = "number",
        init = "GetBlockChance()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
      {
        name = "blockvalue",
        display = L["Block Value"],
        type = "number",
        init = "GetShieldBlock()",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "armorrating",
        display = L["Armor Rating"],
        type = "number",
        init = "select(2, UnitArmor('player'))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
      },
      {
        name = "armorpercent",
        display = L["Armor (%)"],
        type = "number",
        init = "PaperDollFrame_GetArmorReduction(select(2, UnitArmor('player')), UnitLevel('player'))",
        store = true,
        conditionType = "number",
        multiEntry = {
          operator = "and",
          limit = 2
        },
        formatter = "Number",
      },
    },
    automaticrequired = true,
    progressType = "none"
  },
  ["Conditions"] = {
    type = "unit",
    events = function(trigger, untrigger)
      local events = {}
      if trigger.use_incombat ~= nil then
        tinsert(events, "PLAYER_REGEN_ENABLED")
        tinsert(events, "PLAYER_REGEN_DISABLED")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_pvpflagged ~= nil or trigger.use_afk ~= nil then
        tinsert(events, "PLAYER_FLAGS_CHANGED")
      end
      if trigger.use_alive ~= nil then
        tinsert(events, "PLAYER_DEAD")
        tinsert(events, "PLAYER_ALIVE")
        tinsert(events, "PLAYER_UNGHOST")
      end
      if trigger.use_resting ~= nil then
        tinsert(events, "PLAYER_UPDATE_RESTING")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_mounted ~= nil then
        tinsert(events, "MOUNTED_UPDATE")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      local unit_events = {}
      local pet_unit_events = {}
      if trigger.use_vehicle ~= nil then
        tinsert(unit_events, "UNIT_ENTERED_VEHICLE")
        tinsert(unit_events, "UNIT_EXITED_VEHICLE")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_HasPet ~= nil then
        tinsert(pet_unit_events, "UNIT_HEALTH")
      end
      if trigger.use_ingroup ~= nil then
        tinsert(events, "PARTY_MEMBERS_CHANGED")
        tinsert(events, "RAID_ROSTER_UPDATE")
      end
      if trigger.use_instance_difficulty ~= nil
          or trigger.use_instance_size ~= nil
      then
        tinsert(events, "PLAYER_DIFFICULTY_CHANGED")
      end

      return {
        ["events"] = events,
        ["unit_events"] = {
          ["player"] = unit_events,
          ["pet"] = pet_unit_events
        }
      }
    end,
    internal_events = function(trigger, untrigger)
      local events = { "CONDITIONS_CHECK"};

      if trigger.use_ismoving ~= nil then
        tinsert(events, "PLAYER_MOVING_UPDATE");
      end

      if trigger.use_instance_difficulty ~= nil
          or trigger.use_instance_size ~= nil
          or trigger.use_pvpflagged ~= nil
      then
        tinsert(events, "WA_DELAYED_PLAYER_ENTERING_WORLD")
      end

      if (trigger.use_HasPet ~= nil) then
        AddUnitChangeInternalEvents("pet", events);
      end

      return events;
    end,
    force_events = "CONDITIONS_CHECK",
    name = L["Conditions"],
    loadFunc = function(trigger)
      if (trigger.use_ismoving ~= nil) then
        WeakAuras.WatchForPlayerMoving();
      end
      if (trigger.use_HasPet ~= nil) then
        AddWatchedUnits("pet")
      end
    end,
    init = function(trigger)
      return "";
    end,
    args = {
      {
        name = "alwaystrue",
        display = L["Always active trigger"],
        type = "tristate",
        init = "true"
      },
      {
        name = "incombat",
        display = L["In Combat"],
        type = "tristate",
        init = "UnitAffectingCombat('player')"
      },
      {
        name = "pvpflagged",
        display = L["PvP Flagged"],
        type = "tristate",
        init = "UnitIsPVP('player')",
      },
      {
        name = "alive",
        display = L["Alive"],
        type = "tristate",
        init = "not UnitIsDeadOrGhost('player')"
      },
      {
        name = "vehicle",
        display = L["In Vehicle"],
        type = "tristate",
        init = "UnitInVehicle('player')",
      },
      {
        name = "resting",
        display = L["Resting"],
        type = "tristate",
        init = "IsResting()"
      },
      {
        name = "mounted",
        display = L["Mounted"],
        type = "tristate",
        init = "IsMounted()"
      },
      {
        name = "HasPet",
        display = L["HasPet"],
        type = "tristate",
        init = "UnitExists('pet') and not UnitIsDead('pet')"
      },
      {
        name = "ismoving",
        display = L["Is Moving"],
        type = "tristate",
        init = "GetUnitSpeed('player') > 0"
      },
      {
        name = "afk",
        display = L["Is Away from Keyboard"],
        type = "tristate",
        init = "UnitIsAFK('player')"
      },
      {
        name = "ingroup",
        display = L["Group Type"],
        type = "multiselect",
        values = "group_types",
        init = "Private.ExecEnv.GroupType()",
        events = {"PARTY_MEMBERS_CHANGED", "RAID_ROSTER_UPDATE"}
      },
      {
        name = "instance_size",
        display = L["Instance Type"].." "..L["|cffff0000deprecated|r"],
        desc = constants.instanceFilterDeprecated,
        type = "multiselect",
        values = "instance_types",
        sorted = true,
        init = "WeakAuras.InstanceType()",
        events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA"}
      },
      {
        name = "instance_difficulty",
        display = L["Instance Difficulty"].." "..L["|cffff0000deprecated|r"],
        desc = constants.instanceFilterDeprecated,
        type = "multiselect",
        values = "difficulty_types",
        init = "WeakAuras.InstanceDifficulty()"
      },
    },
    automaticrequired = true,
    progressType = "none"
  },

  ["Spell Known"] = {
    type = "spell",
    events = {
      ["events"] = {"SPELLS_CHANGED", "PLAYER_TALENT_UPDATE"},
      ["unit_events"] = {
        ["player"] = {"UNIT_PET"}
      }
    },
    internal_events = {
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "SPELLS_CHANGED",
    name = L["Spell Known"],
    statesParameter = "one",
    init = function(trigger)
      local spellName;
      local ret = {};

      spellName = type(trigger.spellName) == "number" and trigger.spellName or 0;
      table.insert(ret, ([[
        local spellName = %s;
        local name, _, icon = GetSpellInfo(spellName)
      ]]):format(spellName))

      local spellCheck = spellName ~= 0 and "true" or "false"
      if (trigger.use_inverse) then
        table.insert(ret, ([[
          local usePet = %s;
          local active = %s and IsSpellKnown(spellName, usePet) or false
        ]]):format(trigger.use_petspell and "true" or "false", spellCheck))
      else
        table.insert(ret, ([[
          local usePet = %s;
          local active = %s and IsSpellKnown(spellName, usePet)
        ]]):format(trigger.use_petspell and "true" or "false", spellCheck))
      end
      return table.concat(ret)
    end,
    GetNameAndIcon = function(trigger)
      local name, _, icon = GetSpellInfo(trigger.spellName or 0)
      return name, icon
    end,
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        test = "true",
      },
      {
        name = "petspell",
        display = L["Pet Spell"],
        type = "toggle",
        test = "true"
      },
      {
        name = "inverse",
        display = WeakAuras.newFeatureString .. L["Inverse"],
        type = "toggle",
        test = "true",
      },
      {
        name = "name",
        display = L["Name"],
        hidden = true,
        init = "name",
        test = "true",
        store = true,
        conditionType = "string"
      },
      {
        name = "icon",
        hidden = true,
        init = "icon",
        test = "true",
        store = true
      },
      {
        hidden = true,
        test = "active"
      }
    },
    automaticrequired = true,
    progressType = "none"
  },

  ["Pet Behavior"] = {
    type = "unit",
    events = function(trigger)
      local result = {};
      if (trigger.use_behavior) then
        tinsert(result, "PET_BAR_UPDATE");
      end
      return {
        ["events"] = result,
        ["unit_events"] = {
          ["player"] = {"UNIT_PET"}
        }
      };
    end,
    internal_events = {
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "WA_DELAYED_PLAYER_ENTERING_WORLD",
    name = L["Pet"],
    init = function(trigger)
      local ret = "local activeIcon\n";
      if (trigger.use_behavior) then
        ret = [[
            local inverse = %s
            local check_behavior = %s
            local name, i, token, active, behavior, _
            for index = 1, NUM_PET_ACTION_SLOTS do
              name, _, i, token, active = GetPetActionInfo(index)
              if active then
                activeIcon = not token and i or _G[i]
                if name == "PET_MODE_AGGRESSIVE" then
                  behavior = "aggressive"
                  break
                elseif name == "PET_MODE_DEFENSIVE" then
                  behavior = "defensive"
                  break
                elseif name == "PET_MODE_PASSIVE" then
                  behavior = "passive"
                  break
                end
              end
            end
        ]]
        ret = ret:format(trigger.use_inverse and "true" or "false", trigger.use_behavior and ('"' .. (trigger.behavior or "") .. '"') or "nil");
      end
      return ret;
    end,
    statesParameter = "one",
    args = {
      {
        name = "behavior",
        display = L["Pet Behavior"],
        type = "select",
        values = "pet_behavior_types",
        test = "UnitExists('pet') and (not check_behavior or (inverse and check_behavior ~= behavior) or (not inverse and check_behavior == behavior))",
      },
      {
        name = "inverse",
        display = L["Inverse Pet Behavior"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return trigger.use_behavior end
      },
      {
        hidden = true,
        name = "icon",
        init = "activeIcon",
        store = "true",
        test = "true"
      },
    },
    automaticrequired = true,
    progressType = "none"
  },

  ["Queued Action"] = {
    type = "spell",
    events = {
      ["events"] = {"ACTIONBAR_UPDATE_STATE"}
    },
    internal_events = {
      "ACTIONBAR_SLOT_CHANGED",
      "ACTIONBAR_PAGE_CHANGED"
    },
    name = L["Queued Action"],
    init = function(trigger)
      local spellName = type(trigger.spellName) ~= "table" and trigger.spellName or 0
      if trigger.use_exact_spellName then
        spellName = trigger.spellName
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName
      end
      local ret = [=[
        local spellname = %q
      ]=]
      return ret:format(spellName)
    end,
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        test = "true",
        showExactOption = true,
      },
      {
        hidden = true,
        test = "spellname and IsCurrentSpell(spellname)";
      },
    },
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.spellName or 0);
      return icon;
    end,
    automaticrequired = true,
    progressType = "none"
  },

  ["Range Check"] = {
    type = "unit",
    events = {
      ["events"] = {"FRAME_UPDATE"}
    },
    name = L["Range Check"],
    init = function(trigger)
      trigger.unit = trigger.unit or "target";
      local ret = [=[
          local unit = %q;
          local min, max = WeakAuras.GetRange(unit, true);
          min = min or 0;
          max = max or 999;
          local triggerResult = true;
      ]=]
      if (trigger.use_range) then
        trigger.range = trigger.range or 8;
        if (trigger.range_operator == "<=") then
          ret = ret .. "triggerResult = max <= " .. tostring(trigger.range) .. "\n";
        else
          ret = ret .. "triggerResult = min >= " .. tostring(trigger.range).. "\n";
        end
      end
      return ret:format(trigger.unit);
    end,
    statesParameter = "one",
    args = {
      {
        name = "note",
        type = "description",
        display = "",
        text = function() return L["Note: This trigger type estimates the range to the hitbox of a unit. The actual range of friendly players is usually 3 yards more than the estimate. Range checking capabilities depend on your current class and known abilities as well as the type of unit being checked. Some of the ranges may also not work with certain NPCs.|n|n|cFFAAFFAAFriendly Units:|r %s|n|cFFFFAAAAHarmful Units:|r %s|n|cFFAAAAFFMiscellanous Units:|r %s"]:format(RangeCacheStrings.friend or "", RangeCacheStrings.harm or "", RangeCacheStrings.misc or "") end
      },
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "unit",
        values = "unit_types_range_check",
        test = "true",
        store = true
      },
      {
        hidden = true,
        name = "minRange",
        display = L["Minimum Estimate"],
        type = "number",
        init = "min",
        store = true,
        test = "true",
        conditionType = "number",
        operator_types = "without_equal",
      },
      {
        hidden = true,
        name = "maxRange",
        display = L["Maximum Estimate"],
        type = "number",
        init = "max",
        store = true,
        test = "true",
        conditionType = "number",
        operator_types = "without_equal",
      },
      {
        name = "range",
        display = L["Distance"],
        type = "number",
        operator_types = "without_equal",
        test = "triggerResult",
        conditionType = "number",
        conditionTest = function(state, needle, needle2)
          return state and state.show and WeakAuras.CheckRange(state.unit, needle, needle2);
        end,
        noProgressSource = true
      },
      {
        hidden = true,
        test = "UnitExists(unit)"
      }
    },
    automaticrequired = true,
    progressType = "none"
  },
  ["Money"] = {
    type = "unit",
    statesParameter = "one",
    progressType = "none",
    automaticrequired = true,
    events = {
      ["events"] = {"PLAYER_MONEY"}
    },
    internal_events = {"WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "WA_DELAYED_PLAYER_ENTERING_WORLD",
    name = WeakAuras.newFeatureString..L["Player Money"],
    init = function()
      return [=[
        local money = GetMoney()
        local gold = floor(money / 1e4)
        local silver = floor(money / 100 % 100)
        local copper = money % 100
      ]=]
    end,
    args = {
      {
        name = "money",
        init = "money",
        type = "number",
        display = L["Money"],
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "gold",
        init = "gold",
        type = "number",
        display = Private.coin_icons.gold .. L["Gold"],
        store = true,
        conditionType = "number",
        formatter = "BigNumber"
      },
      {
        name = "silver",
        init = "silver",
        type = "number",
        display = Private.coin_icons.silver .. L["Silver"],
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "copper",
        init = "copper",
        type = "number",
        display = Private.coin_icons.copper .. L["Copper"],
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "icon",
        init = "GetCoinIcon(money)",
        store = true,
        hidden = true,
        test = "true",
      },
    },
    GetNameAndIcon = function()
      return MONEY, GetCoinIcon(GetMoney())
    end,
  },
  ["Currency"] = {
    type = "unit",
    progressType = "static",
    events = {
      ["events"] = {
        "CURRENCY_DISPLAY_UPDATE",
      }
    },
    force_events = "CURRENCY_DISPLAY_UPDATE",
    name = WeakAuras.newFeatureString..L["Currency"],
    init = function(trigger)
      if type(trigger.value) ~= "string" then trigger.value = "" end
      if type(trigger.value_operator) ~= "string" then trigger.value_operator = "" end
      local ret = [=[
        local currencyID = %d
        local quantity, totalEarned, icon
        if currencyID == 43308 then
          quantity, totalEarned = GetHonorCurrency()
          icon = UnitFactionGroup("player") == "Alliance" and
            "Interface/Icons/inv_misc_tournaments_symbol_human" or
            "Interface/Icons/Achievement_PVP_H_16"
        elseif currencyID == 43307 then
          quantity, totalEarned = GetArenaCurrency()
          icon = "Interface/PVPFrame/PVP-ArenaPoints-Icon"
        end
        local name = GetItemInfo(currencyID)
        local currencyInfo = {
          name = name or "Unknown Currency",
          quantity = quantity or GetItemCount(currencyID) or 0,
          icon = icon or GetItemIcon(currencyID) or "Interface/Icons/INV_Misc_QuestionMark",
          totalEarned = totalEarned or Private.ExecEnv.GetTotalCountCurrencies(currencyID) or 0,
          discovered = ((Private.ExecEnv.GetDiscoveredCurrencies() or {})[currencyID]) and true or false
        }
      ]=]
      return ret:format(tonumber(trigger.currencyId) or 0)
    end,
    statesParameter = "one",
    args = {
      {
        name = "currencyId",
        type = "currency",
        itemControl = "Dropdown-Currency",
        values = Private.ExecEnv.GetDiscoveredCurrencies,
        headers = Private.GetDiscoveredCurrenciesHeaders,
        sorted = true,
        sortOrder = function()
          local discovered_currencies_sorted = Private.GetDiscoveredCurrenciesSorted()
          local sortOrder = {}
          for key, value in pairs(Private.ExecEnv.GetDiscoveredCurrencies()) do
            tinsert(sortOrder, key)
          end
          table.sort(sortOrder, function(aKey, bKey)
            local aValue = discovered_currencies_sorted[aKey]
            local bValue = discovered_currencies_sorted[bKey]
            return aValue < bValue
          end)
          return sortOrder
        end,
        required = true,
        display = L["Currency"],
        store = true,
        test = "true",
      },
      {
        name = "name",
        init = "currencyInfo.name",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        name = "value",
        init = "currencyInfo.quantity",
        type = "number",
        display = L["Quantity"],
        store = true,
        conditionType = "number",
      },
      {
        name = "totalEarned",
        init = "currencyInfo.totalEarned",
        type = "number",
        display = L["Total"],
        store = true,
        conditionType = "number",
      },
      {
        name = "progressType",
        init = "'static'",
        hidden = true,
        store = true,
        test = "true",
      },
      {
        name = "icon",
        init = "currencyInfo.icon",
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "description",
        init = "currencyInfo.description",
        type = "string",
        display = L["Description"],
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "discovered",
        init = "currencyInfo.discovered",
        type = "tristate",
        display = L["Discovered"],
        store = true,
        conditionType = "bool",
      },
    },
    GetNameAndIcon = function(trigger)
      local id = trigger.currencyId or 0
      local name = GetItemInfo(id)
      local icon = GetItemIcon(id)
      if id == 43308 then
        icon = UnitFactionGroup("player") == "Alliance" and
          "Interface/Icons/inv_misc_tournaments_symbol_human" or
          "Interface/Icons/Achievement_PVP_H_16"
      elseif id == 43307 then
        icon = "Interface/PVPFrame/PVP-ArenaPoints-Icon"
      end
      return name, icon
    end,
    automaticrequired = true
  },
  ["Location"] = {
    type = "unit",
    events = {
      ["events"] = {
        "ZONE_CHANGED",
        "ZONE_CHANGED_INDOORS",
        "ZONE_CHANGED_NEW_AREA",
        "PLAYER_DIFFICULTY_CHANGED",
        "WA_DELAYED_PLAYER_ENTERING_WORLD"
      }
    },
    internal_events = {"INSTANCE_LOCATION_CHECK"},
    force_events = "INSTANCE_LOCATION_CHECK",
    name = WeakAuras.newFeatureString..L["Location"],
    init = function(trigger)
      local ret = [=[
        local uiMapId = GetCurrentMapAreaID()
        local instanceName, instanceType, difficultyID = GetInstanceInfo()
        local minimapZoneText = GetMinimapZoneText()
        local zoneText = GetZoneText()
      ]=]
      return ret
    end,
    statesParameter = "one",
    args = {
      {
        name = "zoneIds",
        display = L["Player Location ID(s)"],
        desc = function()
          return ("\n|cffffd200%s|r%s: %d\n\n%s"):format(L["Current Zone\n"], GetRealZoneText(), GetCurrentMapAreaID(), L["Supports multiple entries, separated by commas. Prefix with '-' for negation."])
        end,
        type = "string",
        multiline = true,
        preamble = "local zoneChecker = Private.ExecEnv.ParseZoneCheck(%q)",
        test = "zoneChecker:Check(MapId)",
        conditionType = "string",
        conditionPreamble = function(input)
          return Private.ExecEnv.ParseZoneCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.zoneId)
        end,
        operator_types = "none",
      },
      {
        name = "zoneId",
        display = L["Zone ID"],
        init = "uiMapId",
        store = true,
        hidden = true,
        test = "true",
      },
      {
        name = "zone",
        display = L["Zone Name"],
        desc = function()
          return ("|cffffd200%s|r%s"):format(L["Current Zone\n"], GetRealZoneText())
        end,
        type = "string",
        conditionType = "string",
        store = true,
        init = "zoneText",
        multiEntry = {
          operator = "or",
        }
      },
      {
        name = "subzone",
        display = L["Subzone Name"],
        desc = function()
          return ("%s\n\n|cffffd200%s|r%s"):format(L["Name of the (sub-)zone currently shown above the minimap."], L["Current Zone\n"], GetMinimapZoneText())
        end,
        type = "string",
        conditionType = "string",
        store = true,
        init = "minimapZoneText",
        multiEntry = {
          operator = "or",
        },
      },
      {
        type = "header",
        name = "instanceHeader",
        display = L["Instance Info"],
      },
      {
        name = "instance",
        display = L["Instance Name"],
        test = "true",
        hidden = "true",
        store = true,
      },
      {
        name = "instanceSize",
        display = L["Instance Size Type"],
        type = "multiselect",
        values = "instance_types",
        sorted = true,
        init = "WeakAuras.InstanceType()",
        conditionType = "select",
        store = true,
      },
      {
        name = "instanceDifficulty",
        display = L["Instance Difficulty"],
        type = "multiselect",
        values = "difficulty_types",
        init = "WeakAuras.InstanceDifficulty()",
        conditionType = "select",
        store = true,
      },
    },
    automaticrequired = true,
    progressType = "none"
  },
};

--[[
Disable any event here
if () then
  Private.event_prototypes[] = nil
  end
]]

Private.category_event_prototype = {}
for name, prototype in pairs(Private.event_prototypes) do
  Private.category_event_prototype[prototype.type] = Private.category_event_prototype[prototype.type] or {}
  Private.category_event_prototype[prototype.type][name] = prototype.name
end

Private.dynamic_texts = {
  ["p"] = {
    get = function(state)
      if not state then return nil end
      if state.progressType == "static" then
        return state.value or nil
      end
      if state.progressType == "timed" then
        if state.paused then
          return state.remaining and state.remaining >= 0 and state.remaining or nil
        end

        if not state.expirationTime or not state.duration then
          return nil
        end
        local remaining = state.expirationTime - GetTime();
        return remaining >= 0 and remaining or nil
      end
    end,
    func = function(remaining, state, progressPrecision)
      progressPrecision = progressPrecision or 1

      if not state or state.progressType ~= "timed" then
        return remaining
      end
      if type(remaining) ~= "number" then
        return ""
      end

      local remainingStr = "";
      if remaining == math.huge then
        remainingStr = " ";
      elseif remaining > 60 then
        remainingStr = string.format("%i:", math.floor(remaining / 60));
        remaining = remaining % 60;
        remainingStr = remainingStr..string.format("%02i", remaining);
      elseif remaining > 0 then
        if progressPrecision == 4 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.1f", remaining);
        elseif progressPrecision == 5 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.2f", remaining);
        elseif progressPrecision == 6 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.3f", remaining);
        elseif (progressPrecision == 4 or progressPrecision == 5 or progressPrecision == 6) and remaining > 3 then
          remainingStr = remainingStr..string.format("%d", remaining);
        else
          remainingStr = remainingStr..string.format("%.".. progressPrecision .."f", remaining);
        end
      else
        remainingStr = " ";
      end
      return remainingStr
    end
  },
  ["t"] = {
    get = function(state)
      if not state then return "" end
      if state.progressType == "static" then
        return state.total, false
      end
      if state.progressType == "timed" then
        if not state.duration then
          return nil
        end
        return state.duration, true
      end
    end,
    func = function(duration, state, totalPrecision)
      if not state or state.progressType ~= "timed" then
        return duration
      end
      if type(duration) ~= "number" then
        return ""
      end
      local durationStr = "";
      if math.abs(duration) == math.huge or tostring(duration) == "nan" then
        durationStr = " ";
      elseif duration > 60 then
        durationStr = string.format("%i:", math.floor(duration / 60));
        duration = duration % 60;
        durationStr = durationStr..string.format("%02i", duration);
      elseif duration > 0 then
        if totalPrecision == 4 and duration <= 3 then
          durationStr = durationStr..string.format("%.1f", duration);
        elseif totalPrecision == 5 and duration <= 3 then
          durationStr = durationStr..string.format("%.2f", duration);
        elseif totalPrecision == 6 and duration <= 3 then
          durationStr = durationStr..string.format("%.3f", duration);
        elseif (totalPrecision == 4 or totalPrecision == 5 or totalPrecision == 6) and duration > 3 then
          durationStr = durationStr..string.format("%d", duration);
        else
          durationStr = durationStr..string.format("%."..totalPrecision.."f", duration);
        end
      else
        durationStr = " ";
      end
      return durationStr
    end
  },
  ["n"] = {
    get = function(state)
      if not state then return "" end
      return state.name or state.id or "", true
    end,
    func = function(v)
      return v
    end
  },
  ["i"] = {
    get = function(state)
      if not state then return "" end
      return state.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
    end,
    func = function(v)
      return "|T".. v ..":12:12:0:0:64:64:4:60:4:60|t"
    end
  },
  ["s"] = {
    get = function(state)
      if not state or state.stacks == 0 then return "" end
      return state.stacks
    end,
    func = function(v)
      return v
    end
  }
};

-- Events in that list can be filtered by unitID
Private.UnitEventList = {
  PLAYER_GUILD_UPDATE = true,
  MINIMAP_PING = true,
  PARTY_MEMBER_DISABLE = true,
  PARTY_MEMBER_ENABLE = true,
  READY_CHECK_CONFIRM = true,
  PLAYER_GAINS_VEHICLE_DATA = true,
  PLAYER_LOSES_VEHICLE_DATA = true,
  KNOWN_TITLES_UPDATE = true,
  PLAYER_DAMAGE_DONE_MODS = true,
  PLAYER_FLAGS_CHANGED = true,
  PLAYER_PVP_KILLS_CHANGED = true,
  PLAYER_PVP_RANK_CHANGED = true,
  PLAYER_XP_UPDATE = true,
}

Private.InternalEventByIDList = {
  ITEM_COOLDOWN_STARTED = true,
  ITEM_COOLDOWN_CHANGED = true,
  ITEM_COOLDOWN_READY = true,
  ITEM_SLOT_COOLDOWN_STARTED = true,
  ITEM_SLOT_COOLDOWN_CHANGED = true,
  ITEM_SLOT_COOLDOWN_READY = true,
  ITEM_SLOT_COOLDOWN_ITEM_CHANGED = true,
  SPELL_COOLDOWN_CHANGED = true,
  SPELL_COOLDOWN_READY = true,
  SPELL_CHARGES_CHANGED = true,
  WA_UPDATE_OVERLAY_GLOW = true,
}

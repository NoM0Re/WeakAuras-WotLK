local ipairs = ipairs
local pairs = pairs
local ceil, floor = math.ceil, math.floor

local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

function noop()

end

function ipairs_reverse(table)
	local function Enumerator(table, index)
		index = index - 1;
		local value = table[index];
		if value ~= nil then
			return index, value;
		end
	end
	return Enumerator, table, #table + 1;
end

function tInvert(tbl)
	local inverted = {};
	for k, v in pairs(tbl) do
		inverted[v] = k;
	end
	return inverted;
end

function Round(value)
	if value < 0 then
		return ceil(value - .5);
	end
	return floor(value + .5);
end

function tIndexOf(tbl, item)
	for i, v in ipairs(tbl) do
		if item == v then
			return i;
		end
	end
end

function TableHasAnyEntries(tbl)
  if tbl and type(tbl) == "table" then
      for _ in pairs(tbl) do
          return true
      end
  end
  return false
end

function tAppendAll(table, addedArray)
  for i, element in ipairs(addedArray) do
    tinsert(table, element);
  end
end

function MergeTable(t1, t2)
  local merged = {}
  for k, v in pairs(t1) do
    merged[k] = v
  end
  for k, v in pairs(t2) do
    merged[k] = v
  end
  return merged
end

function tCompare(t1, t2)
  for k, v in pairs(t1) do
    if type(v) == "table" and type(t2[k]) == "table" then
      if not tCompare(v, t2[k]) then
        return false
      end
    elseif t2[k] ~= v then
      return false
    end
  end
  for k in pairs(t2) do
    if t1[k] == nil then
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
  return ("|c%s%s|r"):format(colorHexString, text);
end

function CreateTextureMarkup(file, fileWidth, fileHeight, width, height, left, right, top, bottom, xOffset, yOffset)
	return ("|T%s:%d:%d:%d:%d:%d:%d:%d:%d:%d:%d|t"):format(
		  file
		, height
		, width
		, xOffset or 0
		, yOffset or 0
		, fileWidth
		, fileHeight
		, left * fileWidth
		, right * fileWidth
		, top * fileHeight
		, bottom * fileHeight
	);
end

function Clamp(value, min, max)
	if value > max then
		return max;
	elseif value < min then
		return min;
	end
	return value;
end

-- This section is mostly used by Private.SmoothStatusBarMixin
function Lerp(startValue, endValue, amount)
	return (1 - amount) * startValue + amount * endValue;
end

function Saturate(value)
	return Clamp(value, 0, 1);
end

local TARGET_FRAME_PER_SEC = 60.0;
function DeltaLerp(startValue, endValue, amount, timeSec)
	return Lerp(startValue, endValue, Saturate(amount * timeSec * TARGET_FRAME_PER_SEC));
end

function FrameDeltaLerp(startValue, endValue, amount, elapsed)
	return DeltaLerp(startValue, endValue, amount, elapsed);
end

-- Fix FrameStrata of ChatFrame
for i = 1, NUM_CHAT_WINDOWS do
	local chatFrame = _G["ChatFrame" .. i]
	if chatFrame and type(chatFrame.GetFrameStrata) == "function" and type(chatFrame.SetFrameStrata) == "function" then
		if chatFrame:GetFrameStrata() == "BACKGROUND" then
			chatFrame:SetFrameStrata("MEDIUM")
		end
	end
end

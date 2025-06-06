if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local Private = select(2, ...)

local LCG = LibStub("LibCustomGlow-1.0")

local MSQ = LibStub("Masque", true)
local L = WeakAuras.L

local default = function(parentType)
  local options = {
    glow = false,
    useGlowColor = false,
    glowColor = {1, 1, 1, 1},
    glowType = "buttonOverlay",
    glowLines = 8,
    glowFrequency = 0.25,
    glowDuration = 1,
    glowLength = 10,
    glowThickness = 1,
    glowScale = 1,
    glowBorder = false,
    glowXOffset = 0,
    glowYOffset = 0,
  }
  if parentType == "aurabar" then
    options["glowType"] = "Pixel"
    options["anchor_area"] = "bar"
  end
  return options
end

local properties = {
  glow = {
    display = L["Visibility"],
    setter = "SetVisible",
    type = "bool",
    defaultProperty = true
  },
  glowType = {
    display =L["Type"],
    setter = "SetGlowType",
    type = "list",
    values = Private.glow_types,
  },
  useGlowColor = {
    display = L["Use Custom Color"],
    setter = "SetUseGlowColor",
    type = "bool"
  },
  glowColor = {
    display = L["Custom Color"],
    setter = "SetGlowColor",
    type = "color"
  },
  glowLines = {
    display = L["Lines & Particles"],
    setter = "SetGlowLines",
    type = "number",
    min = 1,
    softMax = 30,
    bigStep = 1,
    default = 4
  },
  glowFrequency = {
    display = L["Frequency"],
    setter = "SetGlowFrequency",
    type = "number",
    softMin = -2,
    softMax = 2,
    bigStep = 0.1,
    default = 0.25
  },
  glowDuration = {
    display = L["Duration"],
    setter = "SetGlowDuration",
    type = "number",
    softMin = 0.01,
    softMax = 3,
    bigStep = 0.1,
    default = 1
  },
  glowLength = {
    display = L["Length"],
    setter = "SetGlowLength",
    type = "number",
    min = 1,
    softMax = 20,
    bigStep = 1,
    default = 10
  },
  glowThickness = {
    display = L["Thickness"],
    setter = "SetGlowThickness",
    type = "number",
    min = 1,
    softMax = 20,
    bigStep = 1,
    default = 1
  },
  glowScale = {
    display = L["Scale"],
    setter = "SetGlowScale",
    type = "number",
    min = 0.05,
    softMax = 10,
    bigStep = 0.05,
    default = 1,
    isPercent = true
  },
  glowBorder = {
    display = L["Border"],
    setter = "SetGlowBorder",
    type = "bool"
  },
  glowXOffset = {
    display = L["X-Offset"],
    setter = "SetGlowXOffset",
    type = "number",
    softMin = -100,
    softMax = 100,
    bigStep = 1,
    default = 0
  },
  glowYOffset = {
    display = L["Y-Offset"],
    setter = "SetGlowYOffset",
    type = "number",
    softMin = -100,
    softMax = 100,
    bigStep = 1,
    default = 0
  },
  glowStartAnim = {
    display = L["Start Animation"],
    setter = "SetGlowStartAnim",
    type = "bool",
  },
}

local function glowStart(self, frame, color)

  if frame:GetWidth() < 1 or frame:GetHeight() < 1 then
    self.glowStop(frame)
    return
  end

  if self.glowType == "buttonOverlay" then
    self.glowStart(frame, color, self.glowFrequency, 0)
  elseif self.glowType == "Pixel" then
    self.glowStart(
      frame,
      color,
      self.glowLines,
      self.glowFrequency,
      self.glowLength,
      self.glowThickness,
      self.glowXOffset,
      self.glowYOffset,
      self.glowBorder,
      nil,
      0
    )
  elseif self.glowType == "ACShine" then
    self.glowStart(
      frame,
      color,
      self.glowLines,
      self.glowFrequency,
      self.glowScale,
      self.glowXOffset,
      self.glowYOffset,
      nil,
      0
    )
  elseif self.glowType == "Proc" then
    self.glowStart(frame, {
      color = color,
      startAnim = self.glowStartAnim and true or false,
      duration = self.glowDuration,
      xOffset = self.glowXOffset,
      yOffset = self.glowYOffset,
      frameLevel = 0
    })
  end
end

local funcs = {
  SetVisible = function(self, visible)
    local color
    self.glow = visible

    if self.useGlowColor then
      color = self.glowColor
    end

    if MSQ and self.parentType == "icon" then
      if (visible) then
        self.__MSQ_Shape = self:GetParent().button.__MSQ_Shape
        self:Show()
        glowStart(self, self, color)
      else
        self.glowStop(self)
        self:Hide()
      end
    elseif (visible) then
      self:Show()
      glowStart(self, self, color)
    else
      self.glowStop(self)
      self:Hide()
    end
  end,
  SetGlowType = function(self, newType)
    newType = newType or "buttonOverlay"
    if newType == self.glowType then
      return
    end

    local isGlowing = self.glow
    if isGlowing then
      self:SetVisible(false)
    end

    if newType == "buttonOverlay" then
      self.glowStart = LCG.ButtonGlow_Start
      self.glowStop = LCG.ButtonGlow_Stop
      if self.parentRegionType ~= "aurabar" then
        self.parent:AnchorSubRegion(self, "area", "region")
      end
    elseif newType == "ACShine" then
      self.glowStart = LCG.AutoCastGlow_Start
      self.glowStop = LCG.AutoCastGlow_Stop
      if self.parentRegionType ~= "aurabar" then
        self.parent:AnchorSubRegion(self, "area")
      end
    elseif newType == "Pixel" then
      self.glowStart = LCG.PixelGlow_Start
      self.glowStop = LCG.PixelGlow_Stop
      if self.parentRegionType ~= "aurabar" then
        self.parent:AnchorSubRegion(self, "area")
      end
    elseif newType == "Proc" then
      self.glowStart = LCG.ProcGlow_Start
      self.glowStop = LCG.ProcGlow_Stop
      if self.parentRegionType ~= "aurabar" then
        self.parent:AnchorSubRegion(self, "area", "region")
      end
    else -- noop function in case of unsupported glow
      self.glowStart = function() end
      self.glowStop = function() end
    end
    self.glowType = newType
    if isGlowing then
      self:SetVisible(true)
    end
  end,
  SetUseGlowColor = function(self, useGlowColor)
    self.useGlowColor = useGlowColor
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowColor = function(self, r, g, b, a)
    self.glowColor = {r, g, b, a}
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowLines = function(self, lines)
    self.glowLines = lines
    if self.glow then
      if self.glowType == "ACShine" then -- workaround ACShine not updating numbers of dots
        self:SetVisible(false)
      end
      self:SetVisible(true)
    end
  end,
  SetGlowFrequency = function(self, frequency)
    self.glowFrequency = frequency
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowDuration = function(self, duration)
    self.glowDuration = duration
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowLength = function(self, length)
    self.glowLength = length
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowThickness = function(self, thickness)
    self.glowThickness = thickness
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowScale = function(self, scale)
    self.glowScale = scale
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowBorder = function(self, border)
    self.glowBorder = border
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowStartAnim = function(self, enable)
    self.glowStartAnim = enable
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowXOffset = function(self, xoffset)
    self.glowXOffset = xoffset
    if self.glow then
      self:SetVisible(true)
    end
  end,
  SetGlowYOffset = function(self, yoffset)
    self.glowYOffset = yoffset
    if self.glow then
      self:SetVisible(true)
    end
  end,
  UpdateSize = function(self, ...)
    if self.glow then
      self:SetVisible(true)
    end
  end
}

local function create()
  local region = CreateFrame("Frame", nil, UIParent)

  for name, func  in pairs(funcs) do
    region[name] = func
  end

  return region
end

local function onAcquire(subRegion)
  subRegion:Show()
end

local function onRelease(subRegion)
  subRegion.glowType = nil
  if subRegion.glow then
    subRegion:SetVisible(false)
  end
  subRegion:Hide()
  subRegion:ClearAllPoints()
  subRegion:SetParent(UIParent)
end

local function modify(parent, region, parentData, data, first)
  region:SetParent(parent)
  region.parentRegionType = parentData.regionType
  region.parent = parent

  region.parentType = parentData.regionType
  region.useGlowColor = data.useGlowColor
  region.glowColor = data.glowColor
  region.glowLines = data.glowLines
  region.glowFrequency = data.glowFrequency
  region.glowLength = data.glowLength
  region.glowThickness = data.glowThickness
  region.glowScale = data.glowScale
  region.glowBorder = data.glowBorder
  region.glowXOffset = data.glowXOffset
  region.glowYOffset = data.glowYOffset
  region.glowStartAnim = data.glowStartAnim
  region.glowDuration = data.glowDuration

  region:SetGlowType(data.glowType)
  region:SetVisible(data.glow)

  region:SetScript("OnSizeChanged", region.UpdateSize)

  region.Anchor = function()
    if parentData.regionType == "aurabar" then
      parent:AnchorSubRegion(region, "area", data.anchor_area)
    else
      parent:AnchorSubRegion(region, "area", (data.glowType == "buttonOverlay" or data.glowType == "Proc") and "region")
    end
  end
end

-- This is used by the templates to add glow
function Private.getDefaultGlow(regionType)
  if regionType == "aurabar" then
    return {
      ["type"] = "subglow",
      glow = false,
      useGlowColor = false,
      glowColor = {1, 1, 1, 1},
      glowType = "Pixel",
      glowLines = 8,
      glowFrequency = 0.25,
      glowDuration = 1,
      glowLength = 10,
      glowThickness = 1,
      glowScale = 1,
      glowBorder = false,
      glowXOffset = 0,
      glowYOffset = 0,
      anchor_area = "bar"
    }
  else
    return {
      ["type"] = "subglow",
      glow = false,
      useGlowColor = false,
      glowColor = {1, 1, 1, 1},
      glowType = "buttonOverlay",
      glowLines = 8,
      glowFrequency = 0.25,
      glowDuration = 1,
      glowLength = 10,
      glowThickness = 1,
      glowScale = 1,
      glowBorder = false,
      glowXOffset = 0,
      glowYOffset = 0,
    }
  end
end

local supportedRegion = {
  icon = true,
  aurabar = true,
  texture = true,
  progresstexture = true,
  empty = true,
}
local function supports(regionType)
  return supportedRegion[regionType]
end

local function addDefaultsForNewAura(data)
  if data.regionType == "icon" then
    tinsert(data.subRegions, {
      ["type"] = "subglow",
      glow = false,
      useGlowColor = false,
      glowColor = {1, 1, 1, 1},
      glowType = "buttonOverlay",
      glowLines = 8,
      glowFrequency = 0.25,
      glowLength = 10,
      glowThickness = 1,
      glowScale = 1,
      glowBorder = false,
      glowXOffset = 0,
      glowYOffset = 0,
    })
  end
end

WeakAuras.RegisterSubRegionType("subglow", L["Glow"], supports, create, modify, onAcquire, onRelease,
                                default, addDefaultsForNewAura, properties)

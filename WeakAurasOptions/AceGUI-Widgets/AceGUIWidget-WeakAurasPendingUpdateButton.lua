if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)
local L = WeakAuras.L

local pairs, next, type, unpack = pairs, next, type, unpack

local Type, Version = "WeakAurasPendingUpdateButton", 6
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)

if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then
  return
end

local function Hide_Tooltip()
  GameTooltip:Hide()
end

local function Show_Long_Tooltip(owner, description)
  GameTooltip:SetOwner(owner, "ANCHOR_NONE");
  GameTooltip:SetPoint("LEFT", owner, "RIGHT");
  GameTooltip:ClearLines();
  local line = 1;
  for i,v in pairs(description) do
    if(type(v) == "string") then
      if(line > 1) then
        GameTooltip:AddLine(v, 1, 1, 1, 1);
      else
        GameTooltip:AddLine(v);
      end
    elseif(type(v) == "table") then
      if(i == 1) then
        GameTooltip:AddDoubleLine(v[1], v[2]..(v[3] and (" |T"..v[3]..":12:12:0:0:64:64:4:60:4:60|t") or ""));
      else
        GameTooltip:AddDoubleLine(v[1], v[2]..(v[3] and (" |T"..v[3]..":12:12:0:0:64:64:4:60:4:60|t") or ""), 1, 1, 1, 1, 1, 1, 1, 1);
      end
    end
    line = line + 1;
  end
  GameTooltip:Show();
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
  ["OnAcquire"] = function(self)
    self:SetWidth(1000)
    self:SetHeight(32)
    self.hasThumbnail = false
  end,
  ["Initialize"] = function(self, id, companionData)
    self.callbacks = {}
    self.id = id
    self.companionData = companionData
    self.linkedAuras = {}
    self.linkedChildren = {}

    function self.callbacks.OnUpdateClick()
      local linkedAuras = {}
      for auraId in pairs(self.linkedAuras) do
        if not self.linkedChildren[auraId] then
          tinsert(linkedAuras, auraId)
        end
      end

      WeakAuras.Import(self.companionData.encoded, nil, nil, linkedAuras)
    end

    function self.callbacks.OnFollowLinkClick()
      self.menu = {
        { text = L["Linked Auras"], isTitle = true }
      }
      for auraId in pairs(self.linkedAuras) do
        if not self.linkedChildren[auraId] then
          tinsert(
            self.menu,
            {
              text = auraId,
              notCheckable = true,
              func = function() WeakAuras.PickDisplay(auraId, "information") end
            }
          )
        end
      end
      EasyMenu(self.menu, WeakAuras_DropDownMenu, self.followLink, 0, 0, "MENU", 5)
    end

    self:SetTitle(self.companionData.name)
    self.frame:SetScript("OnClick", self.callbacks.OnClickNormal)
    self.update:SetScript("OnClick", self.callbacks.OnUpdateClick)
    self.followLink:SetScript("OnClick", self.callbacks.OnFollowLinkClick)
    local data = OptionsPrivate.Private.StringToTable(self.companionData.encoded, true)
    WeakAuras.PreAdd(data.d)
    self.data = data.d
    self.frame:EnableKeyboard(false)
    self:Enable()
    self.frame:Hide()

    self.menu = {}

    self.frame:SetScript("OnEnter", function()
      self:SetNormalTooltip()
      Show_Long_Tooltip(self.frame, self.frame.description)
    end)
    self.frame:SetScript("OnLeave", Hide_Tooltip)
  end,
  ["SetLogo"] = function(self, path)
    self.frame.updateLogo.tex:SetTexture(path)
  end,
  ["SetRefreshLogo"] = function(self, path)
    self.frame.update:SetNormalTexture(path)
  end,
  ["Disable"] = function(self)
    self.background:Hide()
    self.frame:Disable()
  end,
  ["Enable"] = function(self)
    self.background:Show()
    self.frame:Enable()
    self.update:Show()
    self.update:Enable()
    self.updateLogo:Show()
    self:UpdateThumbnail()
  end,
  ["OnRelease"] = function(self)
    self:ReleaseThumbnail()
    self:Enable()
    self.title:Show()
    self.frame:SetScript("OnEnter", nil)
    self.frame:SetScript("OnLeave", nil)
    self.frame:SetScript("OnClick", nil)
    self.frame:ClearAllPoints()
    self.frame:Hide()
    self.frame = nil
    self.data = nil
  end,
  ["SetNormalTooltip"] = function(self)
    local data = self.data;
    local namestable = {};

    local hasDescription = data.desc and data.desc ~= "";
    local hasUrl = data.url and data.url ~= "";
    local hasVersion = (data.semver and data.semver ~= "") or (data.version and data.version ~= "");
    local hasVersionNote = self.companionData.versionNote and self.companionData.versionNote ~= ""

    if(hasDescription or hasUrl or hasVersion or hasVersionNote) then
      tinsert(namestable, " ")
    end

    if hasVersionNote then
      tinsert(namestable, "|cFFFFD100"..self.companionData.versionNote)
      tinsert(namestable, " ")
    end

    for auraId in pairs(self.linkedAuras) do
      if not self.linkedChildren[auraId] then
        tinsert(namestable, "|cFFFFD100" .. L["Linked aura: "]  .. auraId .. "|r")
      end
    end
    tinsert(namestable, " ")

    if(hasDescription) then
      tinsert(namestable, "|cFFFFD100"..data.desc)
    end

    if (hasUrl) then
      tinsert(namestable, "|cFFFFD100" .. data.url .. "|r")
    end

    if (hasVersion) then
      tinsert(namestable, "|cFFFFD100" .. L["Version: "]  .. (data.semver or data.version) .. "|r")
    end

    self:SetDescription({self.companionData.name or self.data.id, self.companionData.author or ""}, unpack(namestable))
  end,
  ["SetDescription"] = function(self, ...)
    self.frame.description = {...};
  end,
  ["SetTitle"] = function(self, title)
    self.titletext = title
    self.title:SetText(title)
  end,
  ["ResetLinkedAuras"] = function(self)
    wipe(self.linkedAuras)
    wipe(self.linkedChildren)
  end,
  ["MarkLinkedAura"] = function(self, auraId)
    self.linkedAuras[auraId] = true
  end,
  ["MarkLinkedChildren"] = function(self, auraId)
    self.linkedChildren[auraId] = true
  end,
  ["UpdateThumbnail"] = function(self)
    if not self.hasThumbnail then
      return
    end

    if self.data.regionType ~= self.thumbnailType then
      self:ReleaseThumbnail()
      self:AcquireThumbnail()
    else
      local option = OptionsPrivate.Private.regionOptions[self.thumbnailType]
      if option and option.modifyThumbnail then
        option.modifyThumbnail(self.frame, self.thumbnail, self.data)
      end
    end
  end,
  ["ReleaseThumbnail"] = function(self)
    if not self.hasThumbnail then
      return
    end
    self.hasThumbnail = false

    if self.thumbnail then
      local regionType = self.thumbnailType
      local option = OptionsPrivate.Private.regionOptions[regionType]
      if self.thumbnail.icon then
        self.thumbnail.icon:SetDesaturated(false)
      end
      option.releaseThumbnail(self.thumbnail)
      self.thumbnail = nil
    end
  end,
  ["AcquireThumbnail"] = function(self)
    if self.hasThumbnail then
      return
    end

    if not self.data then
      return
    end

    self.hasThumbnail = true

    local button = self.frame
    local regionType = self.data.regionType
    self.thumbnailType = regionType

    local option = OptionsPrivate.Private.regionOptions[regionType]
    if option and option.acquireThumbnail then
      self.thumbnail = option.acquireThumbnail(button, self.data)
      if self.thumbnail.icon then
        self.thumbnail.icon:SetDesaturated(true)
      end
      self:SetIcon(self.thumbnail)
    else
      self:SetIcon("Interface\\Icons\\INV_Misc_QuestionMark")
    end
  end,
  ["SetIcon"] = function(self, icon)
    self.orgIcon = icon
    if (type(icon) == "string" or type(icon) == "number") then
      self.icon:SetTexture(icon)
      self.icon:Show()
      if (self.iconRegion and self.iconRegion.Hide) then
        self.iconRegion:Hide()
      end
    else
      self.iconRegion = icon
      icon:SetAllPoints(self.icon)
      icon:SetParent(self.frame)
      icon:Show()
      self.iconRegion:Show()
      self.icon:Hide()
    end
  end,
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]

local function Constructor()
  local name = "WeakAurasPendingUpdateButton" .. AceGUI:GetNextWidgetNum(Type)
  local button = CreateFrame("Button", name, UIParent)
  button:SetHeight(32)
  button:SetWidth(1000)
  button.data = {}

  local background = button:CreateTexture(nil, "BACKGROUND")
  button.background = background
  background:SetTexture("Interface\\BUTTONS\\UI-Listbox-Highlight2.blp")
  background:SetBlendMode("ADD")
  background:SetVertexColor(0.88, 0.88, 0, 0.3)
  background:SetPoint("TOP", button, "TOP")
  background:SetPoint("BOTTOM", button, "BOTTOM")
  background:SetPoint("LEFT", button, "LEFT")
  background:SetPoint("RIGHT", button, "RIGHT")

  local icon = button:CreateTexture(nil, "OVERLAY")
  button.icon = icon
  icon:SetWidth(32)
  icon:SetHeight(32)
  icon:SetPoint("LEFT", button, "LEFT")

  button.description = {}

  -- follow link button
  local followLink = CreateFrame("Button", nil, button)
  button.followLink = followLink
  followLink:SetNormalTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\loottoast-arrow-green")
  followLink:GetNormalTexture():SetRotation(math.rad(-90))
  followLink:SetWidth(32)
  followLink:SetHeight(32)
  followLink:SetPoint("RIGHT", button, "RIGHT", -2, 0)
  followLink:SetScript("OnEnter", function()
    GameTooltip:SetOwner(followLink, "ANCHOR_NONE")
    GameTooltip:SetPoint("BOTTOMLEFT", followLink, "TOPRIGHT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine(L["Linked Auras"])
    GameTooltip:Show()
  end)
  followLink:SetScript("OnLeave", Hide_Tooltip)

  local update = CreateFrame("Button", nil, button)
  button.update = update
  update.disabled = true
  update.func = function()
  end
  update:SetNormalTexture([[Interface\AddOns\WeakAuras\Media\Textures\wagoupdate_refresh.tga]])
  update:Disable()
  update:SetWidth(24)
  update:SetHeight(24)
  update:SetPoint("RIGHT", followLink, "LEFT", -2, 0)

  -- Add logo
  local updateLogo = CreateFrame("Frame", nil, button)
  button.updateLogo = updateLogo
  local tex = updateLogo:CreateTexture()
  tex:SetTexture([[Interface\AddOns\WeakAuras\Media\Textures\wagoupdate_logo.tga]])
  tex:SetAllPoints()
  updateLogo.tex = tex
  updateLogo:SetSize(24, 24)
  updateLogo:SetPoint("CENTER", update)
  updateLogo:SetFrameStrata(update:GetFrameStrata())
  updateLogo:SetFrameLevel(update:GetFrameLevel()-1)

  -- Animation On Hover
  local animGroup = update:CreateAnimationGroup()
  update.animGroup = animGroup

  local animRotate = animGroup:CreateAnimation("rotation")
  animRotate:SetDegrees(-360)
  animRotate:SetDuration(1)
  animRotate:SetSmoothing("OUT")
  animGroup:SetScript("OnFinished", function()
    if (MouseIsOver(update)) then
      animGroup:Play()
    end
  end)
  update:SetScript("OnEnter", function()
    animGroup:Play()
    GameTooltip:SetOwner(update, "ANCHOR_NONE")
    GameTooltip:SetPoint("BOTTOMLEFT", update, "TOPRIGHT")
    GameTooltip:ClearLines()
    GameTooltip:AddLine(L["Update"])
    GameTooltip:Show()
  end)
  update:SetScript("OnLeave", Hide_Tooltip)
  update:Hide()
  updateLogo:Hide()

  local title = button:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  button.title = title
  title:SetHeight(14)
  title:SetJustifyH("LEFT")
  title:SetPoint("TOPLEFT", icon, "TOPRIGHT", 2, 0)
  title:SetPoint("BOTTOMLEFT", icon, "BOTTOMRIGHT", 2, 0)
  title:SetPoint("RIGHT", updateLogo, "LEFT", -2, 0)
  title:SetVertexColor(0.6, 0.6, 0.6)

  local widget = {
    frame = button,
    title = title,
    icon = icon,
    background = background,
    update = update,
    updateLogo = updateLogo,
    followLink = followLink,
    type = Type,
  }

  for method, func in pairs(methods) do
    widget[method] = func
  end

  return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

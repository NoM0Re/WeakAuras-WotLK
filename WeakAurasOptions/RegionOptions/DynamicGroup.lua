if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local OptionsPrivate = select(2, ...)

local L = WeakAuras.L

local selfPoints = {
  default = "CENTER",
  RIGHT = function(data)
    if data.align  == "LEFT" then
      return "TOPLEFT"
    elseif data.align == "RIGHT" then
      return "BOTTOMLEFT"
    else
      return "LEFT"
    end
  end,
  LEFT = function(data)
    if data.align  == "LEFT" then
      return "TOPRIGHT"
    elseif data.align == "RIGHT" then
      return "BOTTOMRIGHT"
    else
      return "RIGHT"
    end
  end,
  UP = function(data)
    if data.align == "LEFT" then
      return "BOTTOMLEFT"
    elseif data.align == "RIGHT" then
      return "BOTTOMRIGHT"
    else
      return "BOTTOM"
    end
  end,
  DOWN = function(data)
    if data.align == "LEFT" then
      return "TOPLEFT"
    elseif data.align == "RIGHT" then
      return "TOPRIGHT"
    else
      return "TOP"
    end
  end,
  HORIZONTAL = function(data)
    if data.align == "LEFT" then
      return "TOP"
    elseif data.align == "RIGHT" then
      return "BOTTOM"
    else
      return "CENTER"
    end
  end,
  VERTICAL = function(data)
    if data.align == "LEFT" then
      return "LEFT"
    elseif data.align == "RIGHT" then
      return "RIGHT"
    else
      return "CENTER"
    end
  end,
  CIRCLE = "CENTER",
  COUNTERCIRCLE = "CENTER",
}

local gridSelfPoints = {
  RU = "BOTTOMLEFT",
  UR = "BOTTOMLEFT",
  LU = "BOTTOMRIGHT",
  UL = "BOTTOMRIGHT",
  RD = "TOPLEFT",
  DR = "TOPLEFT",
  LD = "TOPRIGHT",
  DL = "TOPRIGHT",
  HD = "TOP",
  HU = "BOTTOM",
  VR = "LEFT",
  VL = "RIGHT",
  DH = "TOP",
  UH = "BOTTOM",
  LV = "RIGHT",
  RV = "LEFT",
  HV = "CENTER",
  VH = "CENTER",
}

local function createOptions(id, data)
  local options = {
    __title = L["Dynamic Group Settings"],
    __order = 1,
    groupIcon = {
      type = "input",
      width = WeakAuras.doubleWidth - 0.15,
      name = L["Group Icon"],
      desc = L["Set Thumbnail Icon"],
      order = 0.5,
      get = function()
        return data.groupIcon and tostring(data.groupIcon) or ""
      end,
      set = function(info, v)
        data.groupIcon = v
        WeakAuras.Add(data)
        WeakAuras.UpdateThumbnail(data)
      end
    },
    chooseIcon = {
      type = "execute",
      width = 0.15,
      name = L["Choose"],
      order = 0.51,
      func = function()
        OptionsPrivate.OpenIconPicker(data, { [data.id] = {"groupIcon"} }, true)
      end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    -- grow options
    grow = {
      type = "select",
      width = WeakAuras.doubleWidth,
      name = L["Grow"],
      order = 1,
      values = OptionsPrivate.Private.grow_types,
      set = function(info, v)
        data.grow = v
        if v == "GRID" then
          data.selfPoint = gridSelfPoints[data.gridType]
        else
          local selfPoint = selfPoints[data.grow] or selfPoints.default
          if type(selfPoint) == "function" then
            selfPoint = selfPoint(data)
          end
          data.selfPoint = selfPoint
        end
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end,
    },
    growOn = {
      type = "input",
      width = WeakAuras.doubleWidth,
      name = L["Run on..."],
      desc = L["You can add a comma-separated list of state values here that (when changed) WeakAuras should also run the Grow Code on.\n\nWeakAuras will always run custom grow code if you include 'changed' in this list, or when a region is added, removed, or re-ordered."],
      order = 2 - 0.1,
      get = function()
        return data.growOn or ""
      end,
      hidden = function() return data.grow ~= "CUSTOM" end,
      set = function(info, v)
        data.growOn = v
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end
    },
    useAnchorPerUnit = {
      type = "toggle",
      order = 1.5,
      width = WeakAuras.normalWidth,
      name = L["Group by Frame"],
      desc = L["Group and anchor each auras by frame.\n\n- Nameplates: attach to nameplates per unit.\n- Unit Frames: attach to unit frame buttons per unit.\n- Custom Frames: choose which frame each region should be anchored to."],
      hidden = function() return data.grow == "CUSTOM" end,
    },
    anchorPerUnit = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Group by Frame"],
      order = 1.6,
      values = function()
        local v = {
          ["UNITFRAME"] = L["Unit Frames"],
          ["CUSTOM"] = L["Custom Frames"]
        }
        if WeakAuras.IsAwesomeEnabled() then
          v["NAMEPLATE"] = L["Nameplates"]
        end
        return v
      end,
      hidden = function() return data.grow == "CUSTOM" end,
      disabled = function() return not data.useAnchorPerUnit end
    },
    anchorOn = {
      type = "input",
      width = WeakAuras.doubleWidth,
      name = L["Run on..."],
      desc = L["You can add a comma-separated list of state values here that (when changed) WeakAuras should also run the Anchor Code on.\n\nWeakAuras will always run custom anchor code if you include 'changed' in this list, or when a region is added, removed, or re-ordered."],
      order = 1.61,
      get = function()
        return data.anchorOn or ""
      end,
      hidden = function()
        return not(data.grow ~= "CUSTOM" and data.useAnchorPerUnit and data.anchorPerUnit == "CUSTOM")
      end,
      set = function(info, v)
        data.anchorOn = v
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end
    },
    -- custom grow option added below
    align = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Align"],
      order = 2,
      values = OptionsPrivate.Private.align_types,
      set = function(info, v)
        data.align = v
        local selfPoint = selfPoints[data.grow] or selfPoints.default
        if type(selfPoint) == "function" then
          selfPoint = selfPoint(data)
        end
        data.selfPoint = selfPoint
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end,
      hidden = function() return (data.grow == "CUSTOM" or data.grow == "LEFT" or data.grow == "RIGHT" or data.grow == "HORIZONTAL" or data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE" or data.grow == "GRID") end,
      disabled = function() return data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE" end
    },
    rotated_align = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Align"],
      order = 3,
      values = OptionsPrivate.Private.rotated_align_types,
      hidden = function() return (data.grow == "CUSTOM" or data.grow == "UP" or data.grow == "DOWN" or data.grow == "VERTICAL" or data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE" or data.grow == "GRID") end,
      get = function() return data.align; end,
      set = function(info, v)
        data.align = v
        local selfPoint = selfPoints[data.grow] or selfPoints.default
        if type(selfPoint) == "function" then
          selfPoint = selfPoint(data)
        end
        data.selfPoint = selfPoint
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end,
    },
    centerType = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Aura Order"],
      order = 3,
      values = function()
        if data.grow == "HORIZONTAL" then
         return OptionsPrivate.Private.centered_types_h
        else
          return OptionsPrivate.Private.centered_types_v
        end
      end,
      hidden = function() return data.grow ~= "HORIZONTAL" and data.grow ~= "VERTICAL" end,
    },
    -- circle grow options
    constantFactor = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Constant Factor"],
      order = 4,
      values = OptionsPrivate.Private.circular_group_constant_factor_types,
      hidden = function() return not(data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE") end
    },
    rotation = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Start Angle"],
      order = 5,
      min = 0,
      max = 360,
      bigStep = 3,
      hidden = function() return not(data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE") end
    },
    fullCircle = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Full Circle"],
      order = 7,
      hidden = function()
        return not(
          (data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE")
          and (data.constantFactor == "RADIUS" or data.constantFactor == "SPACING"))
        end
    },
    stepAngle = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Angle Between Auras"],
      order = 12,
      min = 0,
      max = 180,
      bigStep = 1,
      hidden = function()
        return not((data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE") and data.constantFactor == "ANGLE")
      end
    },
    arcLength = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Total Angle"],
      order = 8,
      min = 0,
      max = 360,
      bigStep = 3,
      disabled = function() return data.fullCircle end,
      hidden = function()
        return not(
          (data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE")
          and (data.constantFactor == "RADIUS" or data.constantFactor == "SPACING"))
        end
    },
    radius = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Radius"],
      order = 9,
      softMin = 0,
      softMax = 500,
      bigStep = 1,
      hidden = function()
        return not(
          (data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE")
          and (data.constantFactor == "RADIUS" or data.constantFactor == "ANGLE"))
        end
    },
    -- grid grow options
    gridType = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Grid direction"],
      order = 8,
      values = OptionsPrivate.Private.grid_types,
      hidden = function() return data.grow ~= "GRID" end,
      set = function(info, value)
        data.selfPoint = gridSelfPoints[value]
        data.gridType = value
        WeakAuras.Add(data)
        OptionsPrivate.ResetMoverSizer()
      end,
    },
    gridWidth = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = function()
        if not data.gridType then return "" end
        if data.gridType:find("^[RLH]") then
          return L["Row Width"]
        else
          return L["Column Height"]
        end
      end,
      order = 9,
      min = 1,
      softMax = 20,
      step = 1,
      hidden = function() return data.grow ~= "GRID" end,
    },
    rowSpace = {
      type = "range",
      control = "WeakAurasSpinBox",
      name = L["Row Space"],
      width = WeakAuras.normalWidth,
      order = 10,
      softMin = 0,
      softMax = 300,
      step = 1,
      hidden = function() return data.grow ~= "GRID" end,
    },
    columnSpace = {
      type = "range",
      control = "WeakAurasSpinBox",
      name = L["Column Space"],
      width = WeakAuras.normalWidth,
      order = 11,
      softMin = 0,
      softMax = 300,
      step = 1,
      hidden = function() return data.grow ~= "GRID" end,
    },
    -- generic grow options
    space = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Space"],
      order = 7,
      softMin = 0,
      softMax = 300,
      bigStep = 1,
      hidden = function()
        return not(
          data.grow == "LEFT" or data.grow == "RIGHT"
          or data.grow == "UP" or data.grow == "DOWN"
          or data.grow == "HORIZONTAL" or data.grow == "VERTICAL"
          or ((data.grow == "CIRCLE" or data.grow == "COUNTERCIRCLE")
              and (data.constantFactor == "SPACING")))
      end
    },
    stagger = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Stagger"],
      order = 8,
      min = -50,
      max = 50,
      step = 0.1,
      bigStep = 1,
      hidden = function()
        return data.grow == "CUSTOM"
            or data.grow == "CIRCLE"
            or data.grow == "COUNTERCIRCLE"
            or data.grow == "GRID"
      end
    },
    -- sort options
    sort = {
      type = "select",
      width = WeakAuras.doubleWidth,
      name = L["Sort"],
      order = 20,
      values = OptionsPrivate.Private.group_sort_types
    },
    sortOn = {
      type = "input",
      width = WeakAuras.doubleWidth,
      name = L["Run on..."],
      desc = L["You can add a comma-separated list of state values here that (when changed) WeakAuras should also run the sort code on.WeakAuras will always run custom sort code if you include 'changed' in this list, or when a region is added, removed."],
      order = 21 - 0.1,
      get = function()
        return data.sortOn or ""
      end,
      hidden = function() return data.sort ~= "custom" end,
      set = function(info, v)
        data.sortOn = v
        WeakAuras.Add(data)
        WeakAuras.ClearAndUpdateOptions(data.id)
        OptionsPrivate.ResetMoverSizer()
      end
    },
    -- custom sort option added below
    hybridPosition = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Hybrid Position"],
      order = 21,
      values = OptionsPrivate.Private.group_hybrid_position_types,
      hidden = function() return not(data.sort == "hybrid") end,
    },
    hybridSortMode = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Hybrid Sort Mode"],
      order = 22,
      values = OptionsPrivate.Private.group_hybrid_sort_types,
      hidden = function() return not(data.sort == "hybrid") end,
    },
    sortHybrid = {
      type = "multiselect",
      width = "full",
      name = L["Select the auras you always want to be listed first"],
      order = 23,
      hidden = function() return not(data.sort == "hybrid") end,
      values = function()
        return data.controlledChildren
      end,
      get = function(info, index)
        local id = data.controlledChildren[index]
        return data.sortHybridTable and data.sortHybridTable[id] or false;
      end,
      set = function(info, index)
        if not data.sortHybridTable then data.sortHybridTable = {}; end
        local id = data.controlledChildren[index]
        local cur = data.sortHybridTable and data.sortHybridTable[id] or false;
        data.sortHybridTable[id] = not(cur);
      end,
    },
    sortSpace = {
      type = "description",
      name = "",
      width = WeakAuras.doubleWidth,
      order = 24,
      hidden = function() return data.sort == "hybrid" end
    },
    useLimit = {
      type = "toggle",
      order = 25,
      width = WeakAuras.normalWidth,
      name = L["Limit"],
      hidden = function() return data.grow == "CUSTOM" end,
    },
    limit = {
      type = "range",
      control = "WeakAurasSpinBox",
      order = 26,
      width = WeakAuras.normalWidth,
      name = L["Limit"],
      min = 0,
      softMax = 20,
      step = 1,
      disabled = function() return not data.useLimit end,
      hidden = function() return data.grow == "CUSTOM" end,
    },
    animate = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Animated Expand and Collapse"],
      order = 27
    },
    spacer = {
      type = "description",
      width = WeakAuras.normalWidth,
      name = "",
      order = 27.5
    },
    scale = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Group Scale"],
      order = 28,
      min = 0.05,
      softMax = 2,
      max = 10,
      bigStep = 0.05,
      get = function()
        return data.scale or 1
      end,
      set = function(info, v)
        data.scale = data.scale or 1
        local change = 1 - (v/data.scale)
        data.xOffset = data.xOffset/(1-change)
        data.yOffset = data.yOffset/(1-change)
        data.scale = v
        WeakAuras.Add(data);
        OptionsPrivate.ResetMoverSizer();
      end
    },
    alpha = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Group Alpha"],
      order = 29,
      min = 0,
      max = 1,
      bigStep = 0.01,
      isPercent = true
    },
    sharedFrameLevel = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Flat Framelevels"],
      desc = L["The group and all direct children will share the same base frame level."],
      order = 30,
      set = function(info, v)
        data.sharedFrameLevel = v
        WeakAuras.Add(data)
        for parent in OptionsPrivate.Private.TraverseParents(data) do
          WeakAuras.Add(parent)
        end
      end
    },
    endHeader = {
      type = "header",
      order = 100,
      name = "",
    },
  };

  OptionsPrivate.commonOptions.AddCodeOption(options, data, L["Custom Grow"], "custom_grow", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#grow",
                          2, function() return data.grow ~= "CUSTOM" end, {"customGrow"}, false, { setOnParent = true })
  OptionsPrivate.commonOptions.AddCodeOption(options, data, L["Custom Sort"], "custom_sort", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#custom-sort",
                          21, function() return data.sort ~= "custom" end, {"customSort"}, false, { setOnParent = true })
  OptionsPrivate.commonOptions.AddCodeOption(options, data, L["Custom Anchor"], "custom_anchor_per_unit", "https://github.com/WeakAuras/WeakAuras2/wiki/Custom-Code-Blocks#group-by-frame",
                          1.7, function() return not(data.grow ~= "CUSTOM" and data.useAnchorPerUnit and data.anchorPerUnit == "CUSTOM") end, {"customAnchorPerUnit"}, false, { setOnParent = true })

  local borderHideFunc = function() return data.useAnchorPerUnit end
  local disableSelfPoint = function() return data.grow ~= "CUSTOM" and data.grow ~= "GRID" and not data.useAnchorPerUnit end

  for k, v in pairs(OptionsPrivate.commonOptions.BorderOptions(id, data, nil, borderHideFunc, 70)) do
    options[k] = v
  end

  return {
    dynamicgroup = options,
    position = OptionsPrivate.commonOptions.PositionOptions(id, data, nil, true, disableSelfPoint, true),
  };
end

local function createThumbnail()
  -- frame
  local thumbnail = CreateFrame("Frame", nil, UIParent);
  thumbnail:SetWidth(32);
  thumbnail:SetHeight(32);

  -- border
  local border = thumbnail:CreateTexture(nil, "OVERLAY");
  border:SetAllPoints(thumbnail);
  border:SetTexture("Interface\\BUTTONS\\UI-Quickslot2.blp");
  border:SetTexCoord(0.2, 0.8, 0.2, 0.8);

  return thumbnail
end

local function defaultIconAnimation(self, elapsed)
  self.elapsed = self.elapsed + elapsed
  if(self.elapsed < 0.5) then
    self.t2:SetPoint("TOP", self.t1, "BOTTOM", 0, -2 + (28 * self.elapsed))
    self.t2:SetAlpha(1 - (2 * self.elapsed))
  elseif(self.elapsed < 1.5) then
  -- do nothing
  elseif(self.elapsed < 2) then
    self.t2:SetPoint("TOP", self.t1, "BOTTOM", 0, -2 + (28 * (2 - self.elapsed)))
    self.t2:SetAlpha((2 * self.elapsed) - 3)
  elseif(self.elapsed < 3) then
  -- do nothing
  else
    self.elapsed = self.elapsed - 3
  end
end

local function createAnimatedDefaultIcon(parent)
  local defaultIcon = CreateFrame("Frame", nil, parent);
  parent.defaultIcon = defaultIcon;

  local t1 = defaultIcon:CreateTexture(nil, "ARTWORK");
  t1:SetWidth(24);
  t1:SetHeight(6);
  t1:SetTexture(0.8, 0, 0);
  t1:SetPoint("TOP", parent, "TOP", 0, -6);
  local t2 = defaultIcon:CreateTexture(nil, "ARTWORK");
  t2:SetWidth(12);
  t2:SetHeight(12);
  t2:SetTexture(0.2, 0.8, 0.2);
  t2:SetPoint("TOP", t1, "BOTTOM", 0, -2);
  local t3 = defaultIcon:CreateTexture(nil, "ARTWORK");
  t3:SetWidth(30);
  t3:SetHeight(4);
  t3:SetTexture(0.1, 0.25, 1);
  t3:SetPoint("TOP", t2, "BOTTOM", 0, -2);
  local t4 = defaultIcon:CreateTexture(nil, "OVERLAY");
  t4:SetWidth(1);
  t4:SetHeight(36);
  t4:SetTexture(1, 1, 1);
  t4:SetPoint("CENTER", parent, "CENTER");

  defaultIcon.t1 = t1
  defaultIcon.t2 = t2

  defaultIcon.elapsed = 0;
  defaultIcon:SetScript("OnUpdate", defaultIconAnimation)
  defaultIcon:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
  defaultIcon:SetScript("OnShow", function(self) self:SetScript("OnUpdate", defaultIconAnimation) end)

  return defaultIcon
end

-- Modify preview thumbnail
local function modifyThumbnail(parent, frame, data)
  function frame:SetIcon(path)
    if not frame.icon then
      local icon = frame:CreateTexture(nil, "OVERLAY")
      icon:SetAllPoints(frame)
      frame.icon = icon
    end
    local success = OptionsPrivate.Private.SetTextureOrSpellTexture(frame.icon, path or data.groupIcon) and (path or data.groupIcon)
    if success then
      if frame.defaultIcon then
        frame.defaultIcon:Hide()
      end
      frame.icon:Show()
    else
      if frame.icon then
        frame.icon:Hide()
      end
      if not frame.defaultIcon then
        frame.defaultIcon = createAnimatedDefaultIcon(frame)
      end
      frame.defaultIcon:Show()
    end
  end
  frame:SetIcon()
end

local function createIcon()
  local thumbnail = createThumbnail()
  thumbnail.defaultIcon = createAnimatedDefaultIcon(thumbnail)
  return thumbnail
end

OptionsPrivate.registerRegions = OptionsPrivate.registerRegions or {}
table.insert(OptionsPrivate.registerRegions, function()
  OptionsPrivate.Private.RegisterRegionOptions("dynamicgroup", createOptions, createIcon, L["Dynamic Group"], createThumbnail, modifyThumbnail, L["A group that dynamically controls the positioning of its children"]);
end)

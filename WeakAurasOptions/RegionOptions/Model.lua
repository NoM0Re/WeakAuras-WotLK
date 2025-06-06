if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local OptionsPrivate = select(2, ...)

local L = WeakAuras.L;

local function createOptions(id, data)
  local options = {
    __title = L["Model Settings"],
    __order = 1,
    modelIsUnit = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Show model of unit "],
      order = 0.5,
      hidden = function() return data.modelDisplayInfo and WeakAuras.BuildInfo > 80100 end
    },
    modelDisplayInfo = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Use Display Info Id"],
      order = 0.6,
      hidden = function() return data.modelIsUnit end
    },
    model_model_path = {
      type = "input",
      width = WeakAuras.doubleWidth - 0.15,
      name = L["Model"],
      order = 1
    },
    chooseModel = {
      type = "execute",
      width = 0.15,
      name = L["Choose"],
      order = 2,
      func = function()
        OptionsPrivate.OpenModelPicker(data, {});
      end,
      disabled = function() return data.modelIsUnit end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    advance = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Animate"],
      order = 5,
    },
    sequence = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Animation Sequence"],
      min = 0,
      softMax = 150,
      step = 1,
      bigStep = 1,
      order = 6,
      disabled = function() return not data.advance end
    },
    model_z = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Z Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 20,
    },
    model_x = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["X Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 30,
    },
    model_y = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Y Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 40,
    },
    rotation = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 45,
    },
    alpha = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Alpha"],
      order = 50,
      min = 0,
      max = 1,
      bigStep = 0.01,
      isPercent = true
    },
    endHeader = {
      type = "header",
      order = 100,
      name = "",
    },
  };

  for k, v in pairs(OptionsPrivate.commonOptions.BorderOptions(id, data, nil, nil, 70)) do
    options[k] = v
  end

  return {
    model = options,
    position = OptionsPrivate.commonOptions.PositionOptions(id, data, nil, nil, nil),
  };
end

local function createThumbnail()
  local borderframe = CreateFrame("Frame", nil, UIParent);
  borderframe:SetWidth(32);
  borderframe:SetHeight(32);

  local border = borderframe:CreateTexture(nil, "Overlay");
  border:SetAllPoints(borderframe);
  border:SetTexture("Interface\\BUTTONS\\UI-Quickslot2.blp");
  border:SetTexCoord(0.2, 0.8, 0.2, 0.8);

  local model = CreateFrame("PlayerModel", nil, borderframe);
  borderframe.model = model;
  model:SetFrameStrata("FULLSCREEN");

  return borderframe;
end

local function modifyThumbnail(parent, region, data)
  region:SetParent(parent)

  local model = region.model
  region:SetScript("OnUpdate", function()
    local optionsFrame = OptionsPrivate.Private.OptionsFrame();
    if optionsFrame then
      model:SetParent(optionsFrame)
      region:SetScript("OnUpdate", nil)
    end
  end);
  model:SetAllPoints(region);
  model:SetFrameStrata(region:GetParent():GetFrameStrata());
  model:SetWidth(region:GetWidth() - 2);
  model:SetHeight(region:GetHeight() - 2);
  model:SetPoint("center", region, "center");
  WeakAuras.SetModel(model, data.model_path, data.modelIsUnit, data.modelDisplayInfo)
  model:SetScript("OnShow", function()
    WeakAuras.SetModel(model, data.model_path, data.modelIsUnit, data.modelDisplayInfo)
    model:SetPosition(data.model_z, data.model_x, data.model_y);
    model:SetFacing(rad(data.rotation));
  end);
  region:SetScript("OnShow", function() model:Show() end);
  region:SetScript("OnHide", function() model:Hide() end);

  model:SetPosition(data.model_z, data.model_x, data.model_y);
  model:SetFacing(rad(data.rotation));
end

local function createIcon()
  local data = {
    model_path = "Creature/Arthaslichking/arthaslichking.m2",
    modelIsUnit = false,
    model_x = 0,
    model_y = 0,
    model_z = 0.35,
    sequence = 1,
    advance = false,
    rotation = 0,
    scale = 1,
    height = 40,
    width = 40
  };

  local thumbnail = createThumbnail();
  modifyThumbnail(UIParent, thumbnail, data);

  return thumbnail;
end

local templates = {
  {
    title = L["Default"],
    data = {
    };
  }
}

tinsert(templates, {
  title = L["Fire Orb"],
  description = "",
  data = {
    width = 100,
    height = 100,
    model_path = "spells/6fx_smallfire.m2",
    model_x = 0,
    model_y = -0.5,
    model_z = -1.5
  },
})
tinsert(templates, {
  title = L["Blue Sparkle Orb"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_druid_halfmoon_missile.m2",
    model_x = 0,
    model_y = 0.7,
    model_z = 1.5
  },
})
tinsert(templates, {
  title = L["Arcane Orb"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/proc_arcane_impact_low.m2",
    model_x = 0,
    model_y = 0.8,
    model_z = 2
  },
})
tinsert(templates, {
  title = L["Orange Rune"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_godking_orangerune_state.m2",
  },
})
tinsert(templates, {
  title = L["Blue Rune"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_godking_bluerune_state.m2",
  }
})
tinsert(templates, {
  title = L["Yellow Rune"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_godking_yellowrune_state.m2",
  }
})
tinsert(templates, {
  title = L["Purple Rune"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_godking_purplerune_state.m2",
  }
})
tinsert(templates, {
  title = L["Green Rune"],
  description = "",
  data = {
    width = 100,
    height = 100,
    advance = true,
    sequence = 1,
    model_path = "spells/7fx_godking_greenrune_state.m2",
  }
})

OptionsPrivate.registerRegions = OptionsPrivate.registerRegions or {}
table.insert(OptionsPrivate.registerRegions, function()
  OptionsPrivate.Private.RegisterRegionOptions("model", createOptions, createIcon, L["Model"], createThumbnail, modifyThumbnail,
                                  L["Shows a 3D model from the game files"], templates);
end)

if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)

local L = WeakAuras.L;

local function createOptions(id, data)
  local options = {
    __title = L["Progress Texture Settings"],
    __order = 1,
    foregroundTexture = {
      width = WeakAuras.normalWidth - 0.15,
      type = "input",
      name = L["Foreground Texture"],
      order = 1
    },
    chooseForegroundTexture = {
      type = "execute",
      name = L["Choose"],
      width = 0.15,
      order = 2,
      func = function()
        local path = {}
        local paths = {}
        for child in OptionsPrivate.Private.TraverseLeafsOrAura(data) do
          paths[child.id] = path
        end
        OptionsPrivate.OpenTexturePicker(data, paths, {
          texture = "foregroundTexture",
          color = "foregroundColor",
          texRotation = "rotation",
          auraRotation = "auraRotation",
          mirror = "mirror",
          blendMode = "blendMode"
        }, OptionsPrivate.Private.texture_types, nil, true)
      end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    backgroundTexture = {
      type = "input",
      width = WeakAuras.normalWidth - 0.15,
      name = L["Background Texture"],
      order = 5,
      disabled = function() return data.sameTexture; end,
      get = function() return data.sameTexture and data.foregroundTexture or data.backgroundTexture; end
    },
    chooseBackgroundTexture = {
      type = "execute",
      name = L["Choose"],
      width = 0.15,
      order = 6,
      func = function()
        local path = {}
        local paths = {}
        for child in OptionsPrivate.Private.TraverseLeafsOrAura(data) do
          paths[child.id] = path
        end
        OptionsPrivate.OpenTexturePicker(data, paths, {
          texture = "backgroundTexture",
          color = "backgroundColor",
          texRotation = "rotation",
          auraRotation = "auraRotation",
          mirror = "mirror",
          blendMode = "blendMode"
        }, OptionsPrivate.Private.texture_types, nil, true)
      end,
      disabled = function() return data.sameTexture; end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    mirror = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Mirror"],
      order = 10,
      disabled = function() return data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE"; end
    },
    sameTexture = {
      type = "toggle",
      name = L["Same"],
      width = WeakAuras.normalWidth,
      order = 15
    },
    desaturateForeground = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Desaturate"],
      order = 17.5,
    },
    desaturateBackground = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Desaturate"],
      order = 17.6,
    },
    blendMode = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Blend Mode"],
      order = 20,
      values = OptionsPrivate.Private.blend_types
    },
    backgroundOffset = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Background Offset"],
      min = 0,
      softMax = 25,
      bigStep = 1,
      order = 25
    },
    orientation = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Orientation"],
      order = 35,
      values = OptionsPrivate.Private.orientation_with_circle_types
    },
    compress = {
      type = "toggle",
      width = WeakAuras.halfWidth,
      name = L["Compress"],
      order = 40,
      disabled = function() return data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE"; end
    },
    inverse = {
      type = "toggle",
      width = WeakAuras.halfWidth,
      name = L["Inverse"],
      order = 41
    },
    foregroundColor = {
      type = "color",
      width = WeakAuras.normalWidth,
      name = L["Foreground Color"],
      hasAlpha = true,
      order = 30
    },
    backgroundColor = {
      type = "color",
      width = WeakAuras.normalWidth,
      name = L["Background Color"],
      hasAlpha = true,
      order = 37
    },
    user_x = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      order = 42,
      name = L["Re-center X"],
      min = -0.5,
      max = 0.5,
      bigStep = 0.01,
      hidden = function() return data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE"; end
    },
    user_y = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      order = 44,
      name = L["Re-center Y"],
      min = -0.5,
      max = 0.5,
      bigStep = 0.01,
      hidden = function() return data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE"; end
    },
    startAngle = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      order = 42,
      name = L["Start Angle"],
      min = 0,
      max = 360,
      bigStep = 1,
      hidden = function() return data.orientation ~= "CLOCKWISE" and data.orientation ~= "ANTICLOCKWISE"; end
    },
    endAngle = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      order = 44,
      name = L["End Angle"],
      min = 0,
      max = 360,
      bigStep = 1,
      hidden = function() return data.orientation ~= "CLOCKWISE" and data.orientation ~= "ANTICLOCKWISE"; end
    },
    crop_x = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Crop X"],
      order = 46,
      min = 0,
      softMax = 2,
      bigStep = 0.01,
      isPercent = true,
      set = function(info, v)
        data.width = data.width * ((1 + data.crop_x) / (1 + v));
        data.crop_x = v;
        WeakAuras.Add(data);
        WeakAuras.UpdateThumbnail(data);
        OptionsPrivate.ResetMoverSizer();
      end,
    },
    crop_y = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Crop Y"],
      order = 47,
      min = 0,
      softMax = 2,
      bigStep = 0.01,
      isPercent = true,
      set = function(info, v)
        data.height = data.height * ((1 + data.crop_y) / (1 + v));
        data.crop_y = v;
        WeakAuras.Add(data);
        WeakAuras.UpdateThumbnail(data);
        OptionsPrivate.ResetMoverSizer();
      end,
    },
    alpha = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Alpha"],
      order = 48,
      min = 0,
      max = 1,
      bigStep = 0.01,
      isPercent = true
    },
    rotation = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Texture Rotation"],
      desc = L["Uses Texture Coordinates to rotate the texture."],
      order = 52,
      min = 0,
      max = 360,
      bigStep = 1
    },
    auraRotation = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Rotation"],
      order = 53,
      min = 0,
      max = 360,
      bigStep = 1
    },
    smoothProgress = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Smooth Progress"],
      desc = L["Animates progress changes"],
      order = 55.1
    },
    --[[
    textureWrapMode = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Texture Wrap"],
      order = 55.2,
      values = OptionsPrivate.Private.texture_wrap_types
    },
    ]]
    slanted = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Slanted"],
      order = 55.3,
      hidden = function() return data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE"; end
    },
    slant = {
      type = "range",
      control = "WeakAurasSpinBox",
      width = WeakAuras.normalWidth,
      name = L["Slant Amount"],
      order = 55.4,
      min = 0,
      max = 1,
      bigStep = 0.1,
      hidden = function() return not data.slanted or data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE" end
    },
    slantFirst = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Inverse Slant"],
      order = 55.5,
      hidden = function() return not data.slanted or data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE" end
    },
    slantMode = {
      type = "select",
      width = WeakAuras.normalWidth,
      name = L["Slant Mode"],
      order = 55.6,
      hidden = function() return not data.slanted or data.orientation == "CLOCKWISE" or data.orientation == "ANTICLOCKWISE" end,
      values = OptionsPrivate.Private.slant_mode
    },
    endHeader = {
      type = "header",
      order = 100,
      name = "",
    },
  };

  local overlayInfo = OptionsPrivate.Private.GetOverlayInfo(data);
  if (overlayInfo and next(overlayInfo)) then
    options["overlayheader"] = {
      type = "header",
      name = L["Overlays"],
      order = 58
    }
    local index = 58.01
    for id, display in ipairs(overlayInfo) do
      options["overlaycolor" .. id] = {
        type = "color",
        width = WeakAuras.normalWidth,
        name = string.format(L["%s Color"], display),
        hasAlpha = true,
        order = index,
        get = function()
          if (data.overlays and data.overlays[id]) then
            return unpack(data.overlays[id]);
          end
          return 1, 1, 1, 1;
        end,
        set = function(info, r, g, b, a)
          if (not data.overlays) then
            data.overlays = {};
          end
          data.overlays[id] = { r, g, b, a};
          WeakAuras.Add(data);
        end
      }
      index = index + 0.01
    end

    options["overlayclip"] = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Clip Overlays"],
      order = index
    }
  end

  return {
    progresstexture = options,
    progressOptions = OptionsPrivate.commonOptions.ProgressOptions(data),
    position = OptionsPrivate.commonOptions.PositionOptions(id, data),
  };
end

-- Credit to CommanderSirow for taking the time to properly craft the ApplyTransform function
-- to the enhance the abilities of Progress Textures.

-- NOTES:
--  Most SetValue() changes are quite equal (among compress/non-compress)
--  (There is no GUI button for mirror_v, but mirror_h)
--  New/Used variables
--   region.user_x (0) - User defined center x-shift [-1, 1]
--   region.user_y (0) - User defined center y-shift [-1, 1]
--   region.mirror_v (false) - Mirroring along x-axis [bool]
--   region.mirror_h (false) - Mirroring along y-axis [bool]
--   region.cos_rotation (1) - cos(ANGLE), precalculated cos-function for given ANGLE [-1, 1]
--   region.sin_rotation (0) - sin(ANGLE), precalculated cos-function for given ANGLE [-1, 1]
--   region.scale (1.0) - user defined scaling [1, INF]
--   region.full_rotation (false) - Allow full rotation [bool]


local function ApplyTransform(x, y, region)
  -- 1) Translate texture-coords to user-defined center
  x = x - 0.5
  y = y - 0.5

  -- 2) Shrink texture by 1/sqrt(2)
  x = x * 1.4142
  y = y * 1.4142

  -- 3) Scale texture by user-defined amount
  x = x / region.scale_x
  y = y / region.scale_y

  -- 4) Apply mirroring if defined
  if region.mirror_h then
    x = -x
  end
  if region.mirror_v then
    y = -y
  end

  -- 5) Rotate texture by user-defined value
  x, y = region.cos_rotation * x - region.sin_rotation * y, region.sin_rotation * x + region.cos_rotation * y

  -- 6) Translate texture-coords back to (0,0)
  x = x + 0.5 + region.user_x
  y = y + 0.5 + region.user_y

  -- Return results
  return x, y
end

local function Transform(tx, x, y, angle, aspect) -- Translates texture to x, y and rotates about its center
  local c, s = cos(angle), sin(angle)
  y = y / aspect
  local oy = 0.5 / aspect
  local ULx, ULy = 0.5 + (x - 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x - 0.5) * s) * aspect
  local LLx, LLy = 0.5 + (x - 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x - 0.5) * s) * aspect
  local URx, URy = 0.5 + (x + 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x + 0.5) * s) * aspect
  local LRx, LRy = 0.5 + (x + 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x + 0.5) * s) * aspect
  tx:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

local function createThumbnail()
  local borderframe = CreateFrame("Frame", nil, UIParent);
  borderframe:SetWidth(32);
  borderframe:SetHeight(32);

  local border = borderframe:CreateTexture(nil, "OVERLAY");
  border:SetAllPoints(borderframe);
  border:SetTexture("Interface\\BUTTONS\\UI-Quickslot2.blp");
  border:SetTexCoord(0.2, 0.8, 0.2, 0.8);

  local region = CreateFrame("Frame", nil, borderframe);
  borderframe.region = region;
  region:SetWidth(32);
  region:SetHeight(32);

  borderframe.background = OptionsPrivate.Private.LinearProgressTextureBase.create(region, "BACKGROUND", 0)
  borderframe.foreground = OptionsPrivate.Private.LinearProgressTextureBase.create(region, "ARTWORK", 0)
  borderframe.backgroundSpinner = OptionsPrivate.Private.CircularProgressTextureBase.create(region, "BACKGROUND", 1)
  borderframe.foregroundSpinner = OptionsPrivate.Private.CircularProgressTextureBase.create(region, "ARTWORK", 1)

  return borderframe;
end

local function modifyThumbnail(parent, borderframe, data, fullModify, size)
  local region, background, foreground = borderframe.region, borderframe.background, borderframe.foreground;
  local foregroundSpinner, backgroundSpinner = borderframe.foregroundSpinner, borderframe.backgroundSpinner;

  size = size or 30;
  local scale;
  if(data.height > data.width) then
    scale = size/data.height;
    region:SetWidth(scale * data.width);
    region:SetHeight(size);
    region.width = scale * data.width;
    region.height = size;
  else
    scale = size/data.width;
    region:SetWidth(size);
    region:SetHeight(scale * data.height);
    region.width = size;
    region.height = scale * data.height;
  end

  region:ClearAllPoints();
  region:SetPoint("CENTER", borderframe, "CENTER");

  local crop_x = 1 + (data.crop_x or 0.41)
  local crop_y = 1 + (data.crop_y or 0.41)
  local user_x = -1 * (data.user_x or 0)
  local user_y = data.user_y or 0
  local auraRotationRadians = (data.auraRotation or 0) / 180 * math.pi
  local texRotation = data.rotation or 0
  local textureWrapMode = data.textureWrapMode or "CLAMPTOBLACKADDITIVE"

  OptionsPrivate.Private.LinearProgressTextureBase.modify(background, {
    offset = 0,
    texture = data.sameTexture and data.foregroundTexture or data.backgroundTexture,
    textureWrapMode = textureWrapMode,
    desaturated = data.desaturateBackground,
    blendMode = data.blendMode,
    auraRotation = auraRotationRadians,
    crop_x = crop_x,
    crop_y = crop_y,
    user_x = user_x,
    user_y = user_y,
    mirror = data.mirror,
    texRotation = texRotation,
    width = region.width,
    height = region.height
  })
  background:SetColor(data.backgroundColor[1], data.backgroundColor[2], data.backgroundColor[3], data.backgroundColor[4])

  OptionsPrivate.Private.LinearProgressTextureBase.modify(foreground, {
    offset = 0,
    texture = data.foregroundTexture,
    textureWrapMode = textureWrapMode,
    desaturated = data.desaturateForeground,
    blendMode = data.blendMode,
    auraRotation = auraRotationRadians,
    crop_x = crop_x,
    crop_y = crop_y,
    user_x = user_x,
    user_y = user_y,
    mirror = data.mirror,
    texRotation = texRotation,
    width = region.width,
    height = region.height
  })
  foreground:SetColor(data.foregroundColor[1], data.foregroundColor[2], data.foregroundColor[3], data.foregroundColor[4])

  OptionsPrivate.Private.CircularProgressTextureBase.modify(backgroundSpinner, {
    crop_x = crop_x,
    crop_y = crop_y,
    mirror = data.mirror,
    texRotation = texRotation,
    texture = data.sameTexture and data.foregroundTexture or data.backgroundTexture,
    blendMode = data.blendMode,
    desaturated = data.desaturateBackground,
    auraRotation = auraRotationRadians,
    width = region.width,
    height = region.height,
    offset = data.backgroundOffset or 0
  })
  backgroundSpinner:SetColor(data.backgroundColor[1], data.backgroundColor[2], data.backgroundColor[3], data.backgroundColor[4])

  OptionsPrivate.Private.CircularProgressTextureBase.modify(foregroundSpinner, {
    crop_x = crop_x,
    crop_y = crop_y,
    mirror = data.mirror,
    texRotation = texRotation,
    texture = data.foregroundTexture,
    blendMode = data.blendMode,
    desaturated = data.desaturateForeground,
    auraRotation = auraRotationRadians,
    width = region.width,
    height = region.height,
    offset = 0
  })
  foregroundSpinner:SetColor(data.foregroundColor[1], data.foregroundColor[2], data.foregroundColor[3], data.foregroundColor[4])

  local function orientHorizontal()
    background:SetOrientation("HORIZONTAL_INVERSE", nil, data.slanted, data.slant, data.slantFirst, data.slantMode)
    foreground:SetOrientation("HORIZONTAL_INVERSE", data.compress, data.slanted, data.slant, data.slantFirst, data.slantMode)
  end
  local function orientHorizontalInverse()
    background:SetOrientation("HORIZONTAL", nil, data.slanted, data.slant, data.slantFirst, data.slantMode)
    foreground:SetOrientation("HORIZONTAL", data.compress, data.slanted, data.slant, data.slantFirst, data.slantMode)
  end
  local function orientVertical()
    background:SetOrientation("VERTICAL_INVERSE", nil, data.slanted, data.slant, data.slantFirst, data.slantMode)
    foreground:SetOrientation("VERTICAL_INVERSE", data.compress, data.slanted, data.slant, data.slantFirst, data.slantMode)
  end
  local function orientVerticalInverse()
    background:SetOrientation("VERTICAL", nil, data.slanted, data.slant, data.slantFirst, data.slantMode)
    foreground:SetOrientation("VERTICAL", data.compress, data.slanted, data.slant, data.slantFirst, data.slantMode)
  end

  local function orientCircular(clockwise)
    local startAngle = data.startAngle % 360;
    local endAngle = data.endAngle % 360;

    if (endAngle <= startAngle) then
      endAngle = endAngle + 360;
    end

    backgroundSpinner:SetWidth(30)
    backgroundSpinner:SetHeight(30)
    foregroundSpinner:SetWidth(30)
    foregroundSpinner:SetHeight(30)
    backgroundSpinner:SetClockwise(clockwise);
    foregroundSpinner:SetClockwise(clockwise);
    if (clockwise) then
      backgroundSpinner:SetProgress(startAngle, endAngle);
      foregroundSpinner:SetProgress(startAngle, endAngle);
    else
      backgroundSpinner:SetProgress(startAngle, endAngle, 1);
      foregroundSpinner:SetProgress(startAngle, endAngle, 1);
    end

    function region:SetValue(progress)
      region.progress = progress;

      if (progress < 0) then
        progress = 0;
      end

      if (progress > 1) then
        progress = 1;
      end

      local pAngle = (endAngle - startAngle) * progress + startAngle;

      if (clockwise) then
        foregroundSpinner:SetProgress(startAngle, pAngle);
      else
        foregroundSpinner:SetProgress(startAngle, endAngle, progress);
      end
    end
  end

  local function showCircularProgress()
    foreground:Hide();
    background:Hide();
    foregroundSpinner:Show();
    backgroundSpinner:Show();
  end

  local function hideCircularProgress()
    foreground:Show();
    background:Show();
    foregroundSpinner:Hide();
    backgroundSpinner:Hide();
    function region:SetValue(progress)
      region.progress = progress;
      progress = max(0, min(1, progress or 0));
      background:SetValue(0, 1);
      foreground:SetValue(0, progress);
    end
  end

  if(data.orientation == "HORIZONTAL_INVERSE") then
    hideCircularProgress();
    orientHorizontalInverse();
  elseif(data.orientation == "HORIZONTAL") then
    hideCircularProgress();
    orientHorizontal();
  elseif(data.orientation == "VERTICAL_INVERSE") then
    hideCircularProgress();
    orientVerticalInverse();
  elseif(data.orientation == "VERTICAL") then
    hideCircularProgress();
    orientVertical();
  elseif(data.orientation == "CLOCKWISE") then
    showCircularProgress();
    orientCircular(true);
  elseif(data.orientation == "ANTICLOCKWISE") then
    showCircularProgress();
    orientCircular(false);
  end

  if (region.SetValue) then
    region:SetValue(3/5);
  end
end

local function createIcon()
  local data = {
    foregroundTexture = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
    backgroundTexture = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
    sameTexture = true,
    backgroundOffset = 2,
    blendMode = "BLEND",
    width = 200,
    height = 200,
    orientation = "VERTICAL",
    alpha = 1.0,
    foregroundColor = {1, 1, 1, 1},
    backgroundColor = {0.5, 0.5, 0.5, 0.5}
  };

  local thumbnail = createThumbnail();
  modifyThumbnail(UIParent, thumbnail, data, nil, 32);

  thumbnail.elapsed = 0;
  thumbnail:SetScript("OnUpdate", function(self, elapsed)
    thumbnail.elapsed = thumbnail.elapsed + elapsed;
    if(thumbnail.elapsed > 4) then
      thumbnail.elapsed = thumbnail.elapsed - 4;
    end
    thumbnail.region:SetValue((4 - thumbnail.elapsed) / 4);
  end);

  return thumbnail;
end

local templates = {
  {
    title = L["Default"],
    data = {
      inverse = true,
    };
  },
  {
    title = L["Top HUD position"],
    description = L["At the same position as Blizzard's spell alert"],
    data = {
      width = 200,
      height = 100,
      xOffset = 0,
      yOffset = 150,
      mirror = true,
      foregroundTexture = "Textures\\SpellActivationOverlays\\Backlash", -- "460830"
      orientation = "HORIZONTAL",
      inverse = true,
    },
  },
  {
    title = L["Left HUD position"],
    description = L["At the same position as Blizzard's spell alert"],
    data = {
      width = 100,
      height = 200,
      xOffset = -150,
      yOffset = 0,
      inverse = true,
    },
  },
  {
    title = L["Left 2 HUD position"],
    description = L["At a position a bit left of Left HUD position."],
    data = {
      width = 100,
      height = 200,
      xOffset = -200,
      yOffset = 0,
      inverse = true,
    },
  },
  {
    title = L["Right HUD position"],
    description = L["At the same position as Blizzard's spell alert"],
    data = {
      width = 100,
      height = 200,
      xOffset = 150,
      yOffset = 0,
      mirror = true,
      inverse = true,
    },
  },
  {
    title = L["Right 2 HUD position"],
    description = L["At a position a bit left of Right HUD position"],
    data = {
      width = 100,
      height = 200,
      xOffset = 200,
      yOffset = 0,
      mirror = true,
      inverse = true,
    },
  },
}

OptionsPrivate.registerRegions = OptionsPrivate.registerRegions or {}
table.insert(OptionsPrivate.registerRegions, function()
  OptionsPrivate.Private.RegisterRegionOptions("progresstexture", createOptions, createIcon, L["Progress Texture"], createThumbnail, modifyThumbnail, L["Shows a texture that changes based on duration"], templates);
end)

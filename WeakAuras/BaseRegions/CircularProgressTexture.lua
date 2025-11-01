if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local Private = select(2, ...)

local L = WeakAuras.L

Private.CircularProgressTextureBase = {}

local funcs = {
  SetAuraRotation = function (self, radians)
    for i = 1, 3 do
      self.textures[i]:SetRotation(radians)
    end
  end,
  SetTextureOrAtlas = function(self, texture)
    for i = 1, 4 do
      self.textures[i]:SetTexture(texture)
    end
    self.wedge:SetTexture(texture)
  end,
  SetDesaturated = function(self, desaturate)
    for i = 1, 4 do
      self.textures[i]:SetDesaturated(desaturate)
    end
    self.wedge:SetDesaturated(desaturate)
  end,
  SetBlendMode = function(self, blendMode)
    for i = 1, 4 do
      self.textures[i]:SetBlendMode(blendMode)
    end
    self.wedge:SetBlendMode(blendMode)
  end,
  Show = function(self)
    self.visible = true
    for i = 1, 4 do
      self.textures[i]:Show()
    end
    self.wedge:Show()
  end,
  Hide = function(self)
    self.visible = false
    for i = 1, 4 do
      self.textures[i]:Show()
    end
    self.wedge:Show()
  end,
  SetColor = function (self, r, g, b, a)
    for i = 1, 4 do
      self.textures[i]:SetVertexColor(r, g, b, a)
    end
    self.wedge:SetVertexColor(r, g, b, a)
  end,
  SetCropX = function(self, crop_x)
    self.crop_x = crop_x
    self:UpdateTextures()
  end,
  SetCropY = function(self, crop_y)
    self.crop_y = crop_y
    self:UpdateTextures()
  end,
  SetTexRotation = function(self, texRotation)
    self.texRotation = texRotation
    self:UpdateTextures()
  end,
  SetMirrorHV = function(self, mirror_h, mirror_v)
    self.mirror_h = mirror_h
    self.mirror_v = mirror_v
  end,
  SetMirror = function(self, mirror)
    self.mirror = mirror
    self:UpdateTextures()
  end,
  SetWidth = function(self, width)
    self.width = width
  end,
  SetHeight = function(self, height)
    self.height = height
  end,
  SetScale = function(self, scalex, scaley)
    self.scalex, self.scaley = scalex, scaley
  end,
  UpdateTextures = function(self)
    if not self.visible then
      return
    end
    local crop_x = self.crop_x or 1
    local crop_y = self.crop_y or 1
    local texRotation = self.texRotation or 0
    local mirror_h = self.mirror_h or false
    if self.mirror then
      mirror_h = not mirror_h
    end
    local mirror_v = self.mirror_v or false

    local width = self.width * (self.scalex or 1) + 2 * self.offset
    local height = self.height * (self.scaley or 1) + 2 * self.offset

    if width == 0 or height == 0 then
      return
    end

    local angle1 = self.angle1
    local angle2 = self.angle2

    if angle1 == nil or angle2 == nil then
      return
    end

    if (angle2 - angle1 >= 360) then
      -- SHOW everything
      self.coords[1]:SetFull() -- Set to default full coords
      self.coords[1]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v) -- transform to user settings
      self.coords[1]:Show()

      self.coords[2]:Hide()
      self.coords[3]:Hide()
      return
    end
    if (angle1 == angle2) then
      self.coords[1]:Hide()
      self.coords[2]:Hide()
      self.coords[3]:Hide()
      return
    end

    local index1 = floor((angle1 + 45) / 90)
    local index2 = floor((angle2 + 45) / 90)

    if (index1 + 1 >= index2) then
      self.coords[1]:SetAngle(width, height, angle1, angle2)
      self.coords[1]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[1]:Show()
      self.coords[2]:Hide()
      self.coords[3]:Hide()
    elseif(index1 + 3 >= index2) then
      local firstEndAngle = (index1 + 1) * 90 + 45
      self.coords[1]:SetAngle(width, height, angle1, firstEndAngle)
      self.coords[1]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[1]:Show()

      self.coords[2]:SetAngle(width, height, firstEndAngle, angle2)
      self.coords[2]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[2]:Show()

      self.coords[3]:Hide()
    else
      local firstEndAngle = (index1 + 1) * 90 + 45
      local secondEndAngle = firstEndAngle + 180

      self.coords[1]:SetAngle(width, height, angle1, firstEndAngle)
      self.coords[1]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[1]:Show()

      self.coords[2]:SetAngle(width, height, firstEndAngle, secondEndAngle)
      self.coords[2]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[2]:Show()

      self.coords[3]:SetAngle(width, height, secondEndAngle, angle2)
      self.coords[3]:Transform(crop_x, crop_y, texRotation, mirror_h, mirror_v)
      self.coords[3]:Show()
    end
  end,
  SetProgress = function (self, angle1, angle2)
    self.angle1 = angle1
    self.angle2 = angle2
    self:UpdateTextures()
  end,
}

function Private.CircularProgressTextureBase.create(frame, layer, drawLayer, frameLevel)
  local circularTexture = {}

  circularTexture.textures = {}
  circularTexture.coords = {}
  circularTexture.offset = 0
  circularTexture.visible = true

  local scrollframe = CreateFrame("ScrollFrame", nil, frame)
  scrollframe:SetPoint("BOTTOMLEFT", frame, "CENTER")
  scrollframe:SetPoint("TOPRIGHT")
  scrollframe:SetFrameLevel(frameLevel);

  local scrollchild = CreateFrame("Frame", nil, scrollframe)
  scrollframe:SetScrollChild(scrollchild)
  scrollchild:SetAllPoints(scrollframe)
  scrollchild:SetFrameLevel(frameLevel);

  local wedge = scrollchild:CreateTexture(nil, layer)
  wedge:SetPoint("BOTTOMRIGHT", frame, "CENTER")

  -- Top Right
  local trTexture = frame:CreateTexture(nil, layer)
  trTexture:SetPoint("BOTTOMLEFT", frame, "CENTER")
  trTexture:SetPoint("TOPRIGHT")
  trTexture:SetTexCoord(0.5, 1, 0, 0.5)

  -- Bottom Right
  local brTexture = frame:CreateTexture(nil, layer)
  brTexture:SetPoint("TOPLEFT", frame, "CENTER")
  brTexture:SetPoint("BOTTOMRIGHT")
  brTexture:SetTexCoord(0.5, 1, 0.5, 1)

  -- Bottom Left
  local blTexture = frame:CreateTexture(nil, layer)
  blTexture:SetPoint("TOPRIGHT", frame, "CENTER")
  blTexture:SetPoint("BOTTOMLEFT")
  blTexture:SetTexCoord(0, 0.5, 0.5, 1)

  -- Top Left
  local tlTexture = frame:CreateTexture(nil, layer)
  tlTexture:SetPoint("BOTTOMRIGHT", frame, "CENTER")
  tlTexture:SetPoint("TOPLEFT")
  tlTexture:SetTexCoord(0, 0.5, 0, 0.5)

  -- /4|1\ -- Clockwise texture arrangement
  -- \3|2/ --

  circularTexture.scrollframe = scrollframe
  circularTexture.wedge = wedge
  circularTexture.textures = {trTexture, brTexture, blTexture, tlTexture}

  for i, texture in ipairs(circularTexture.textures) do
    circularTexture.coords[i] = Private.TextureCoords.create(texture)
  end

  for funcName, func in pairs(funcs) do
    circularTexture[funcName] = func
  end

  circularTexture.parentFrame = frame

  return circularTexture
end

function Private.CircularProgressTextureBase.modify(circularTexture, options)
  circularTexture:SetTextureOrAtlas(options.texture)
  circularTexture:SetDesaturated(options.desaturated)
  circularTexture:SetBlendMode(options.blendMode)
  circularTexture:SetAuraRotation(options.auraRotation)
  circularTexture.crop_x = options.crop_x
  circularTexture.crop_y = options.crop_y
  circularTexture.mirror = options.mirror
  circularTexture.texRotation = options.texRotation
  circularTexture.width = options.width
  circularTexture.height = options.height
  circularTexture.offset = options.offset
  local offset = options.offset
  local frame = circularTexture.parentFrame
  if offset > 0 then
    for i = 1, 4 do
      circularTexture.textures[i]:ClearAllPoints()
      circularTexture.textures[i]:SetPoint('TOPRIGHT', frame, offset, offset)
      circularTexture.textures[i]:SetPoint('BOTTOMRIGHT', frame, offset, -offset)
      circularTexture.textures[i]:SetPoint('BOTTOMLEFT', frame, -offset, -offset)
      circularTexture.textures[i]:SetPoint('TOPLEFT', frame, -offset, offset)
    end
  else
    for i = 1, 3 do
      circularTexture.textures[i]:ClearAllPoints()
      circularTexture.textures[i]:SetAllPoints(frame)
    end
  end

  circularTexture:UpdateTextures()
end

if not WeakAuras.IsLibsOK() then return end

---@type string
local AddonName = ...
---@class Private
local Private = select(2, ...)

local L = WeakAuras.L

--- @class CircularProgressTextureBase
Private.CircularProgressTextureBase = {}

--- @class CircularProgressTextureInstance
--- @field crop_x number
--- @field crop_y number
--- @field mirror boolean
--- @field mirror_h boolean
--- @field mirror_v boolean
--- @field texRotation number
--- @field visible boolean
--- @field textures Texture[]
--- @field angle1 number
--- @field angle2 number
--- @field offset number
--- @field width number
--- @field height number
--- @field clockwise boolean
--- @field coords TextureCoords[]
--- @field scrollframe ScrollFrame Backport-only: clips the moving wedge for the active quadrant.
--- @field wedge Texture Backport-only: old 3.3.5a spinner wedge replacing Retail vertex offsets.

--- @class CircularProgressTextureOptions
--- @field crop_x number
--- @field crop_y number
--- @field mirror boolean
--- @field texRotation number
--- @field texture number|string
--- @field desaturated boolean
--- @field blendMode BlendMode
--- @field auraRotation number
--- @field width number
--- @field height number
--- @field offset number

local function ApplyTransform(x, y, self)
  return Private.TextureCoords.TransformPoint(x, y, self.crop_x or 1, self.crop_y or 1, self.texRotation or 0,
                                              self.mirror_h, self.mirror_v, 0, 0)
end

local function Transform(tx, x, y, angle, aspect) -- Translates texture to x, y and rotates around its center
  local c, s = cos(angle), sin(angle)
  y = y / aspect
  local oy = 0.5 / aspect

  local ULx, ULy = 0.5 + (x - 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x - 0.5) * s) * aspect
  local LLx, LLy = 0.5 + (x - 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x - 0.5) * s) * aspect
  local URx, URy = 0.5 + (x + 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x + 0.5) * s) * aspect
  local LRx, LRy = 0.5 + (x + 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x + 0.5) * s) * aspect
  tx:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

local function betweenAngles(low, high, needle1, needle2)
  if (low <= needle1 and needle1 <= high
    and low <= needle2 and needle2 <= high) then
    return true
  end

  needle1 = needle1 + 360
  needle2 = needle2 + 360
  if (low <= needle1 and needle1 <= high
    and low <= needle2 and needle2 <= high) then
    return true
  end
  return false
end

local function animRotate(object, degrees, anchor, regionRotate, aspect)
  if (not anchor) then
    anchor = "CENTER"
  end

  object.degrees = degrees
  object.regionRotate = regionRotate
  object.aspect = aspect

  -- Something to rotate
  -- Create AnimationGroup and rotation animation
  if (not object.animationGroup) then
    object.animationGroup = object:CreateAnimationGroup()
    object.animationGroup:SetLooping("REPEAT")
  end

  object.animationGroup.rotate = object.animationGroup.rotate or object.animationGroup:CreateAnimation("rotation")

  local rotate = object.animationGroup.rotate
  rotate:SetOrigin(anchor, 0, 0)
  rotate:SetDegrees(degrees)
  rotate:SetDuration(0)
  rotate:SetEndDelay(15) -- 2147483647
  Transform(object, -0.5, -0.5, -degrees + regionRotate, aspect)
  object.animationGroup:Play()
end

--- @class CircularProgressTextureInstance
local funcs = {
  --- @type fun(self: CircularProgressTextureInstance, radians: number)
  SetAuraRotation = function (self, radians)
    -- WotLK backport: for circular progress the old spinner already rotates the
    -- active wedge. Store the aura rotation and fold it into that path instead
    -- of calling Retail texture rotation on three full-size masks.
    self.auraRotation = radians or 0
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance, texture: number|string)
  SetTextureOrAtlas = function(self, texture)
    for i = 1, 4 do
      Private.SetTextureOrAtlas(self.textures[i], texture, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
    end
    Private.SetTextureOrAtlas(self.wedge, texture, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
  end,
  --- @type fun(self: CircularProgressTextureInstance, desaturated: boolean)
  SetDesaturated = function(self, desaturate)
    for i = 1, 4 do
      self.textures[i]:SetDesaturated(desaturate)
    end
    self.wedge:SetDesaturated(desaturate)
  end,
  --- @type fun(self: CircularProgressTextureInstance, blendMode: BlendMode)
  SetBlendMode = function(self, blendMode)
    for i = 1, 4 do
      self.textures[i]:SetBlendMode(blendMode)
    end
    self.wedge:SetBlendMode(blendMode)
  end,
  --- @type fun(self: CircularProgressTextureInstance)
  Show = function(self)
    self.visible = true
    for i = 1, 4 do
      self.textures[i]:Show()
    end
    self.wedge:Show()
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance)
  Hide = function(self)
    self.visible = false
    for i = 1, 4 do
      self.textures[i]:Hide()
    end
    self.wedge:Hide()
  end,
  --- @type fun(self: CircularProgressTextureInstance, r: number, g: number, b: number, a: number)
  SetColor = function (self, r, g, b, a)
    for i = 1, 4 do
      self.textures[i]:SetVertexColor(r, g, b, a)
    end
    self.wedge:SetVertexColor(r, g, b, a)
  end,
  --- @type fun(self: CircularProgressTextureInstance, crop_x: number)
  SetCropX = function(self, crop_x)
    self.crop_x = crop_x
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance, crop_y: number)
  SetCropY = function(self, crop_y)
    self.crop_y = crop_y
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance, texRotation: number)
  SetTexRotation = function(self, texRotation)
    self.texRotation = texRotation
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance, mirror_h: boolean, mirror_v: boolean)
  SetMirrorHV = function(self, mirror_h, mirror_v)
    self.mirror_h = mirror_h
    self.mirror_v = mirror_v
  end,
  --- @type fun(self: CircularProgressTextureInstance, mirror: boolean)
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
  --- @type fun(self: CircularProgressTextureInstance, clockwise: boolean)
  -- ?? do i need it?
  SetClockwise = function(self, clockwise)
    self.clockwise = clockwise
    self:UpdateTextures()
  end,
  --- @type fun(self: CircularProgressTextureInstance)
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

    local width = (self.width or 0) * (self.scalex or 1) + 2 * (self.offset or 0)
    local height = (self.height or 0) * (self.scaley or 1) + 2 * (self.offset or 0)

    if width == 0 or height == 0 then
      return
    end

    local angle1 = self.angle1
    local angle2 = self.angle2

    if angle1 == nil or angle2 == nil then
      return
    end

    -- WotLK backport: Retail splits the arc into up to three arbitrary
    -- TextureCoords objects and relies on Texture:SetVertexOffset to deform
    -- their geometry. That API does not exist on 3.3.5a, so the code path above
    -- is kept intact until the render backend boundary and then redirected into
    -- the old four-quadrant spinner + clipped wedge implementation.

    if (angle1 == angle2) then
      for i = 1, 4 do
        self.textures[i]:Hide()
      end
      self.scrollframe:Hide()
      self.wedge:Hide()
      return
    end

    self.wedge:Show()

    local clockwise = self.clockwise ~= false
    local startAngle = angle1 % 360
    local endAngle = angle2
    if (endAngle <= startAngle) then
      endAngle = endAngle + 360
    end

    local pAngle = endAngle

    for i = 1, 4 do
      local quadrantAngle2 = clockwise and i * 90 or (5 - i) * 90
      local quadrantAngle1 = quadrantAngle2 - 90

      if betweenAngles(startAngle, pAngle, quadrantAngle1, quadrantAngle2) then
        self.textures[i]:Show()
      else
        self.textures[i]:Hide()
      end
    end

    -- Move scrollframe/wedge to the proper quadrant
    local quadrant = floor(pAngle % 360 / 90) + 1
    if not clockwise then
      quadrant = 5 - quadrant
    end
    self.scrollframe:Hide()
    self.scrollframe:SetAllPoints(self.textures[quadrant])
    self.scrollframe:Show()

    local ULx, ULy = ApplyTransform(0, 0, self)
    local LLx, LLy = ApplyTransform(0, 1, self)
    local URx, URy = ApplyTransform(1, 0, self)
    local LRx, LRy = ApplyTransform(1, 1, self)

    local Lx, Ly = ApplyTransform(0, 0.5, self)
    local Tx, Ty = ApplyTransform(0.5, 0, self)
    local Bx, By = ApplyTransform(0.5, 1, self)
    local Rx, Ry = ApplyTransform(1, 0.5, self)
    local Cx, Cy = ApplyTransform(0.5, 0.5, self)

    self.textures[1]:SetTexCoord(Tx, Ty, Cx, Cy, URx, URy, Rx, Ry)
    self.textures[2]:SetTexCoord(Cx, Cy, Bx, By, Rx, Ry, LRx, LRy)
    self.textures[3]:SetTexCoord(Lx, Ly, LLx, LLy, Cx, Cy, Bx, By)
    self.textures[4]:SetTexCoord(ULx, ULy, Lx, Ly, Tx, Ty, Cx, Cy)

    local scaleWedge = 1 / 1.4142 * math.max(crop_x, crop_y)
    self.wedge:SetWidth(width * scaleWedge)
    self.wedge:SetHeight(height * scaleWedge)
    local degree = pAngle
    if not clockwise then
      degree = -degree + 90
    end
    animRotate(self.wedge, -degree, "BOTTOMRIGHT", self.auraRotation or 0, width / height)
  end,
  --- @type fun(self: CircularProgressTextureInstance, angle1: number, angle2: number)
  SetProgress = function (self, angle1, angle2)
    self.angle1 = angle1
    self.angle2 = angle2
    self:UpdateTextures()
  end,
}

--- @type fun(frame:Frame) : CircularProgressTextureInstance
function Private.CircularProgressTextureBase.create(frame, layer, drawLayer)
  local circularTexture = {}

  circularTexture.textures = {}
  circularTexture.coords = {}
  circularTexture.offset = 0
  circularTexture.visible = true
  circularTexture.clockwise = true

  -- WotLK backport: create the old four fixed quadrants plus a clipped wedge.
  -- Upstream creates three full-frame textures and deforms them with vertex
  -- offsets; those vertex offsets are the missing 3.3.5a API.
  local scrollframe = CreateFrame("ScrollFrame", nil, frame)
  scrollframe:SetPoint("BOTTOMLEFT", frame, "CENTER")
  scrollframe:SetPoint("TOPRIGHT")
  if drawLayer then
    scrollframe:SetFrameLevel(frame:GetFrameLevel() + drawLayer)
  end

  local scrollchild = CreateFrame("Frame", nil, scrollframe)
  scrollframe:SetScrollChild(scrollchild)
  scrollchild:SetAllPoints(scrollframe)
  if drawLayer then
    scrollchild:SetFrameLevel(frame:GetFrameLevel() + drawLayer)
  end

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

  for i = 1, 4 do
    circularTexture.coords[i] = Private.TextureCoords.create(circularTexture.textures[i])
  end

  for funcName, func in pairs(funcs) do
    circularTexture[funcName] = func
  end

  circularTexture.parentFrame = frame

  --- @cast circularTexture CircularProgressTextureInstance
  return circularTexture
end

--- @type fun(circularTexture: CircularProgressTextureInstance, options: CircularProgressTextureOptions)
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
    circularTexture.textures[1]:ClearAllPoints()
    circularTexture.textures[1]:SetPoint("BOTTOMLEFT", frame, "CENTER")
    circularTexture.textures[1]:SetPoint("TOPRIGHT", frame, offset, offset)
    circularTexture.textures[2]:ClearAllPoints()
    circularTexture.textures[2]:SetPoint("TOPLEFT", frame, "CENTER")
    circularTexture.textures[2]:SetPoint("BOTTOMRIGHT", frame, offset, -offset)
    circularTexture.textures[3]:ClearAllPoints()
    circularTexture.textures[3]:SetPoint("TOPRIGHT", frame, "CENTER")
    circularTexture.textures[3]:SetPoint("BOTTOMLEFT", frame, -offset, -offset)
    circularTexture.textures[4]:ClearAllPoints()
    circularTexture.textures[4]:SetPoint("BOTTOMRIGHT", frame, "CENTER")
    circularTexture.textures[4]:SetPoint("TOPLEFT", frame, -offset, offset)
  else
    circularTexture.textures[1]:ClearAllPoints()
    circularTexture.textures[1]:SetPoint("BOTTOMLEFT", frame, "CENTER")
    circularTexture.textures[1]:SetPoint("TOPRIGHT")
    circularTexture.textures[2]:ClearAllPoints()
    circularTexture.textures[2]:SetPoint("TOPLEFT", frame, "CENTER")
    circularTexture.textures[2]:SetPoint("BOTTOMRIGHT")
    circularTexture.textures[3]:ClearAllPoints()
    circularTexture.textures[3]:SetPoint("TOPRIGHT", frame, "CENTER")
    circularTexture.textures[3]:SetPoint("BOTTOMLEFT")
    circularTexture.textures[4]:ClearAllPoints()
    circularTexture.textures[4]:SetPoint("BOTTOMRIGHT", frame, "CENTER")
    circularTexture.textures[4]:SetPoint("TOPLEFT")
  end

  circularTexture:UpdateTextures()
end

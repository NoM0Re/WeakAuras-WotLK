if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local Private = select(2, ...)

local L = WeakAuras.L

Private.TextureBase = {}

local SQRT2 = sqrt(2)
local function GetRotatedPoints(degrees, scaleForFullRotate)
  local angle = rad(135 - degrees)
  local factor = scaleForFullRotate and 1 or SQRT2
  local vx = math.cos(angle) / factor
  local vy = math.sin(angle) / factor

  return 0.5+vx,0.5-vy , 0.5-vy,0.5-vx , 0.5+vy,0.5+vx , 0.5-vx,0.5+vy
end

local funcs = {
  ClearAllPoints = function(self)
    self.texture:ClearAllPoints()
  end,

  SetAllPoints = function(self, ...)
    self.texture:SetAllPoints(...)
  end,

  DoTexCoord = function(self)
    local mirror_h, mirror_v = self.mirror_h, self.mirror_v
    if(self.mirror) then
      mirror_h = not mirror_h
    end
    local ulx,uly , llx,lly , urx,ury , lrx,lry
      = GetRotatedPoints(self.effectiveRotation, self.canRotate)
    if(mirror_h) then
      if(mirror_v) then
        self.texture:SetTexCoord(lrx,lry , urx,ury , llx,lly , ulx,uly)
      else
        self.texture:SetTexCoord(urx,ury , lrx,lry , ulx,uly , llx,lly)
      end
    else
      if(mirror_v) then
        self.texture:SetTexCoord(llx,lly , ulx,uly , lrx,lry , urx,ury)
      else
        self.texture:SetTexCoord(ulx,uly , llx,lly , urx,ury , lrx,lry)
      end
    end
  end,

  SetMirrorFromScale = function(self, h, v)
    if self.mirror_h == h and self.mirror_v == v then
      return
    end
    self.mirror_h = h
    self.mirror_v = v
    self:DoTexCoord()
  end,

  SetMirror = function(self, b)
    if self.mirror == b then
      return
    end
    self.mirror = b
    self:DoTexCoord()
  end,

  SetTexture = function(self, file)
    self.textureName = file
    self.texture:SetTexture(file)
    self:DoTexCoord()
  end,

  SetVertexColor = function(self, r, g, b, a)
    self.texture:SetVertexColor(r, g, b,a)
  end,

  SetDesaturated = function(self, b)
    self.texture:SetDesaturated(b)
  end,

  SetAnimRotation = function(self, degrees)
    self.animRotation = degrees
    self:UpdateEffectiveRotation()
  end,

  SetRotation = function(self, degrees)
    self.rotation = degrees
    self:UpdateEffectiveRotation()
  end,

  UpdateEffectiveRotation = function(self)
    self.effectiveRotation = self.animRotation or self.rotation
    self:DoTexCoord()
  end,

  GetBaseRotation = function(self)
    return self.rotation
  end
}

function Private.TextureBase.create(frame)
    local base = {}

    for funcName, func in pairs(funcs) do
      base[funcName] = func
    end

    local texture = frame:CreateTexture()

    base.texture = texture

    return base
end

function Private.TextureBase.modify(base, options)
  base.canRotate = options.canRotate
  base.mirror = options.mirror
  base.rotation = options.rotation
  base.effectiveRotation = base.rotation
  base.textureWrapMode = options.textureWrapMode

  base.texture:SetDesaturated(options.desaturate)
  base.texture:SetBlendMode(options.blendMode)
  base:DoTexCoord()
end

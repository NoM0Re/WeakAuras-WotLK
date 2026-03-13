local AddonName = ...
local OptionsPrivate = select(2, ...)

local ipairs = ipairs
local pairs = pairs
local select = select
local ceil = math.ceil
local floor = math.floor
local min = math.min
local max = math.max
local tInsert = table.insert
local unpack = unpack

local function Mixin(object, ...)
  for i = 1, select("#", ...) do
    local mixin = select(i, ...)
    for k, v in pairs(mixin) do
      object[k] = v
    end
  end
  return object
end

local function CreateFromMixins(...)
  return Mixin({}, ...)
end

local function ipairs_reverse(tbl)
  local function Enumerator(tbl, index)
    index = index - 1
    local value = tbl[index]
    if value ~= nil then
      return index, value
    end
  end
  return Enumerator, tbl, #tbl + 1
end

local function Round(value)
  if value < 0.0 then
    return ceil(value - 0.5)
  end
  return floor(value + 0.5)
end

local function tIndexOf(tbl, item)
  for i, v in ipairs(tbl) do
    if item == v then
      return i
    end
  end
end

local function tAppendAll(tbl, addedArray)
  for i, element in ipairs(addedArray) do
    tInsert(tbl, element)
  end
end

local function Clamp(value, min, max)
  if value > max then
    return max
  elseif value < min then
    return min
  end
  return value
end

-- Export into OptionsPrivate namespace
do
  local exports = {
    Mixin = Mixin,
    CreateFromMixins = CreateFromMixins,
    ipairs_reverse = ipairs_reverse,
    Round = Round,
    tIndexOf = tIndexOf,
    tAppendAll = tAppendAll,
    Clamp = Clamp,
  }

  for name, value in pairs(exports) do
    OptionsPrivate[name] = value
  end
end

-- Frame Line Mixin Backport used in MoverSizer
local LineMethods = {}

function LineMethods:SetStartPoint(point, relTo, offX, offY)
  self._start = { point, relTo, offX or 0, offY or 0 }
  if self._shown then self:_layout() end
end

function LineMethods:SetEndPoint(point, relTo, offX, offY)
  self._end = { point, relTo, offX or 0, offY or 0 }
  if self._shown then self:_layout() end
end

function LineMethods:SetThickness(t)
  self._thickness = t or 1
  if self._shown then self:_layout() end
end

function LineMethods:SetTexture(a, b, c, d)
  if type(a) == "string" then
    self.tex:SetTexture(a)
  else
    self.tex:SetTexture(a or 1, b or 1, c or 1, d or 1)
  end
end

function LineMethods:SetVertexColor(r, g, b, a)
  self.tex:SetVertexColor(r, g, b, a or 1)
end

function LineMethods:SetAlpha(a) self.tex:SetAlpha(a) end
function LineMethods:SetDrawLayer(layer, sub) self.tex:SetDrawLayer(layer or "ARTWORK", sub) end
function LineMethods:Show() self._shown = true; self.tex:Show(); self:_layout() end
function LineMethods:Hide() self._shown = false; self.tex:Hide() end
function LineMethods:ClearAllPoints() self.tex:ClearAllPoints() end

function LineMethods:_layout()
  if not (self._start and self._end) then return end
  local sP, sRel, sX, sY = unpack(self._start)
  local eP, eRel, eX, eY = unpack(self._end)
  local t = self._thickness or 1

  self.tex:ClearAllPoints()

  if sP == "TOPLEFT" and eP == "BOTTOMLEFT" and sRel == eRel and sY == 0 and eY == 0 and sX == eX then
    local x = sX
    self.tex:SetPoint("TOPLEFT",  sRel, "TOPLEFT",  x - t/2, 0)
    self.tex:SetPoint("BOTTOMLEFT", eRel, "BOTTOMLEFT", x - t/2, 0)
    self.tex:SetWidth(t)
    return
  end

  if sP == "BOTTOMLEFT" and eP == "BOTTOMRIGHT" and sRel == eRel and sX == 0 and eX == 0 and sY == eY then
    local y = sY
    self.tex:SetPoint("BOTTOMLEFT", sRel, "BOTTOMLEFT", 0, y - t/2)
    self.tex:SetPoint("BOTTOMRIGHT", eRel, "BOTTOMRIGHT", 0, y - t/2)
    self.tex:SetHeight(t)
    return
  end

  if sRel == eRel then
    if sX == eX then
      local x = sX
      self.tex:SetPoint("TOPLEFT",  sRel, "TOPLEFT",  x - t/2, min(sY, eY))
      self.tex:SetPoint("BOTTOMLEFT", sRel, "TOPLEFT", x - t/2, max(sY, eY))
      self.tex:SetWidth(t)
      return
    elseif sY == eY then
      local y = sY
      self.tex:SetPoint("BOTTOMLEFT", sRel, "BOTTOMLEFT", min(sX, eX), y - t/2)
      self.tex:SetPoint("BOTTOMRIGHT", sRel, "BOTTOMLEFT", max(sX, eX), y - t/2)
      self.tex:SetHeight(t)
      return
    end
  end
end

function OptionsPrivate.CreateLine(parent, layer, sublayer)
  local tex = parent:CreateTexture(nil, layer or "ARTWORK", nil, sublayer)
  tex:SetTexture("Interface\\Buttons\\WHITE8x8")
  tex:SetVertexColor(1, 1, 1, 1)
  tex:Hide()

  local line = { tex = tex, _thickness = 1, _shown = false }
  return setmetatable(line, { __index = LineMethods })
end

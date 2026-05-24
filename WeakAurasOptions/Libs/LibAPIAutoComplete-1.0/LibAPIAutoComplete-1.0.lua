local MAJOR, MINOR = "LibAPIAutoComplete-1.0", 6
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end

local SharedMedia = LibStub("LibSharedMedia-3.0")

local config = {}

local skipWords = {
  ["local"] = true,
  ["print"] = true,
  ["player"] = true,
  ["display"] = true,
  ["return"] = true,
  ["function"] = true
}

local maxMatches = 100

local lineHeight = 20
local scrollBoxTextPaddingRight = 4
local trimScrollBarWidth = 25
local trimScrollBarButtonSize = 18
local trimScrollBarButtonHeight = 16
local trimScrollBarBackplateInsetLeft = 2
local trimScrollBarBackplateInsetRight = 3
local trimScrollBarBackplateInsetTop = 3
local trimScrollBarBackplateInsetBottom = 3
local trimScrollBarTrackInsetLeft = 4
local trimScrollBarTrackInsetRight = 4
local trimScrollBarTrackInsetTop = 22
local trimScrollBarTrackInsetBottom = 22
local trimScrollBarThumbOffsetX = 0
local trimScrollBarStep = lineHeight
local trimScrollBarAssetPath = "Interface\\AddOns\\WeakAurasOptions\\Libs\\LibAPIAutoComplete-1.0\\assets\\"
local trimScrollBarProportionalTexture = trimScrollBarAssetPath .. "ScrollBarProportional"
local trimScrollBarProportionalVerticalTexture = trimScrollBarAssetPath .. "ScrollBarProportionalVertical"
local trimScrollBarProportionalHorizontalTexture = trimScrollBarAssetPath .. "ScrollBarProportionalHorizontal"

local trimScrollBarAtlas = {
  ["UI-ScrollBar-EndCap-Top"] = { width = 25, height = 32, texCoords = {0.00390625, 0.101562, 0.21875, 0.46875} },
  ["UI-ScrollBar-EndCap-Bottom"] = { width = 25, height = 31, texCoords = {0.00390625, 0.101562, 0.484375, 0.726562} },
  ["!UI-ScrollBar-Center"] = { width = 25, height = 32, texCoords = {0.0078125, 0.203125, 0, 0.03125} },

  ["UI-ScrollBar-Knob-EndCap-Top"] = { width = 18, height = 21, texCoords = {0.25, 0.320312, 0.476562, 0.640625} },
  ["UI-ScrollBar-Knob-Center"] = { width = 18, height = 1022, texCoords = {0.375, 0.515625, 0.000976562, 0.999023} },
  ["UI-ScrollBar-Knob-EndCap-Bottom"] = { width = 18, height = 21, texCoords = {0.136719, 0.207031, 0.445312, 0.609375} },

  ["UI-ScrollBar-Knob-MouseOver-EndCap-Top"] = { width = 18, height = 21, texCoords = {0.339844, 0.410156, 0.1875, 0.351562} },
  ["UI-ScrollBar-Knob-MouseOver-Center"] = { width = 18, height = 1022, texCoords = {0.53125, 0.671875, 0.000976562, 0.999023} },
  ["UI-ScrollBar-Knob-MouseOver-EndCap-Bottom"] = { width = 18, height = 21, texCoords = {0.339844, 0.410156, 0.0078125, 0.171875} },

  ["UI-ScrollBar-Knob-EndCap-Top-Disabled"] = { width = 18, height = 21, texCoords = {0.25, 0.320312, 0.65625, 0.820312} },
  ["UI-ScrollBar-Knob-Center-Disabled"] = { width = 18, height = 1022, texCoords = {0.21875, 0.359375, 0.000976562, 0.999023} },
  ["UI-ScrollBar-Knob-EndCap-Bottom-Disabled"] = { width = 18, height = 21, texCoords = {0.136719, 0.207031, 0.625, 0.789062} },

  ["UI-ScrollBar-ScrollUpButton-Up"] = { width = 18, height = 16, texCoords = {0.8125, 0.882812, 0.0078125, 0.132812} },
  ["UI-ScrollBar-ScrollUpButton-Down"] = { width = 18, height = 16, texCoords = {0.65625, 0.726562, 0.0078125, 0.132812} },
  ["UI-ScrollBar-ScrollUpButton-Disabled"] = { width = 18, height = 16, texCoords = {0.578125, 0.648438, 0.0078125, 0.132812} },
  ["UI-ScrollBar-ScrollUpButton-Highlight"] = { width = 18, height = 16, texCoords = {0.734375, 0.804688, 0.0078125, 0.132812} },

  ["UI-ScrollBar-ScrollDownButton-Up"] = { width = 18, height = 16, texCoords = {0.339844, 0.410156, 0.789062, 0.914062} },
  ["UI-ScrollBar-ScrollDownButton-Down"] = { width = 18, height = 16, texCoords = {0.339844, 0.410156, 0.507812, 0.632812} },
  ["UI-ScrollBar-ScrollDownButton-Disabled"] = { width = 18, height = 16, texCoords = {0.339844, 0.410156, 0.367188, 0.492188} },
  ["UI-ScrollBar-ScrollDownButton-Highlight"] = { width = 18, height = 16, texCoords = {0.339844, 0.410156, 0.648438, 0.773438} },

  ["_UI-ScrollBar-Center"] = { width = 32, height = 25, texCoords = {0, 0.03125, 0.0078125, 0.203125} },
  ["UI-ScrollBar-Knob-Center-Horizontal"] = { width = 1022, height = 18, texCoords = {0.000976562, 0.999023, 0.375, 0.515625} },
  ["UI-ScrollBar-Knob-MouseOver-Center-Horizontal"] = { width = 1022, height = 18, texCoords = {0.000976562, 0.999023, 0.53125, 0.671875} },
  ["UI-ScrollBar-Knob-Center-Disabled-Horizontal"] = { width = 1022, height = 18, texCoords = {0.000976562, 0.999023, 0.21875, 0.359375} },
}

lib.trimScrollBarAtlas = trimScrollBarAtlas

local requiredTrimScrollBarAtlases = {
  "UI-ScrollBar-EndCap-Top",
  "UI-ScrollBar-EndCap-Bottom",
  "!UI-ScrollBar-Center",
  "UI-ScrollBar-Knob-EndCap-Top",
  "UI-ScrollBar-Knob-Center",
  "UI-ScrollBar-Knob-EndCap-Bottom",
  "UI-ScrollBar-ScrollUpButton-Up",
  "UI-ScrollBar-ScrollUpButton-Down",
  "UI-ScrollBar-ScrollUpButton-Highlight",
  "UI-ScrollBar-ScrollDownButton-Up",
  "UI-ScrollBar-ScrollDownButton-Down",
  "UI-ScrollBar-ScrollDownButton-Highlight",
}

local scrollBarProportionalAtlases = {
  "UI-ScrollBar-EndCap-Top",
  "UI-ScrollBar-EndCap-Bottom",
  "UI-ScrollBar-Knob-EndCap-Top",
  "UI-ScrollBar-Knob-EndCap-Bottom",
  "UI-ScrollBar-Knob-MouseOver-EndCap-Top",
  "UI-ScrollBar-Knob-MouseOver-EndCap-Bottom",
  "UI-ScrollBar-Knob-EndCap-Top-Disabled",
  "UI-ScrollBar-Knob-EndCap-Bottom-Disabled",
  "UI-ScrollBar-ScrollUpButton-Up",
  "UI-ScrollBar-ScrollUpButton-Down",
  "UI-ScrollBar-ScrollUpButton-Disabled",
  "UI-ScrollBar-ScrollUpButton-Highlight",
  "UI-ScrollBar-ScrollDownButton-Up",
  "UI-ScrollBar-ScrollDownButton-Down",
  "UI-ScrollBar-ScrollDownButton-Disabled",
  "UI-ScrollBar-ScrollDownButton-Highlight",
}

local scrollBarProportionalVerticalAtlases = {
  "!UI-ScrollBar-Center",
  "UI-ScrollBar-Knob-Center",
  "UI-ScrollBar-Knob-MouseOver-Center",
  "UI-ScrollBar-Knob-Center-Disabled",
}

local scrollBarProportionalHorizontalAtlases = {
  "_UI-ScrollBar-Center",
  "UI-ScrollBar-Knob-Center-Horizontal",
  "UI-ScrollBar-Knob-MouseOver-Center-Horizontal",
  "UI-ScrollBar-Knob-Center-Disabled-Horizontal",
}

function lib:SetTrimScrollBarAtlasTexturePaths(scrollBarProportional, scrollBarProportionalVertical, scrollBarProportionalHorizontal)
  for _, atlasName in ipairs(scrollBarProportionalAtlases) do
    trimScrollBarAtlas[atlasName].texture = scrollBarProportional
  end
  for _, atlasName in ipairs(scrollBarProportionalVerticalAtlases) do
    trimScrollBarAtlas[atlasName].texture = scrollBarProportionalVertical
  end
  for _, atlasName in ipairs(scrollBarProportionalHorizontalAtlases) do
    trimScrollBarAtlas[atlasName].texture = scrollBarProportionalHorizontal
  end
end

lib:SetTrimScrollBarAtlasTexturePaths(
  trimScrollBarProportionalTexture,
  trimScrollBarProportionalVerticalTexture,
  trimScrollBarProportionalHorizontalTexture
)

for k in pairs(skipWords) do
  for i = #k, 5, -1 do
     skipWords[k:sub(1, i)] = true
  end
end

local function LoadAPIDocumentation()
  local apiAddonName = "APIDocumentation"
  local _, loaded = IsAddOnLoaded(apiAddonName)
  if not loaded then
    LoadAddOn(apiAddonName)
  end
  if not APIDocumentation or not APIDocumentation.systems then
    return false
  end
  if APIDocumentation and APIDocumentation.systems and #APIDocumentation.systems == 0 then
    APIDocumentation:OnLoad()
  end
  return true
end

local function CreateLegacyDataProvider()
  local dataProvider = { collection = {} }

  function dataProvider:SetScrollBox(scrollBox)
    self.scrollBox = scrollBox
  end

  function dataProvider:Flush()
    wipe(self.collection)
    if self.scrollBox and self.scrollBox.selectionBehaviour then
      self.scrollBox.selectionBehaviour:SetSelectedIndex(nil)
    end
    if self.scrollBox then
      self.scrollBox:Refresh()
    end
  end

  function dataProvider:InsertTable(lines)
    for _, line in ipairs(lines) do
      tinsert(self.collection, line)
    end
    if self.scrollBox then
      self.scrollBox:Refresh()
    end
  end

  function dataProvider:GetSize()
    return #self.collection
  end

  function dataProvider:IsEmpty()
    return #self.collection == 0
  end

  function dataProvider:Find(index)
    return self.collection[index]
  end

  function dataProvider:FindIndex(elementData)
    for index, data in ipairs(self.collection) do
      if data == elementData then
        return index
      end
    end
    return nil
  end

  function dataProvider:Enumerate()
    local index = 0
    return function()
      index = index + 1
      local elementData = self.collection[index]
      if elementData then
        return index, elementData
      end
    end
  end

  return dataProvider
end

local function CreateLegacySelectionBehavior(scrollBox)
  local selectionBehaviour = { scrollBox = scrollBox }

  function selectionBehaviour:RegisterCallback(event, callback)
    self.callback = callback
  end

  function selectionBehaviour:SetSelectedIndex(index)
    local oldData = self.selectedIndex and lib.data:Find(self.selectedIndex)
    if oldData and self.callback then
      self.callback(self, oldData, false)
    end
    self.selectedIndex = index
    local newData = self.selectedIndex and lib.data:Find(self.selectedIndex)
    if newData and self.callback then
      self.callback(self, newData, true)
    end
  end

  function selectionBehaviour:HasSelection()
    return self.selectedIndex ~= nil
  end

  function selectionBehaviour:SelectFirstElementData()
    if lib.data:GetSize() > 0 then
      self:SetSelectedIndex(1)
    end
  end

  function selectionBehaviour:SelectNextElementData()
    if not self.selectedIndex then
      self:SelectFirstElementData()
    elseif self.selectedIndex < lib.data:GetSize() then
      self:SetSelectedIndex(self.selectedIndex + 1)
    end
  end

  function selectionBehaviour:SelectPreviousElementData()
    if not self.selectedIndex then
      self:SelectFirstElementData()
    elseif self.selectedIndex > 1 then
      self:SetSelectedIndex(self.selectedIndex - 1)
    end
  end

  function selectionBehaviour:GetFirstSelectedElementData()
    return self.selectedIndex and lib.data:Find(self.selectedIndex)
  end

  return selectionBehaviour
end

local sliderBackdrop  = {
  bgFile = "Interface\\Buttons\\UI-SliderBar-Background",
  edgeFile = "Interface\\Buttons\\UI-SliderBar-Border",
  tile = true, tileSize = 8, edgeSize = 8,
  insets = { left = 3, right = 3, top = 3, bottom = 3 }
}

local function HasTrimScrollBarAssets()
  for _, atlasName in ipairs(requiredTrimScrollBarAtlases) do
    local atlas = trimScrollBarAtlas[atlasName]
    if not atlas or not atlas.texture then
      return false
    end
  end
  return true
end

local function SetAtlasTexture(texture, atlasName, width, height, cropToSize)
  local atlas = trimScrollBarAtlas[atlasName]
  if not atlas or not atlas.texture then
    return false
  end

  local left, right, top, bottom = unpack(atlas.texCoords)
  if cropToSize then
    if width and width < atlas.width then
      right = left + (right - left) * (width / atlas.width)
    end
    if height and height < atlas.height then
      bottom = top + (bottom - top) * (height / atlas.height)
    end
  end

  texture:SetTexture(atlas.texture)
  texture:SetTexCoord(left, right, top, bottom)
  texture:SetWidth(width or atlas.width)
  texture:SetHeight(height or atlas.height)
  return true
end

local function SetTrimButtonState(button, atlasName)
  if button and button.Texture then
    SetAtlasTexture(button.Texture, atlasName)
  end
end

local function RefreshTrimButtonState(button)
  if not button then
    return
  end

  if button.disabled then
    SetTrimButtonState(button, button.disabledAtlas)
    button.Overlay:Hide()
  elseif button.down then
    SetTrimButtonState(button, button.downAtlas)
  else
    SetTrimButtonState(button, button.upAtlas)
    if button.over then
      button.Overlay:Show()
    else
      button.Overlay:Hide()
    end
  end
end

local function CreateTrimScrollBarButton(parent, direction)
  local button = CreateFrame("Button", nil, parent)
  button:SetSize(trimScrollBarButtonSize, trimScrollBarButtonHeight)

  button.Texture = button:CreateTexture(nil, "BACKGROUND")
  button.Texture:SetAllPoints()

  button.Overlay = button:CreateTexture(nil, "OVERLAY")
  button.Overlay:SetAllPoints()
  button.Overlay:Hide()

  if direction == "UP" then
    button.upAtlas = "UI-ScrollBar-ScrollUpButton-Up"
    button.downAtlas = "UI-ScrollBar-ScrollUpButton-Down"
    button.disabledAtlas = "UI-ScrollBar-ScrollUpButton-Disabled"
    button.highlightAtlas = "UI-ScrollBar-ScrollUpButton-Highlight"
  else
    button.upAtlas = "UI-ScrollBar-ScrollDownButton-Up"
    button.downAtlas = "UI-ScrollBar-ScrollDownButton-Down"
    button.disabledAtlas = "UI-ScrollBar-ScrollDownButton-Disabled"
    button.highlightAtlas = "UI-ScrollBar-ScrollDownButton-Highlight"
  end

  SetTrimButtonState(button, button.upAtlas)
  SetAtlasTexture(button.Overlay, button.highlightAtlas)

  button:SetScript("OnEnter", function(self)
    self.over = true
    RefreshTrimButtonState(self)
  end)
  button:SetScript("OnLeave", function(self)
    self.over = nil
    self.down = nil
    RefreshTrimButtonState(self)
  end)
  button:SetScript("OnMouseDown", function(self)
    if not self.disabled then
      self.down = true
      RefreshTrimButtonState(self)
    end
  end)
  button:SetScript("OnMouseUp", function(self)
    if not self.disabled then
      self.down = nil
      RefreshTrimButtonState(self)
    end
  end)

  return button
end

local function SetTrimThumbAtlas(thumb)
  local prefix = thumb.over and "UI-ScrollBar-Knob-MouseOver" or "UI-ScrollBar-Knob"
  SetAtlasTexture(thumb.Begin, prefix .. "-EndCap-Top")
  SetAtlasTexture(thumb.Middle, prefix .. "-Center", trimScrollBarButtonSize, math.max(1, thumb:GetHeight() - 10), true)
  SetAtlasTexture(thumb.End, prefix .. "-EndCap-Bottom")
end

local function UpdateScrollBarFromThumbCursor(thumb)
  local scrollBar = thumb.scrollBar
  local range = scrollBar.scrollBox.scrollRange or 0
  if range <= 0 then
    return
  end

  local _, cursorY = GetCursorPosition()
  local scale = scrollBar.Track:GetEffectiveScale()
  local y = cursorY / scale
  local trackHeight = scrollBar.Track:GetHeight()
  local thumbHeight = thumb:GetHeight()
  local offsetRange = math.max(1, trackHeight - thumbHeight)
  local offset = scrollBar.Track:GetTop() - y - (thumb.cursorOffset or 0)

  if offset < 0 then
    offset = 0
  elseif offset > offsetRange then
    offset = offsetRange
  end

  scrollBar:SetValue(range * offset / offsetRange)
end

local function CreateTrimScrollBarArtwork(scrollBar)
  if not HasTrimScrollBarAssets() then
    return
  end

  scrollBar:SetWidth(trimScrollBarWidth)
  scrollBar:SetBackdrop(nil)
  scrollBar.usesTrimArtwork = true

  local sliderThumb = scrollBar:GetThumbTexture()
  if sliderThumb then
    sliderThumb:SetTexture(nil)
    sliderThumb:SetAlpha(0)
  end

  local backplate = scrollBar:CreateTexture(nil, "BACKGROUND")
  backplate:SetPoint("TOPLEFT", scrollBar, "TOPLEFT", trimScrollBarBackplateInsetLeft, -trimScrollBarBackplateInsetTop)
  backplate:SetPoint("BOTTOMRIGHT", scrollBar, "BOTTOMRIGHT", -trimScrollBarBackplateInsetRight, trimScrollBarBackplateInsetBottom)
  backplate:SetTexture(0, 0, 0, .75)
  scrollBar.Backplate = backplate

  local background = CreateFrame("Frame", nil, scrollBar)
  background:SetAllPoints(scrollBar)
  scrollBar.Background = background

  background.Begin = background:CreateTexture(nil, "ARTWORK")
  background.Begin:SetPoint("TOPLEFT", background, "TOPLEFT")
  SetAtlasTexture(background.Begin, "UI-ScrollBar-EndCap-Top")

  background.End = background:CreateTexture(nil, "ARTWORK")
  background.End:SetPoint("BOTTOMLEFT", background, "BOTTOMLEFT")
  SetAtlasTexture(background.End, "UI-ScrollBar-EndCap-Bottom")

  background.Middle = background:CreateTexture(nil, "ARTWORK")
  background.Middle:SetPoint("TOPLEFT", background.Begin, "BOTTOMLEFT")
  background.Middle:SetPoint("BOTTOMRIGHT", background.End, "TOPRIGHT")
  SetAtlasTexture(background.Middle, "!UI-ScrollBar-Center")

  local track = CreateFrame("Frame", nil, scrollBar)
  track:SetPoint("TOPLEFT", scrollBar, "TOPLEFT", trimScrollBarTrackInsetLeft, -trimScrollBarTrackInsetTop)
  track:SetPoint("BOTTOMRIGHT", scrollBar, "BOTTOMRIGHT", -trimScrollBarTrackInsetRight, trimScrollBarTrackInsetBottom)
  track:EnableMouse(true)
  scrollBar.Track = track

  local thumb = CreateFrame("Frame", nil, track)
  thumb:SetWidth(trimScrollBarButtonSize)
  thumb:SetPoint("LEFT", track, "LEFT", trimScrollBarThumbOffsetX, 0)
  thumb:EnableMouse(true)
  thumb.scrollBar = scrollBar
  thumb.Middle = thumb:CreateTexture(nil, "BACKGROUND")
  thumb.Middle:SetPoint("TOPLEFT", thumb, "TOPLEFT", 0, -5)
  thumb.Middle:SetPoint("BOTTOMRIGHT", thumb, "BOTTOMRIGHT", 0, 5)
  thumb.Begin = thumb:CreateTexture(nil, "BORDER")
  thumb.Begin:SetPoint("TOPLEFT", thumb, "TOPLEFT")
  thumb.End = thumb:CreateTexture(nil, "BORDER")
  thumb.End:SetPoint("BOTTOMLEFT", thumb, "BOTTOMLEFT")
  thumb:SetScript("OnEnter", function(self)
    self.over = true
    SetTrimThumbAtlas(self)
  end)
  thumb:SetScript("OnLeave", function(self)
    if not self.dragging then
      self.over = nil
      SetTrimThumbAtlas(self)
    end
  end)
  thumb:SetScript("OnMouseDown", function(self, button)
    if button ~= "LeftButton" then
      return
    end

    local _, cursorY = GetCursorPosition()
    local scale = self.scrollBar.Track:GetEffectiveScale()
    self.cursorOffset = self:GetTop() - (cursorY / scale)
    self.dragging = true
    self.over = true
    SetTrimThumbAtlas(self)
    self:SetScript("OnUpdate", UpdateScrollBarFromThumbCursor)
  end)
  thumb:SetScript("OnMouseUp", function(self)
    self.dragging = nil
    self.cursorOffset = nil
    self:SetScript("OnUpdate", nil)
    SetTrimThumbAtlas(self)
  end)
  thumb:SetScript("OnHide", function(self)
    self.dragging = nil
    self.cursorOffset = nil
    self:SetScript("OnUpdate", nil)
  end)
  scrollBar.Thumb = thumb

  scrollBar.Back = CreateTrimScrollBarButton(scrollBar, "UP")
  scrollBar.Back:SetPoint("TOPLEFT", scrollBar, "TOPLEFT", trimScrollBarTrackInsetLeft, -4)
  scrollBar.Back:SetScript("OnClick", function()
    scrollBar:SetValue(math.max(0, scrollBar:GetValue() - trimScrollBarStep))
  end)

  scrollBar.Forward = CreateTrimScrollBarButton(scrollBar, "DOWN")
  scrollBar.Forward:SetPoint("BOTTOMLEFT", scrollBar, "BOTTOMLEFT", trimScrollBarTrackInsetLeft, 4)
  scrollBar.Forward:SetScript("OnClick", function()
    scrollBar:SetValue(math.min(scrollBar.scrollBox.scrollRange, scrollBar:GetValue() + trimScrollBarStep))
  end)

  track:SetScript("OnMouseDown", function(self, button)
    if button ~= "LeftButton" then
      return
    end

    local _, cursorY = GetCursorPosition()
    local scale = self:GetEffectiveScale()
    local y = cursorY / scale
    local thumbTop = scrollBar.Thumb:GetTop()
    local thumbBottom = scrollBar.Thumb:GetBottom()
    local page = math.max(lineHeight, scrollBar.scrollBox:GetHeight() - lineHeight)

    if y > thumbTop then
      scrollBar:SetValue(math.max(0, scrollBar:GetValue() - page))
    elseif y < thumbBottom then
      scrollBar:SetValue(math.min(scrollBar.scrollBox.scrollRange, scrollBar:GetValue() + page))
    end
  end)

  scrollBar:SetScript("OnEnter", function(self)
    self.Thumb.over = true
    SetTrimThumbAtlas(self.Thumb)
  end)

  scrollBar:SetScript("OnLeave", function(self)
    self.Thumb.over = nil
    SetTrimThumbAtlas(self.Thumb)
  end)

  function scrollBar:RefreshStepperStates()
    local value = self:GetValue()
    local range = self.scrollBox.scrollRange or 0
    self.Back.disabled = value <= 0
    self.Forward.disabled = range <= 0 or value >= range
    RefreshTrimButtonState(self.Back)
    RefreshTrimButtonState(self.Forward)
  end

  function scrollBar:RefreshArtwork()
    local range = self.scrollBox.scrollRange or 0
    local trackHeight = self.Track:GetHeight()
    local visibleHeight = self.scrollBox:GetHeight()
    local contentHeight = visibleHeight + range
    local thumbHeight = math.max(23, trackHeight * visibleHeight / contentHeight)
    local offsetRange = math.max(0, trackHeight - thumbHeight)
    local offset = range > 0 and offsetRange * (self:GetValue() / range) or 0

    self.Thumb:SetHeight(thumbHeight)
    self.Thumb:ClearAllPoints()
    self.Thumb:SetPoint("TOPLEFT", self.Track, "TOPLEFT", trimScrollBarThumbOffsetX, -offset)
    SetTrimThumbAtlas(self.Thumb)
    self:RefreshStepperStates()
  end
end

local function CreateLegacyScrollBox()
  local scrollBox = CreateFrame("ScrollFrame", nil, UIParent)
  local content = CreateFrame("Frame", nil, scrollBox)
  scrollBox:SetScrollChild(content)
  scrollBox:SetSize(400, 150)
  scrollBox:EnableMouseWheel(true)
  scrollBox:Hide()

  local background = scrollBox:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints()
  scrollBox.background = background
  scrollBox.content = content
  scrollBox.buttons = {}
  scrollBox.framesByData = {}
  scrollBox.scrollRange = 0

  local scrollBar = CreateFrame("Slider", nil, UIParent)
  scrollBar:SetOrientation("VERTICAL")
  scrollBar:SetWidth(12)
  scrollBar:SetBackdrop(sliderBackdrop)
  scrollBar:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
  scrollBar:SetMinMaxValues(0, 0)
  scrollBar:SetValueStep(1)
  scrollBar:SetValue(0)
  scrollBar:Hide()
  CreateTrimScrollBarArtwork(scrollBar)

  function scrollBar:SetScrollPercentage(percent)
    local offset = (self.scrollBox and self.scrollBox.scrollRange or 0) * percent
    self:SetValue(offset)
  end

  scrollBar.scrollBox = scrollBox
  scrollBar:SetScript("OnValueChanged", function(self, value)
    self.scrollBox:SetVerticalScroll(value)
    if self.RefreshArtwork then
      self:RefreshArtwork()
    end
  end)

  function scrollBox:SetDataProvider(dataProvider)
    self.dataProvider = dataProvider
    dataProvider:SetScrollBox(self)
  end

  function scrollBox:FindFrame(elementData)
    return self.framesByData[elementData]
  end

  function scrollBox:Refresh()
    if not self.dataProvider then
      return
    end

    wipe(self.framesByData)
    local width = self:GetWidth()
    local lineCount = self.dataProvider:GetSize()
    content:SetWidth(width)
    content:SetHeight(math.max(1, lineCount * lineHeight))

    for index = 1, lineCount do
      local button = self.buttons[index]
      if not button then
        button = CreateFrame("Button", nil, content)
        button:SetHeight(lineHeight)
        button:SetNormalFontObject(GameFontNormalSmall)
        local fontString = button:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        button:SetFontString(fontString)
        button.SetSelected = APIAutoCompleteLineMixin.SetSelected
        button.Insert = APIAutoCompleteLineMixin.Insert
        self.buttons[index] = button
      end
      local elementData = self.dataProvider:Find(index)
      button:ClearAllPoints()
      button:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -((index - 1) * lineHeight))
      button:SetPoint("TOPRIGHT", content, "TOPRIGHT", 0, -((index - 1) * lineHeight))
      APIAutoCompleteLineMixin.Init(button, elementData)
      button:Show()
      self.framesByData[elementData] = button
    end

    for index = lineCount + 1, #self.buttons do
      self.buttons[index]:Hide()
    end

    self.scrollRange = math.max(0, (lineCount * lineHeight) - self:GetHeight())
    scrollBar:SetMinMaxValues(0, self.scrollRange)
    if self:GetVerticalScroll() > self.scrollRange then
      scrollBar:SetValue(self.scrollRange)
    elseif scrollBar.RefreshArtwork then
      scrollBar:RefreshArtwork()
    end
  end

  scrollBox:SetScript("OnMouseWheel", function(self, delta)
    if self.scrollRange == 0 then
      return
    end
    local offset = self:GetVerticalScroll() - (delta * lineHeight)
    if offset < 0 then
      offset = 0
    elseif offset > self.scrollRange then
      offset = self.scrollRange
    end
    scrollBar:SetValue(offset)
  end)

  return scrollBox, scrollBar
end

local function SetPropagateKeyboardInput(propagate)
  if lib.scrollBox.SetPropagateKeyboardInput then
    lib.scrollBox:SetPropagateKeyboardInput(propagate)
  end
end

local function HandleKey(key)
  if key == "DOWN" then
    SetPropagateKeyboardInput(false)
    if not lib.selectionBehaviour:HasSelection() then
      lib.selectionBehaviour:SelectFirstElementData()
    else
      lib.selectionBehaviour:SelectNextElementData()
    end
    return true
  elseif key == "UP" then
    SetPropagateKeyboardInput(false)
    if not lib.selectionBehaviour:HasSelection() then
      lib.selectionBehaviour:SelectFirstElementData()
    else
      lib.selectionBehaviour:SelectPreviousElementData()
    end
    return true
  elseif key == "ENTER" and not IsModifierKeyDown() then
    local selectedElementData = lib.selectionBehaviour:GetFirstSelectedElementData()
    if selectedElementData then
      SetPropagateKeyboardInput(false)
      local elementFrame = lib.scrollBox:FindFrame(selectedElementData)
      elementFrame:Insert()
      return true
    end
  elseif key == "ESCAPE" then
    SetPropagateKeyboardInput(false)
    lib.data:Flush()
    lib:UpdateWidget(lib.editbox)
    return true
  end
  SetPropagateKeyboardInput(true)
end

function lib:Hide()
  self.scrollBox:Hide()
  self.scrollBar:Hide()
end

---Create APIDoc widget and ensure APIDocumentation is loaded
local isInit = false
local function Init()
  if isInit then
    return
  end
  isInit = true

  LoadAPIDocumentation()

  local scrollBox, scrollBar = CreateLegacyScrollBox()
  scrollBar:SetPoint("TOPLEFT", scrollBox, "TOPRIGHT")
  scrollBar:SetPoint("BOTTOMLEFT", scrollBox, "BOTTOMRIGHT")

  local selectionBehaviour = CreateLegacySelectionBehavior(scrollBox)
  selectionBehaviour:RegisterCallback(nil, function(o, elementData, selected)
    local elementFrame = scrollBox:FindFrame(elementData)
    if elementFrame then
      elementFrame:SetSelected(selected)
    end

    if selected and lib.editbox and config[lib.editbox] then
      local maxLinesShown = config[lib.editbox].maxLinesShown
      local index = lib.data:FindIndex(elementData)
      local divisor = lib.data:GetSize() - maxLinesShown
      if divisor == 0 then
        divisor = 1
      end
      local percent = (index - maxLinesShown / 2) / divisor
      if percent < 0 then
        percent = 0
      elseif percent > 1 then
        percent = 1
      end
      scrollBar:SetScrollPercentage(percent)
    end
  end)

  lib.data = CreateLegacyDataProvider()
  scrollBox:SetDataProvider(lib.data)

  lib.scrollBar = scrollBar
  lib.scrollBox = scrollBox
  lib.selectionBehaviour = selectionBehaviour

  scrollBox.selectionBehaviour = selectionBehaviour

  scrollBox:SetScript("OnKeyDown", function(self, key)
    HandleKey(key)
  end)
end

local lastPosition

---@private
---@param editbox EditBox
---@param x number
---@param y number
---@param w number
---@param h number
local function OnTextChanged(editbox, x, y, w, h)
  local cursorPosition = editbox:GetCursorPosition()
  if cursorPosition ~= lastPosition then
    lib:Hide()
    lib.scrollBox:ClearAllPoints()
    lib.scrollBox:SetPoint("TOPLEFT", editbox, "TOPLEFT", x, y - h)
    local currentWord = lib:GetWord(editbox)
    if #currentWord > 4 and not skipWords[currentWord] then
      lib:Search(currentWord, config[editbox])
      if lib.data:GetSize() == 1 and lib.data:Find(1).name == currentWord then
        lib.data:Flush()
      end
      lib:UpdateWidget(editbox)
    end
  end
  lastPosition = cursorPosition
end

---@class Color
---@field r integer
---@field g integer
---@field b integer
---@field a integer?

---@class Params
---@field backgroundColor Color?
---@field maxLinesShown integer?
---@field disableFunctions boolean?
---@field disableEvents boolean?
---@field disableSystems boolean?

---Enable APIDoc widget on editbox
---ForAllIndentsAndPurpose replace GetText, APIDoc must be enabled before FAIAP
---@param editbox EditBox
---@param params Params
function lib:enable(editbox, params)
  if config[editbox] then
    return
  end
  config[editbox] = {
    backgroundColor = params and params.backgroundColor or {.3, .3, .3, .9},
    maxLinesShown = params and params.maxLinesShown or 7,
    disableFunctions = params and params.disableFunctions or false,
    disableEvents = params and params.disableEvents or false,
    disableSystems = params and params.disableSystems or false,
  }
  Init()
  -- hack for WeakAuras
  editbox.APIDoc_originalGetText = editbox.GetText
  editbox.APIDoc_originalSetText = editbox.SetText
  -- hack for WowLua
  if editbox == WowLuaFrameEditBox then
    editbox.APIDoc_originalGetText = function()
      return WowLua.indent.coloredGetText(editbox)
    end
  end
  editbox.APIDoc_oldOnCursorChanged = editbox:GetScript("OnCursorChanged")
  editbox:SetScript("OnCursorChanged", function(...)
    if editbox.APIDoc_oldOnCursorChanged then
      editbox.APIDoc_oldOnCursorChanged(...)
    end
    local _, x, y, w, h = ...
    editbox.lastCursorChanged = {
      time = GetTime(),
      x = x,
      y = y,
      w = w,
      h = h
    }
  end)
  editbox.APIDoc_oldOnTextChanged = editbox:GetScript("OnTextChanged")
  editbox:SetScript("OnTextChanged", function(...)
    if editbox.APIDoc_oldOnTextChanged then
      editbox.APIDoc_oldOnTextChanged(...)
    end
    local info = editbox.lastCursorChanged
    if info and info.time == GetTime() then
      OnTextChanged(editbox, info.x, info.y, info.w, info.h)
    end
  end)
  editbox.APIDoc_oldOnKeyDown = editbox:GetScript("OnKeyDown")
  editbox:SetScript("OnKeyDown", function(...)
    local _, key = ...
    if lib.editbox == editbox and lib.data and not lib.data:IsEmpty() and HandleKey(key) then
      return
    end
    if editbox.APIDoc_oldOnKeyDown then
      editbox.APIDoc_oldOnKeyDown(...)
    end
  end)
  editbox.APIDoc_oldOnHide = editbox:GetScript("OnHide")
  editbox:SetScript("OnHide", function(...)
    if editbox.APIDoc_oldOnHide then
      editbox.APIDoc_oldOnHide(...)
    end
    lib:Hide()
  end)
  editbox.APIDoc_hiddenString = editbox:CreateFontString()
end

---Disable APIDoc widget on editbox
---@param editbox EditBox
function lib:disable(editbox)
  if not config[editbox] then
    return
  end
  config[editbox] = nil
  editbox:SetScript("OnCursorChanged", editbox.APIDoc_oldOnCursorChanged)
  editbox.APIDoc_oldOnCursorChanged = nil
  editbox:SetScript("OnTextChanged", editbox.APIDoc_oldOnTextChanged)
  editbox.APIDoc_oldOnTextChanged = nil
  editbox:SetScript("OnKeyDown", editbox.APIDoc_oldOnKeyDown)
  editbox.APIDoc_oldOnKeyDown = nil
  editbox:SetScript("OnHide", editbox.APIDoc_oldOnHide)
  editbox.APIDoc_oldOnHide = nil
end

function lib:addLine(lines, apiInfo)
  local name
  if apiInfo.Type == "System" then
    name = apiInfo.Namespace
  elseif apiInfo.Type == "Function" then
    name = apiInfo:GetFullName()
  elseif apiInfo.Type == "Event" then
    name = apiInfo.LiteralName
  end
  tinsert(lines, { name = name, apiInfo = apiInfo })
end

---Search a word in documentation, set results in lib.data
---@param word string
---@param config Params
function lib:Search(word, config)
  self.data:Flush()
  if not APIDocumentation or not APIDocumentation.systems then
    return
  end
  local lines = {}
  if word and #word > 3 then
    local lowerWord = word:lower();
    local nsName, rest = lowerWord:match("^([%w%_]+)(.*)")
    local funcName = rest and rest:match("^%.([%w%_]+)")
    for _, systemInfo in ipairs(APIDocumentation.systems) do
      local systemMatch = (not config.disableSystems)
        and (nsName and #nsName >= 4)
        and (systemInfo.Namespace and systemInfo.Namespace:lower():match(nsName))

      if not config.disableFunctions then
        for _, apiInfo in ipairs(systemInfo.Functions) do
          if systemMatch then
            if funcName then
              if apiInfo:MatchesSearchString(funcName) then
                self:addLine(lines, apiInfo)
              end
            else
              self:addLine(lines, apiInfo)
            end
          else
            if apiInfo:MatchesSearchString(lowerWord) then
              self:addLine(lines, apiInfo)
            end
          end
        end
      end

      if not config.disableEvents then
        if systemMatch and rest == "" then
          for _, apiInfo in ipairs(systemInfo.Events) do
            self:addLine(lines, apiInfo)
          end
        else
          for _, apiInfo in ipairs(systemInfo.Events) do
            if apiInfo:MatchesSearchString(lowerWord) then
              self:addLine(lines, apiInfo)
            end
          end
        end
      end

      if #lines > maxMatches then
        break
      end
    end
    self.data:InsertTable(lines)
  end
end

---set in lib.data the list of systems
function lib:ListSystems()
  self.data:Flush()
  if not APIDocumentation or not APIDocumentation.systems then
    return
  end
  local lines = {}
  for i, systemInfo in ipairs(APIDocumentation.systems) do
    if systemInfo.Namespace and #systemInfo.Functions > 0 then
      self:addLine(lines, systemInfo)
    end
  end
  self.data:InsertTable(lines)
end

---Hide, or Show and fill APIDoc widget, using lib.data data
---@param editbox EditBox
function lib:UpdateWidget(editbox)
  if self.data:IsEmpty() then
    self:Hide()
    self.editbox = nil
  else
    -- fix size
    local maxLinesShown = config[editbox].maxLinesShown
    local lines = self.data:GetSize()
    local height = math.min(lines, maxLinesShown) * lineHeight
    local width = 0
    local hiddenString = editbox.APIDoc_hiddenString
    local fontPath = SharedMedia:Fetch("font", "Fira Mono Medium")
    hiddenString:SetFont(fontPath, 12, "")
    for _, elementData in self.data:Enumerate() do
      hiddenString:SetText(elementData.name)
      width = math.max(width, hiddenString:GetStringWidth())
    end
    width = width + scrollBoxTextPaddingRight
    self.scrollBox:SetSize(width, height)
    self.scrollBox:Refresh()

    -- fix look
    local backgroundColor = config[editbox].backgroundColor
    self.scrollBox.background:SetTexture(unpack(backgroundColor))

    -- show
    self.scrollBox:SetParent(UIParent)
    self.scrollBar:SetParent(UIParent)
    self.scrollBox:SetFrameStrata("TOOLTIP")
    self.scrollBar:SetFrameStrata("TOOLTIP")
    self.scrollBox:Show()
    if lines > maxLinesShown then
      self.scrollBar:Show()
    else
      self.scrollBar:Hide()
    end
    self.editbox = editbox
  end
end

local function OnClickCallback(self)
  local name = self.name
  if IndentationLib then
    name = IndentationLib.stripWowColors(self.name)
  elseif WowLua and WowLua.indent then
    name = WowLua.indent.stripWowColors(self.name)
  end
  lib:SetWord(lib.editbox, name)
  lib:Hide()
  lib.editbox:SetFocus()
end

---@param editbox EditBox
---@return string currentWord
---@return integer startPosition
---@return integer endPosition
function lib:GetWord(editbox)
  -- get cursor position
  local cursorPosition = editbox:GetCursorPosition()
  local text = editbox:APIDoc_originalGetText()
  if IndentationLib then
    text, cursorPosition = IndentationLib.stripWowColorsWithPos(text, cursorPosition)
  end

  -- get start position of current word
  local startPosition = cursorPosition
  while startPosition - 1 > 0 and text:sub(startPosition - 1, startPosition - 1):find("[%w%.%_]") do
    startPosition = startPosition - 1
  end

  -- get end position of current word
  local endPosition = startPosition
  while endPosition < #text and text:sub(endPosition + 1, endPosition + 1):find("[%w%.%_]") do
    endPosition = endPosition + 1
  end

  local nextChar = text:sub(cursorPosition, cursorPosition)
  if nextChar ~= "" and nextChar ~= " " and nextChar ~= "\n" then
    return "", nil, nil
  end

  local currentWord = text:sub(startPosition, endPosition)
  return currentWord, startPosition, endPosition
end

---@param editbox EditBox
---@param word string
function lib:SetWord(editbox, word)
  -- get cursor position
  local cursorPosition = editbox:GetCursorPosition()
  local text = editbox:APIDoc_originalGetText()
  if IndentationLib then
    text, cursorPosition = IndentationLib.stripWowColorsWithPos(text, cursorPosition)
  end

  -- get start position of current word
  local startPosition = cursorPosition
  while startPosition > 0 and text:sub(startPosition - 1, startPosition - 1):find("[%w%.%_]") do
    startPosition = startPosition - 1
  end

  -- get end position of current word
  local endPosition = startPosition
  while endPosition < #text and text:sub(endPosition + 1, endPosition + 1):find("[%w%.%_]") do
    endPosition = endPosition + 1
  end

  -- check if replacement word looks like a function and has args
  local funcName, argsString = word:match("([%w%.%_]+)%(([%w%.%_,\"%s]*)%)")
  local funcArgs = {}
  if funcName and argsString then
    for arg in argsString:gmatch("([%w%.%_\"]+),?") do
      table.insert(funcArgs, arg)
    end
  end

  -- check if current word has parentheses and args
  local oldFuncArgs = {}
  if funcName then
    local currentWordArgs = text:sub(endPosition + 1, #text):match("^%(([%w%.%_,\"%s]*)%)")
    if currentWordArgs then
      for arg in currentWordArgs:gmatch("([%w%.%_\"]+),?") do
        table.insert(oldFuncArgs, arg)
      end
      -- move endPosition
      endPosition = endPosition + #currentWordArgs + 2
    end
  end

  -- replace replacement word's args with args from current word
  if funcName then
    local concatArgs = {}
    for i = 1, math.max(#funcArgs, #oldFuncArgs) do
      concatArgs[i] = oldFuncArgs[i] or funcArgs[i]
    end
    word = funcName .. "(" .. table.concat(concatArgs, ", ") .. ")"
  end

  -- replace word
  text = text:sub(1, startPosition - 1) .. word .. text:sub(endPosition + 1, #text)
  editbox:APIDoc_originalSetText(text)
  -- SetText triggers the OnTextChanged handler without the "userInput" flag. We need that flag set to true, so run the handler again
  local script = editbox:GetScript("OnTextChanged")
  if script then
    script(editbox, true)
  end

  -- move cursor at end of word or start of parenthese
  local parenthesePosition = word:find("%(")
  editbox:SetCursorPosition(startPosition - 1 + (parenthesePosition or #word))
end

local function showTooltip(self)
  if self.apiInfo then
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 20, 20)
    GameTooltip:ClearLines()
    for _, line in ipairs(self.apiInfo:GetDetailedOutputLines()) do
      GameTooltip:AddLine(line)
    end
    GameTooltip:Show()
  end
end

local function hideTooltip(self)
  GameTooltip:Hide()
  GameTooltip:ClearLines()
end

APIAutoCompleteLineMixin = {}
function APIAutoCompleteLineMixin:Init(elementData)
  self.name = elementData.name
  self.apiInfo = elementData.apiInfo
  self:SetText(elementData.name)
  self:SetScript("OnClick", OnClickCallback)
  self:SetScript("OnEnter", showTooltip)
  self:SetScript("OnLeave", hideTooltip)
  local fontString = self:GetFontString()
  fontString:ClearAllPoints()
  local fontPath = SharedMedia:Fetch("font", "Fira Mono Medium")
  fontString:SetFont(fontPath, 12, "")
  fontString:SetPoint("LEFT")
  fontString:SetTextColor(0.973, 0.902, 0.581)
  fontString:SetShadowColor(0, 0, 0, 0)
  fontString:SetShadowOffset(0, 0)
  if not self:GetHighlightTexture() then
    local texture = self:CreateTexture()
    texture:SetTexture(0.4,0.4,0.4,0.5)
    texture:SetAllPoints()
    self:SetHighlightTexture(texture)
  end
  self:SetSelected(false)
end

function APIAutoCompleteLineMixin:SetSelected(selected)
  if selected then
    self:LockHighlight()
  else
    self:UnlockHighlight()
  end
end

function APIAutoCompleteLineMixin:Insert()
  OnClickCallback(self)
end

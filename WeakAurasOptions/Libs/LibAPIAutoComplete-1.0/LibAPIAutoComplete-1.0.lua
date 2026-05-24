-- ===============================================================================
-- !!! IMPORTANT: CHANGE `texturePath` BELOW TO POINT TO YOUR ADDON'S FILE LOCATION !!!
-- DON'T FORGET THE BACKSLASH AT THE END (\)!
-- Example: local texturePath = [[Interface\AddOns\YourAddon\Libs\LibAPIAutoComplete-1.0\assets\]]
-- ===============================================================================

local MAJOR, MINOR = "LibAPIAutoComplete-1.0", 7
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
local texturePath = [[Interface\AddOns\WeakAurasOptions\Libs\LibAPIAutoComplete-1.0\assets\]]
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
local trimScrollBarProportionalTexture = texturePath .. "ScrollBarProportional"
local trimScrollBarProportionalVerticalTexture = texturePath .. "ScrollBarProportionalVertical"

for k in pairs(skipWords) do
  for i = #k, 5, -1 do
     skipWords[k:sub(1, i)] = true
  end
end

local function LoadBlizzard_APIDocumentation()
  local apiAddonName = "APIDocumentation" -- https://github.com/NoM0Re/WeakAuras-WotLK/tree/master/APIDocumentation
  local _, loaded = IsAddOnLoaded(apiAddonName)
  if not loaded then
    LoadAddOn(apiAddonName)
  end
  if not APIDocumentation or not APIDocumentation.systems then
    return false
  end
  if #APIDocumentation.systems == 0 then
    APIDocumentation:OnLoad()
  end
  return true
end

local function CreateDataProvider()
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

local function SetTrimTexture(texture, file, width, height, left, right, top, bottom, nativeWidth, nativeHeight, cropToSize)
  if cropToSize then
    if width and width < nativeWidth then
      right = left + (right - left) * (width / nativeWidth)
    end
    if height and height < nativeHeight then
      bottom = top + (bottom - top) * (height / nativeHeight)
    end
  end

  texture:SetTexture(file)
  texture:SetTexCoord(left, right, top, bottom)
  texture:SetWidth(width)
  texture:SetHeight(height)
end

local function SetTrimButtonState(button)
  if button.direction == "UP" then
    if button.disabled then
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.578125, 0.648438, 0.0078125, 0.132812, 18, 16)
    elseif button.down then
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.65625, 0.726562, 0.0078125, 0.132812, 18, 16)
    else
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.8125, 0.882812, 0.0078125, 0.132812, 18, 16)
    end
  else
    if button.disabled then
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.339844, 0.410156, 0.367188, 0.492188, 18, 16)
    elseif button.down then
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.339844, 0.410156, 0.507812, 0.632812, 18, 16)
    else
      SetTrimTexture(button.Texture, trimScrollBarProportionalTexture, 18, 16, 0.339844, 0.410156, 0.789062, 0.914062, 18, 16)
    end
  end
end

local function RefreshTrimButtonState(button)
  if button.disabled then
    SetTrimButtonState(button)
    button.Overlay:Hide()
  elseif button.down then
    SetTrimButtonState(button)
  else
    SetTrimButtonState(button)
    if button.over then
      button.Overlay:Show()
    else
      button.Overlay:Hide()
    end
  end
end

local function CreateTrimScrollBarButton(parent, direction)
  local button = CreateFrame("Button", nil, parent)
  button.direction = direction
  button:SetSize(trimScrollBarButtonSize, trimScrollBarButtonHeight)

  button.Texture = button:CreateTexture(nil, "BACKGROUND")
  button.Texture:SetAllPoints()

  button.Overlay = button:CreateTexture(nil, "OVERLAY")
  button.Overlay:SetAllPoints()
  button.Overlay:Hide()

  SetTrimButtonState(button)
  if button.direction == "UP" then
    SetTrimTexture(button.Overlay, trimScrollBarProportionalTexture, 18, 16, 0.734375, 0.804688, 0.0078125, 0.132812, 18, 16)
  else
    SetTrimTexture(button.Overlay, trimScrollBarProportionalTexture, 18, 16, 0.339844, 0.410156, 0.648438, 0.773438, 18, 16)
  end

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

local function SetTrimThumbTexture(thumb)
  local middleHeight = math.max(1, thumb:GetHeight() - 10)
  if thumb.over then
    SetTrimTexture(thumb.Begin, trimScrollBarProportionalTexture, 18, 21, 0.339844, 0.410156, 0.1875, 0.351562, 18, 21)
    SetTrimTexture(thumb.Middle, trimScrollBarProportionalVerticalTexture, 18, middleHeight, 0.53125, 0.671875, 0.000976562, 0.999023, 18, 1022, true)
    SetTrimTexture(thumb.End, trimScrollBarProportionalTexture, 18, 21, 0.339844, 0.410156, 0.0078125, 0.171875, 18, 21)
  else
    SetTrimTexture(thumb.Begin, trimScrollBarProportionalTexture, 18, 21, 0.25, 0.320312, 0.476562, 0.640625, 18, 21)
    SetTrimTexture(thumb.Middle, trimScrollBarProportionalVerticalTexture, 18, middleHeight, 0.375, 0.515625, 0.000976562, 0.999023, 18, 1022, true)
    SetTrimTexture(thumb.End, trimScrollBarProportionalTexture, 18, 21, 0.136719, 0.207031, 0.445312, 0.609375, 18, 21)
  end
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
  SetTrimTexture(background.Begin, trimScrollBarProportionalTexture, 25, 32, 0.00390625, 0.101562, 0.21875, 0.46875, 25, 32)

  background.End = background:CreateTexture(nil, "ARTWORK")
  background.End:SetPoint("BOTTOMLEFT", background, "BOTTOMLEFT")
  SetTrimTexture(background.End, trimScrollBarProportionalTexture, 25, 31, 0.00390625, 0.101562, 0.484375, 0.726562, 25, 31)

  background.Middle = background:CreateTexture(nil, "ARTWORK")
  background.Middle:SetPoint("TOPLEFT", background.Begin, "BOTTOMLEFT")
  background.Middle:SetPoint("BOTTOMRIGHT", background.End, "TOPRIGHT")
  SetTrimTexture(background.Middle, trimScrollBarProportionalVerticalTexture, 25, 32, 0.0078125, 0.203125, 0, 0.03125, 25, 32)

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
    SetTrimThumbTexture(self)
  end)
  thumb:SetScript("OnLeave", function(self)
    if not self.dragging then
      self.over = nil
      SetTrimThumbTexture(self)
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
    SetTrimThumbTexture(self)
    self:SetScript("OnUpdate", UpdateScrollBarFromThumbCursor)
  end)
  thumb:SetScript("OnMouseUp", function(self)
    self.dragging = nil
    self.cursorOffset = nil
    self:SetScript("OnUpdate", nil)
    SetTrimThumbTexture(self)
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
    SetTrimThumbTexture(self.Thumb)
  end)

  scrollBar:SetScript("OnLeave", function(self)
    self.Thumb.over = nil
    SetTrimThumbTexture(self.Thumb)
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
    SetTrimThumbTexture(self.Thumb)
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

local function IsWidgetOpen()
  return lib.scrollBox and lib.scrollBox:IsShown() and lib.data and not lib.data:IsEmpty()
end

local modifierKeys = {
  LSHIFT = true,
  RSHIFT = true,
  LCTRL = true,
  RCTRL = true,
  LALT = true,
  RALT = true,
}

local function CloseWidgetFromKey()
  if lib.data then
    lib.data:Flush()
  end
  if lib.editbox then
    lib:UpdateWidget(lib.editbox)
  else
    lib:Hide()
  end
end

local function HandleKey(key)
  if key == "UPARROW" then
    key = "UP"
  elseif key == "DOWNARROW" then
    key = "DOWN"
  elseif key == "LEFTARROW" then
    key = "LEFT"
  elseif key == "RIGHTARROW" then
    key = "RIGHT"
  end

  if modifierKeys[key] then
    CloseWidgetFromKey()
    return true
  end

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
      if elementFrame then
        elementFrame:Insert()
      elseif selectedElementData.name then
        lib:SetWord(lib.editbox, selectedElementData.name)
        lib:Hide()
        lib.editbox:SetFocus()
      end
      return true
    end
  elseif key == "ESCAPE" then
    SetPropagateKeyboardInput(false)
    lib.data:Flush()
    lib:UpdateWidget(lib.editbox)
    return true
  elseif key == "LEFT" or key == "RIGHT" then
    local editbox = lib.editbox
    local cursorPosition = editbox:GetCursorPosition()
    if key == "LEFT" and cursorPosition > 0 then
      editbox:SetCursorPosition(cursorPosition - 1)
    elseif key == "RIGHT" then
      local text = editbox.APIDoc_originalGetText and editbox:APIDoc_originalGetText() or editbox:GetText()
      if cursorPosition < #text then
        editbox:SetCursorPosition(cursorPosition + 1)
      end
    end
    editbox:SetFocus()
    return true
  end
  SetPropagateKeyboardInput(true)
end

local function HandleArrowKey(key)
  if key == "DOWN" or key == "UP" or key == "LEFT" or key == "RIGHT"
      or key == "DOWNARROW" or key == "UPARROW" or key == "LEFTARROW" or key == "RIGHTARROW" then
    return HandleKey(key)
  end
end

local function KeyboardCaptureButton_OnClick(self)
  if lib.editbox and IsWidgetOpen() then
    HandleKey(self.key)
  end
end

local function KeyboardCapture_OnUpdate(self)
  local modifierDown = IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()
  if modifierDown and not self.modifierDown then
    CloseWidgetFromKey()
  end
  self.modifierDown = modifierDown
end

local function CreateKeyboardCapture()
  local capture = CreateFrame("Frame", "LibAPIAutoCompleteKeyboardCapture", UIParent)
  capture:Hide()

  capture.up = CreateFrame("Button", "LibAPIAutoCompleteKeyboardCaptureUp", capture)
  capture.up.key = "UP"
  capture.up:SetScript("OnClick", KeyboardCaptureButton_OnClick)

  capture.down = CreateFrame("Button", "LibAPIAutoCompleteKeyboardCaptureDown", capture)
  capture.down.key = "DOWN"
  capture.down:SetScript("OnClick", KeyboardCaptureButton_OnClick)

  capture.left = CreateFrame("Button", "LibAPIAutoCompleteKeyboardCaptureLeft", capture)
  capture.left.key = "LEFT"
  capture.left:SetScript("OnClick", KeyboardCaptureButton_OnClick)

  capture.right = CreateFrame("Button", "LibAPIAutoCompleteKeyboardCaptureRight", capture)
  capture.right.key = "RIGHT"
  capture.right:SetScript("OnClick", KeyboardCaptureButton_OnClick)

  capture.enter = CreateFrame("Button", "LibAPIAutoCompleteKeyboardCaptureEnter", capture)
  capture.enter.key = "ENTER"
  capture.enter:SetScript("OnClick", KeyboardCaptureButton_OnClick)

  capture:SetScript("OnUpdate", KeyboardCapture_OnUpdate)
  return capture
end

local function EnableKeyboardCapture()
  if not SetOverrideBindingClick then
    return
  end

  lib.keyboardCapture = lib.keyboardCapture or CreateKeyboardCapture()
  local capture = lib.keyboardCapture
  capture.modifierDown = IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown()
  capture:Show()
  ClearOverrideBindings(capture)
  SetOverrideBindingClick(capture, true, "UP", capture.up:GetName())
  SetOverrideBindingClick(capture, true, "DOWN", capture.down:GetName())
  SetOverrideBindingClick(capture, true, "LEFT", capture.left:GetName())
  SetOverrideBindingClick(capture, true, "RIGHT", capture.right:GetName())
  SetOverrideBindingClick(capture, true, "ENTER", capture.enter:GetName())
end

local function DisableKeyboardCapture()
  local capture = lib.keyboardCapture
  if capture then
    if ClearOverrideBindings then
      ClearOverrideBindings(capture)
    end
    capture:Hide()
    capture.modifierDown = nil
  end
end

local function EnableEditBoxArrowKeyCapture(editbox)
  if editbox.SetAltArrowKeyMode then
    if editbox.APIDoc_oldAltArrowKeyMode == nil then
      editbox.APIDoc_oldAltArrowKeyMode = editbox.GetAltArrowKeyMode and editbox:GetAltArrowKeyMode() or false
    end
    editbox:SetAltArrowKeyMode(true)
  end
end

local function DisableEditBoxArrowKeyCapture(editbox)
  if editbox and editbox.SetAltArrowKeyMode and editbox.APIDoc_oldAltArrowKeyMode ~= nil then
    editbox:SetAltArrowKeyMode(editbox.APIDoc_oldAltArrowKeyMode)
    editbox.APIDoc_oldAltArrowKeyMode = nil
  end
end

local function EnableEditBoxEnterCapture(editbox)
  if editbox.APIDoc_enterCaptureEnabled then
    return
  end

  editbox.APIDoc_enterCaptureEnabled = true
  editbox.APIDoc_hasOldOnEnterPressed = editbox:GetScript("OnEnterPressed") ~= nil
  editbox.APIDoc_oldOnEnterPressed = editbox:GetScript("OnEnterPressed")
  editbox:SetScript("OnEnterPressed", function(...)
    if lib.editbox == editbox and IsWidgetOpen() and HandleKey("ENTER") then
      return
    end
    if editbox.APIDoc_oldOnEnterPressed then
      return editbox.APIDoc_oldOnEnterPressed(...)
    end
  end)
end

local function DisableEditBoxEnterCapture(editbox)
  if not editbox or not editbox.APIDoc_enterCaptureEnabled then
    return
  end

  if editbox.APIDoc_hasOldOnEnterPressed then
    editbox:SetScript("OnEnterPressed", editbox.APIDoc_oldOnEnterPressed)
  else
    editbox:SetScript("OnEnterPressed", nil)
  end
  editbox.APIDoc_enterCaptureEnabled = nil
  editbox.APIDoc_oldOnEnterPressed = nil
  editbox.APIDoc_hasOldOnEnterPressed = nil
end

local function EnableActiveInputCapture(editbox)
  EnableEditBoxArrowKeyCapture(editbox)
  EnableEditBoxEnterCapture(editbox)
  EnableKeyboardCapture()
end

local function DisableActiveInputCapture(editbox)
  DisableKeyboardCapture()
  DisableEditBoxArrowKeyCapture(editbox)
  DisableEditBoxEnterCapture(editbox)
end

function lib:Hide()
  self.scrollBox:Hide()
  self.scrollBar:Hide()
  DisableActiveInputCapture(self.editbox)
  if self.data and not self.data:IsEmpty() then
    self.data:Flush()
  end
end

---Create APIDoc widget and ensure Blizzard_APIDocumentation is loaded
local isInit = false
local function Init()
  if isInit then
    return
  end
  isInit = true

  -- load Blizzard_APIDocumentation
  LoadBlizzard_APIDocumentation()

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

  lib.data = CreateDataProvider()
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
    if lib.editbox == editbox and IsWidgetOpen() and HandleKey(key) then
      return
    end
    if editbox.APIDoc_oldOnKeyDown then
      editbox.APIDoc_oldOnKeyDown(...)
    end
  end)
  if editbox.HasScript and editbox:HasScript("OnArrowPressed") then
    editbox.APIDoc_oldOnArrowPressed = editbox:GetScript("OnArrowPressed")
    editbox:SetScript("OnArrowPressed", function(...)
      local _, key = ...
      if lib.editbox == editbox and IsWidgetOpen() and HandleArrowKey(key) then
        return
      end
      if editbox.APIDoc_oldOnArrowPressed then
        editbox.APIDoc_oldOnArrowPressed(...)
      end
    end)
  end
  editbox:EnableKeyboard(true)
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
  DisableActiveInputCapture(editbox)
  config[editbox] = nil
  editbox:SetScript("OnCursorChanged", editbox.APIDoc_oldOnCursorChanged)
  editbox.APIDoc_oldOnCursorChanged = nil
  editbox:SetScript("OnTextChanged", editbox.APIDoc_oldOnTextChanged)
  editbox.APIDoc_oldOnTextChanged = nil
  editbox:SetScript("OnKeyDown", editbox.APIDoc_oldOnKeyDown)
  editbox.APIDoc_oldOnKeyDown = nil
  if editbox.APIDoc_oldOnArrowPressed then
    editbox:SetScript("OnArrowPressed", editbox.APIDoc_oldOnArrowPressed)
    editbox.APIDoc_oldOnArrowPressed = nil
  end
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
    self.editbox = editbox
    self.scrollBox:Show()
    EnableActiveInputCapture(editbox)
    if lines > maxLinesShown then
      self.scrollBar:Show()
    else
      self.scrollBar:Hide()
    end
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

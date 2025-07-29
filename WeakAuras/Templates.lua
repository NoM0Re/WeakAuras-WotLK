if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local Private = select(2, ...)

local function setCorner(corner, point, relativeTo, x, y, width, height)
  corner:ClearAllPoints()
  corner:SetPoint(point, relativeTo, x, y)
  corner:SetSize(width, height)
end

local function setEdge(edge, point1, relativeTo1, point2, relativeTo2, width, height)
  edge:ClearAllPoints()
  edge:SetSize(width, height)
  edge:SetPoint(point1, relativeTo1, point2, 0, 0)
  edge:SetPoint(point2, relativeTo2, point1, 0, 0)
end

local function UpdateNineSliceBorders(frame)
  local NineSlice = frame.NineSlice
  local PortaitMode = frame:GetFrameLayoutType() == "PortraitMode"
  local topLeftCorner = PortaitMode and NineSlice.TopLeftCorner or NineSlice.TopLeftCornerNoPortrait
  local topEdgeRelativeTo = PortaitMode and NineSlice.TopLeftCorner or NineSlice.TopLeftCornerNoPortrait
  local leftEdgeRelativeTo = PortaitMode and NineSlice.TopLeftCorner or NineSlice.TopLeftCornerNoPortrait
  -- Top Left Corner
  setCorner(topLeftCorner, "TOPLEFT", NineSlice, -13, 16, 75, 75)
  -- Top Right Corner
  setCorner(NineSlice.TopRightCorner, "TOPRIGHT", NineSlice, 4, 16, 75, 75)
  -- Bottom Left Corner
  setCorner(NineSlice.BottomLeftCorner, "BOTTOMLEFT", NineSlice, -13, -3, 32, 32)
  -- Bottom Right Corner
  setCorner(NineSlice.BottomRightCorner, "BOTTOMRIGHT", NineSlice, 4, -3, 32, 32)
  -- Top Edge
  setEdge(NineSlice.TopEdge, "TOPLEFT", topEdgeRelativeTo, "TOPRIGHT", NineSlice.TopRightCorner, 32, 75)
  -- Bottom Edge
  setEdge(NineSlice.BottomEdge, "BOTTOMLEFT", NineSlice.BottomLeftCorner, "BOTTOMRIGHT", NineSlice.BottomRightCorner, 32, 32)
  -- Left Edge
  setEdge(NineSlice.LeftEdge, "TOPLEFT", leftEdgeRelativeTo, "BOTTOMLEFT", NineSlice.BottomLeftCorner, 75, 8)
  -- Right Edge
  setEdge(NineSlice.RightEdge, "TOPLEFT", NineSlice.TopRightCorner, "BOTTOMLEFT", NineSlice.BottomRightCorner, 75, 8)
end

local function InputBoxInstructions_OnTextChanged(self)
  if self:GetText() == "" then
    self.Instructions:Show();
  else
    self.Instructions:Hide();
  end
end

local function InputBoxInstructions_UpdateColorForEnabledState(self, color)
  if color then
    self:SetTextColor(color.r, color.g, color.b, color.a);
  end
end

local function InputBoxInstructions_OnDisable(self)
  InputBoxInstructions_UpdateColorForEnabledState(self, self.disabledColor);
end

local function InputBoxInstructions_OnEnable(self)
  InputBoxInstructions_UpdateColorForEnabledState(self, self.enabledColor);
end

local function SearchBoxTemplate_OnEditFocusLost(self)
  if ( self:GetText() == "" ) then
    self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
    self.clearButton:Hide();
  end
end

local function SearchBoxTemplate_OnEditFocusGained(self)
  self.searchIcon:SetVertexColor(1.0, 1.0, 1.0);
  self.clearButton:Show();
end

function WA_SearchBoxTemplate_OnTextChanged(self)
  if ( not self:HasFocus() and self:GetText() == "" ) then
    self.searchIcon:SetVertexColor(0.6, 0.6, 0.6);
    self.clearButton:Hide();
  else
    self.searchIcon:SetVertexColor(1.0, 1.0, 1.0);
    self.clearButton:Show();
  end
  InputBoxInstructions_OnTextChanged(self);
end

local function SearchBoxTemplate_ClearText(self)
  self:SetText("");
  self:ClearFocus();
end

local function SearchBoxTemplateClearButton_OnClick(self)
  PlaySound("igMainMenuOptionCheckBoxOn");
  SearchBoxTemplate_ClearText(self:GetParent());
end

local function GetParentName(frame)
  return frame:GetName() or frame
end

WeakAuras.XMLTemplates = {
  -- InputBoxTemplate (Retail 11.1.7 (61967))
  ["InputBoxTemplate"] = function(frame)
    frame:EnableMouse(true)
    -- Left Texture
    local left = frame:CreateTexture(nil, "BACKGROUND")
    left:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\CommonSearch")
    left:SetSize(8, 20)
    left:SetPoint("LEFT", frame, "LEFT", -5, 0)
    left:SetTexCoord(0.886719, 0.949219, 0.335938, 0.648438)
    frame.Left = left
    -- Right Texture
    local right = frame:CreateTexture(nil, "BACKGROUND")
    right:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\CommonSearch")
    right:SetSize(8, 20)
    right:SetPoint("RIGHT", frame, "RIGHT", 0, 0)
    right:SetTexCoord(0.00390625, 0.0664062, 0.664062, 0.976562)
    frame.Right = right
    -- Middle Texture (zwischen Left und Right)
    local middle = frame:CreateTexture(nil, "BACKGROUND")
    middle:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\CommonSearch")
    middle:SetSize(10, 20)
    middle:SetTexCoord(0.00390625, 0.878906, 0.335938, 0.648438)
    middle:SetPoint("LEFT", left, "RIGHT")
    middle:SetPoint("RIGHT", right, "LEFT")
    frame.Middle = middle
    -- FontString
    local fontString = frame:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
    frame.FontString = fontString
    -- Scripts
    frame:SetScript("OnEscapePressed", function(self)
      EditBox_ClearFocus(self)
    end)
    frame:SetScript("OnEditFocusLost", function(self)
      EditBox_ClearHighlight(self)
    end)
    frame:SetScript("OnEditFocusGained", function(self)
      EditBox_HighlightText(self)
    end)
  end,

  -- InputBoxInstructionsTemplate (Retail 11.1.7 (61967))
  ["InputBoxInstructionsTemplate"] = function(frame)
    WeakAuras.XMLTemplates["InputBoxTemplate"](frame) -- Inherits from InputBoxTemplate
    --[[ Optional
    frame.disabledColor = { r = 0.35, g = 0.35, b = 0.35, a = 1 }
    frame.enabledColor = { r = 1, g = 1, b = 1, a = 1 }
    ]]
    -- Instructions FontString
    local instructions = frame:CreateFontString(nil, "ARTWORK", "GameFontDisableSmall")
    instructions:SetJustifyH("LEFT")
    instructions:SetJustifyV("MIDDLE")
    instructions:SetAllPoints(frame)
    instructions:SetTextColor(0.35, 0.35, 0.35)
    frame.Instructions = instructions

    -- Skripts
    frame:SetScript("OnTextChanged", InputBoxInstructions_OnTextChanged)
    frame:SetScript("OnDisable", InputBoxInstructions_OnDisable)
    frame:SetScript("OnEnable", InputBoxInstructions_OnEnable)

    -- FontObject
    frame:SetFontObject("GameFontHighlightSmall")
  end,

  -- SearchBoxTemplate (Retail 11.1.7 (61967))
  ["SearchBoxTemplate"] = function(frame)
    WeakAuras.XMLTemplates["InputBoxInstructionsTemplate"](frame) -- Inherits from InputBoxInstructionsTemplate
    frame:SetAutoFocus(false)
    frame:SetTextInsets(16, 20, 0, 0);
    frame.instructionText = SEARCH
    frame.Instructions:SetText(frame.instructionText);
    frame.Instructions:ClearAllPoints();
    frame.Instructions:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, 0);
    frame.Instructions:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -20, 0);
    -- Search-Icon
    local searchIcon = frame:CreateTexture(GetParentName(frame) .. "SearchIcon", "OVERLAY")
    searchIcon:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\CommonSearch")
    searchIcon:SetSize(10, 10)
    searchIcon:SetPoint("LEFT", 1, -1)
    searchIcon:SetTexCoord(0.0742188, 0.167969, 0.664062, 0.851562)
    searchIcon:SetVertexColor(0.6, 0.6, 0.6);
    frame.searchIcon = searchIcon
    -- Clear-Button
    local clearButton = CreateFrame("Button", GetParentName(frame) .. "ClearButton", frame)
    clearButton:SetSize(17, 17)
    clearButton:SetPoint("RIGHT", -3, 0)
    clearButton:Hide()
    frame.clearButton = clearButton
    local texture = clearButton:CreateTexture(nil, "ARTWORK")
    texture:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\CommonSearch")
    texture:SetAlpha(0.5)
    texture:SetSize(10, 10)
    texture:SetPoint("TOPLEFT", 3, -3)
    texture:SetTexCoord(0.175781, 0.253906, 0.664062, 0.820312)
    clearButton.texture = texture
    -- Clear-Button Scripts
    clearButton:SetScript("OnEnter", function(self)
      self.texture:SetAlpha(1.0)
    end)
    clearButton:SetScript("OnLeave", function(self)
      self.texture:SetAlpha(0.5)
    end)
    clearButton:SetScript("OnMouseDown", function(self)
      if self:IsEnabled() then
        self.texture:SetPoint("TOPLEFT", self, "TOPLEFT", 4, -4)
      end
    end)
    clearButton:SetScript("OnMouseUp", function(self)
      self.texture:SetPoint("TOPLEFT", self, "TOPLEFT", 3, -3)
    end)
    clearButton:SetScript("OnClick", SearchBoxTemplateClearButton_OnClick)
    -- EditBox Scripts
    frame:SetScript("OnEscapePressed", EditBox_ClearFocus)
    frame:SetScript("OnEnterPressed", EditBox_ClearFocus)
    frame:SetScript("OnEditFocusLost", SearchBoxTemplate_OnEditFocusLost)
    frame:SetScript("OnEditFocusGained", SearchBoxTemplate_OnEditFocusGained)
    frame:SetScript("OnTextChanged", WA_SearchBoxTemplate_OnTextChanged)
  end,

  -- PortraitFrameTemplate (Retail 11.1.7 (61967))
  -- This is an empty frame with space for a portrait/icon in the top left corner.
  ["PortraitFrameTemplate"] = function(frame)
    frame:SetSize(338, 424)
    -- NineSlice Borders
    local nineSlice = CreateFrame("Frame", nil, frame)
    nineSlice:SetAllPoints(frame)
    nineSlice:SetFrameLevel(125)
    frame.NineSlice = nineSlice
    -- Top Left Corner
    local topLeftCorner = nineSlice:CreateTexture(nil, "OVERLAY")
    topLeftCorner:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetal2x")
    topLeftCorner:SetSize(75, 75)
    topLeftCorner:SetPoint("TOPLEFT", frame, "TOPLEFT", -13, 16)
    topLeftCorner:SetTexCoord(0.00195312, 0.294922, 0.298828, 0.591797)
    nineSlice.TopLeftCorner = topLeftCorner
    -- Top Left Corner No Portrait
    local topLeftCornerNoPortrait = nineSlice:CreateTexture(nil, "OVERLAY")
    topLeftCornerNoPortrait:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetal2x")
    topLeftCornerNoPortrait:SetSize(75, 75)
    topLeftCornerNoPortrait:SetPoint("TOPLEFT", frame, "TOPLEFT", -8, 16)
    topLeftCornerNoPortrait:SetTexCoord(0.00195312, 0.294922, 0.00195312, 0.294922)
    topLeftCornerNoPortrait:Hide()
    nineSlice.TopLeftCornerNoPortrait = topLeftCornerNoPortrait
    -- Top Right Corner
    local topRightCorner = nineSlice:CreateTexture(nil, "OVERLAY")
    topRightCorner:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetal2x")
    topRightCorner:SetSize(75, 75)
    topRightCorner:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 4, 16)
    topRightCorner:SetTexCoord(0.298828, 0.591797, 0.00195312, 0.294922)
    nineSlice.TopRightCorner = topRightCorner
    -- Bottom Left Corner
    local bottomLeftCorner = nineSlice:CreateTexture(nil, "OVERLAY")
    bottomLeftCorner:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetal2x")
    bottomLeftCorner:SetSize(32, 32)
    bottomLeftCorner:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -13, -3)
    bottomLeftCorner:SetTexCoord(0.298828, 0.423828, 0.298828, 0.423828)
    nineSlice.BottomLeftCorner = bottomLeftCorner
    -- Bottom Right Corner
    local bottomRightCorner = nineSlice:CreateTexture(nil, "OVERLAY")
    bottomRightCorner:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetal2x")
    bottomRightCorner:SetSize(32, 32)
    bottomRightCorner:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 4, -3)
    bottomRightCorner:SetTexCoord(0.427734, 0.552734, 0.298828, 0.423828)
    nineSlice.BottomRightCorner = bottomRightCorner
    -- Top Edge
    local topEdge = nineSlice:CreateTexture(nil, "OVERLAY")
    topEdge:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetalHorizontal2x")
    topEdge:SetSize(32, 75)
    topEdge:SetPoint("TOPLEFT", topLeftCorner, "TOPRIGHT", 0, 0)
    topEdge:SetPoint("TOPRIGHT", topRightCorner, "TOPLEFT", 0, 0)
    topEdge:SetHorizTile(true)
    topEdge:SetTexCoord(0.0, 1.0, 0.00390625, 0.589844)
    nineSlice.TopEdge = topEdge
    -- Bottom Edge
    local bottomEdge = nineSlice:CreateTexture(nil, "OVERLAY")
    bottomEdge:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetalHorizontal2x")
    bottomEdge:SetSize(32, 32)
    bottomEdge:SetPoint("BOTTOMLEFT", bottomLeftCorner, "BOTTOMRIGHT", 0, 0)
    bottomEdge:SetPoint("BOTTOMRIGHT", bottomRightCorner, "BOTTOMLEFT", 0, 0)
    bottomEdge:SetHorizTile(true)
    bottomEdge:SetTexCoord(0.0, 0.5, 0.597656, 0.847656)
    nineSlice.BottomEdge = bottomEdge
    -- Left Edge
    local leftEdge = nineSlice:CreateTexture(nil, "OVERLAY")
    leftEdge:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetalVertical2x")
    leftEdge:SetSize(75, 8)
    leftEdge:SetPoint("TOPLEFT", topLeftCorner, "BOTTOMLEFT", 0, 0)
    leftEdge:SetPoint("BOTTOMLEFT", bottomLeftCorner, "TOPLEFT", 0, 0)
    leftEdge:SetVertTile(true)
    leftEdge:SetTexCoord(0.00195312, 0.294922, 0.0, 1.0)
    nineSlice.LeftEdge = leftEdge
    -- Right Edge
    local rightEdge = nineSlice:CreateTexture(nil, "OVERLAY")
    rightEdge:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameMetalVertical2x")
    rightEdge:SetSize(75, 8)
    rightEdge:SetPoint("TOPLEFT", topRightCorner, "BOTTOMLEFT", 0, 0)
    rightEdge:SetPoint("BOTTOMLEFT", bottomRightCorner, "TOPLEFT", 0, 0)
    rightEdge:SetVertTile(true)
    rightEdge:SetTexCoord(0.298828, 0.591797, 0.0, 1.0)
    nineSlice.RightEdge = rightEdge
    -- Portrait Container
    local portraitContainer = CreateFrame("Frame", nil, frame)
    portraitContainer:SetSize(1, 1)
    portraitContainer:SetPoint("TOPLEFT")
    portraitContainer:SetFrameLevel(120)
    frame.PortraitContainer = portraitContainer
    -- Portrait
    local portrait = portraitContainer:CreateTexture(nil, "ARTWORK")
    portrait:SetSize(62, 62)
    portrait:SetPoint("TOPLEFT", portraitContainer, "TOPLEFT", -5, 7)
    portraitContainer.portrait = portrait
    -- Title Container
    local titleContainer = CreateFrame("Frame", nil, frame)
    titleContainer:SetSize(0, 20)
    titleContainer:SetPoint("TOPLEFT", frame, "TOPLEFT", 58, -1)
    titleContainer:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -24, -1)
    titleContainer:SetFrameLevel(126)
    frame.TitleContainer = titleContainer
    -- Title Text
    local titleText = titleContainer:CreateFontString(GetParentName(frame) .. "TitleText", "OVERLAY", "GameFontNormal")
    titleText:SetText("")
    titleText:SetWordWrap(false)
    titleText:SetPoint("TOP", titleContainer, "TOP", 0, -5)
    titleText:SetPoint("LEFT", titleContainer, "LEFT")
    titleText:SetPoint("RIGHT", titleContainer, "RIGHT")
    titleContainer.TitleText = titleText
    -- Close Button
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetSize(24, 24)
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
    closeButton:SetFrameLevel(128)
    frame.CloseButton = closeButton
    closeButton:SetNormalTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    closeButton:GetNormalTexture():SetTexCoord(0.152344, 0.292969, 0.0078125, 0.304688)
    closeButton:SetPushedTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    closeButton:GetPushedTexture():SetTexCoord(0.152344, 0.292969, 0.320312, 0.617188)
    closeButton:SetDisabledTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    closeButton:GetDisabledTexture():SetTexCoord(0.152344, 0.292969, 0.632812, 0.929688)
    closeButton:SetHighlightTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x", "ADD")
    closeButton:GetHighlightTexture():SetTexCoord(0.449219, 0.589844, 0.0078125, 0.304688)
    -- Background
    local bgTexture = frame:CreateTexture(nil, "BACKGROUND")
    bgTexture:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UI-Background-Rock")
    bgTexture:SetHorizTile(true)
    bgTexture:SetVertTile(true)
    bgTexture:SetPoint("TOPLEFT", frame, "TOPLEFT", 2, -21)
    bgTexture:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -2, 2)
    frame.Bg = bgTexture
    -- Border
    local topTileStreaks = frame:CreateTexture(nil, "BORDER")
    topTileStreaks:SetTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\UIFrameHorizontal")
    topTileStreaks:SetSize(256, 43)
    topTileStreaks:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -21)
    topTileStreaks:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -2, -21)
    topTileStreaks:SetHorizTile(true)
    topTileStreaks:SetTexCoord(0.0, 1.0, 0.0078125, 0.34375)
    frame.TopTileStreaks = topTileStreaks
    -- Mixin
    frame.Bg:SetVertexColor(0.5882, 0.6275, 0.6706, 0.8) -- approx. PANEL_BACKGROUND_COLOR #ff1f1e21
    frame.layoutType = "PortraitMode"
    frame.ShowPortrait = function(self)
      self.PortraitContainer:Show();
      self.NineSlice.TopLeftCorner:Show();
      self.NineSlice.TopLeftCornerNoPortrait:Hide();
      self.layoutType = "PortraitMode"
    end
    frame.HidePortrait = function(self)
      self.PortraitContainer:Hide();
      self.NineSlice.TopLeftCorner:Hide();
      self.NineSlice.TopLeftCornerNoPortrait:Show();
      self.layoutType = "NoPortraitMode"
    end
    frame.GetFrameLayoutType = function(self)
      return self.layoutType or self:GetParent().layoutType;
    end
    -- update NineSlice Borders on SizeChanged, since they like to be scuffed when the frame is resized
    frame:SetScript("OnSizeChanged", function(self)
      UpdateNineSliceBorders(self);
    end)
  end,

  -- MaximizeMinimizeButtonFrameTemplate (Retail 11.1.7 (61967))
  ["MaximizeMinimizeButtonFrameTemplate"] = function(frame)
    frame:SetSize(24, 24)
    frame:SetFrameLevel(127)

    -- Maximize Button
    local maximizeButton = CreateFrame("Button", "MaximizeButton", frame)
    maximizeButton:SetAllPoints(frame)
    maximizeButton:Hide()
    frame.MaximizeButton = maximizeButton

    maximizeButton:SetNormalTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    maximizeButton:GetNormalTexture():SetTexCoord(0.300781, 0.441406, 0.0078125, 0.304688)

    maximizeButton:SetPushedTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    maximizeButton:GetPushedTexture():SetTexCoord(0.300781, 0.441406, 0.320312, 0.617188)

    maximizeButton:SetDisabledTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    maximizeButton:GetDisabledTexture():SetTexCoord(0.300781, 0.441406, 0.632812, 0.929688)

    maximizeButton:SetHighlightTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x", "ADD")
    maximizeButton:GetHighlightTexture():SetTexCoord(0.449219, 0.589844, 0.0078125, 0.304688)

    -- Minimize Button
    local minimizeButton = CreateFrame("Button", "MinimizeButton", frame)
    minimizeButton:SetAllPoints(frame)
    frame.MinimizeButton = minimizeButton

    minimizeButton:SetNormalTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    minimizeButton:GetNormalTexture():SetTexCoord(0.00390625, 0.144531, 0.0078125, 0.304688)

    minimizeButton:SetPushedTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    minimizeButton:GetPushedTexture():SetTexCoord(0.00390625, 0.144531, 0.320312, 0.617188)

    minimizeButton:SetDisabledTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x")
    minimizeButton:GetDisabledTexture():SetTexCoord(0.00390625, 0.144531, 0.632812, 0.929688)

    minimizeButton:SetHighlightTexture("Interface\\AddOns\\WeakAuras\\Media\\Textures\\redbutton2x", "ADD")
    minimizeButton:GetHighlightTexture():SetTexCoord(0.449219, 0.589844, 0.0078125, 0.304688)

    -- Mixin
    frame.isMinimized = false
    frame.OnShow = function(self)
      if self.isMinimized then
        self:SetMaximizedLook()
      else
        self:SetMinimizedLook()
      end
    end
    frame.IsMinimized = function(self)
      return self.isMinimized
    end
    frame.SetOnMaximizedCallback = function(self, callback)
      self.maximizedCallback = callback
    end
    frame.SetOnMinimizedCallback = function(self, callback)
      self.minimizedCallback = callback
    end
    frame.Maximize = function(self, skipCallback)
      if self.maximizedCallback and not skipCallback then
        self:maximizedCallback()
      end
      self.isMinimized = false
      self:SetMinimizedLook()
    end
    frame.Minimize = function(self, skipCallback)
      if self.minimizedCallback and not skipCallback then
        self:minimizedCallback()
      end
      self.isMinimized = true
      self:SetMaximizedLook()
    end
    frame.SetMinimizedLook = function(self)
      self.MaximizeButton:Hide()
      self.MinimizeButton:Show()
    end
    frame.SetMaximizedLook = function(self)
      self.MaximizeButton:Show()
      self.MinimizeButton:Hide()
    end
    frame:SetScript("OnShow", function(self)
      self:OnShow();
    end)
    maximizeButton:SetScript("OnClick", function(self)
      self:GetParent():Maximize();
      PlaySound("igMainMenuOptionCheckBoxOn");
    end)
    minimizeButton:SetScript("OnClick", function(self)
      self:GetParent():Minimize();
      PlaySound("igMainMenuOptionCheckBoxOn");
    end)
  end,
}

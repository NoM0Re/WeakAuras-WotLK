if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local OptionsPrivate = select(2, ...)

-- WoW APIs
local CreateFrame = CreateFrame

local AceGUI = LibStub("AceGUI-3.0")

local WeakAuras = WeakAuras
local L = WeakAuras.L

local debugLog

local function ConstructDebugLog(frame)
  local group = AceGUI:Create("WeakAurasInlineGroup");
  group.frame:SetParent(frame);
  group.frame:SetPoint("TOPLEFT", frame, "TOPLEFT", 17, -63);
  group.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -17, 46);
  group.frame:Hide();
  group:SetLayout("flow");

  local copyLabel = AceGUI:Create("Label")
  copyLabel:SetFontObject(GameFontNormal)
  copyLabel:SetFullWidth(true)
  copyLabel:SetText(L["Press Ctrl+C to copy"])
  group:AddChild(copyLabel)

  local input = AceGUI:Create("MultiLineEditBox");
  input:DisableButton(true)
  --input.frame:SetClipsChildren(true);
  input.editBox:SetScript("OnEscapePressed", function() group:Close(); end);
  input.editBox:SetScript("OnMouseUp", function() input.editBox:HighlightText(); end);
  input:SetFullWidth(true)
  input:SetFullHeight(true)
  group:AddChild(input);

  local close = CreateFrame("Button", nil, group.frame, "UIPanelButtonTemplate");
  close:SetScript("OnClick", function() group:Close() end);
  close:SetPoint("BOTTOMRIGHT", -20, -24)
  close:SetFrameLevel(close:GetFrameLevel() + 1)
  close:SetHeight(20);
  close:SetWidth(100);
  close:SetText(L["Close"])

  function group.Open(self, text)
    frame.window = "debuglog";
    frame:UpdateFrameVisible()
    input.editBox:SetScript("OnTextChanged", function() input:SetText(text); input.editBox:HighlightText(); end);
    input.editBox:SetScript("OnMouseUp", function() input.editBox:HighlightText(); end);
    input:SetLabel("");
    input.button:Hide();
    input:SetText(text);
    input.editBox:HighlightText();
    input:SetFocus()

    group:DoLayout()
  end

  function group.Close(self)
    input:ClearFocus();
    frame.window = "default";
    frame:UpdateFrameVisible()
  end

  return group
end

function OptionsPrivate.DebugLog(frame, noConstruct)
  debugLog = debugLog or (not noConstruct and ConstructDebugLog(frame))
  return debugLog
end

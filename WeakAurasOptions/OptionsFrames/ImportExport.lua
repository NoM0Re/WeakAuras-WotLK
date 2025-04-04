if not WeakAuras.IsLibsOK() then return end
local AddonName = ...
local OptionsPrivate = select(2, ...)

-- WoW APIs
local CreateFrame = CreateFrame

local AceGUI = LibStub("AceGUI-3.0")

local WeakAuras = WeakAuras
local L = WeakAuras.L

local importexport

local function ConstructImportExport(frame)
  local group = AceGUI:Create("WeakAurasInlineGroup");
  group.frame:SetParent(frame);
  group.frame:SetPoint("TOPLEFT", frame, "TOPLEFT", 16, -63);
  group.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -16, 46);
  group.frame:Hide();
  group:SetLayout("flow");

  local input = AceGUI:Create("MultiLineEditBox");
  input:DisableButton(true)
  input:SetFullWidth(true)
  input:SetFullHeight(true)
  group:AddChild(input);

  local close = CreateFrame("Button", nil, group.frame, "UIPanelButtonTemplate");
  close:SetScript("OnClick", function() group:Close() end);
  close:SetPoint("BOTTOMRIGHT", -20, -24);
  close:SetFrameLevel(close:GetFrameLevel() + 1)
  close:SetHeight(20);
  close:SetWidth(100);
  close:SetText(L["Close"])

  function group.Open(self, mode, id)
    if(frame.window == "texture") then
      local texturepicker = OptionsPrivate.TexturePicker(frame, true)
      if texturepicker then
        texturepicker:CancelClose();
      end
    elseif(frame.window == "icon") then
      local iconpicker = OptionsPrivate.IconPicker(frame, true)
      if iconpicker then
        iconpicker:CancelClose();
      end
    elseif(frame.window == "model") then
      local modelpicker = OptionsPrivate.ModelPicker(frame, true)
      if modelpicker then
        modelpicker:CancelClose();
      end
    end
    frame.window = "importexport";
    frame:UpdateFrameVisible()
    if(mode == "export" or mode == "table") then
      OptionsPrivate.SetTitle(L["Exporting"])
      if(id) then
        local displayStr;
        if(mode == "export") then
          displayStr = OptionsPrivate.Private.DisplayToString(id, true);
        elseif(mode == "table") then
          displayStr = OptionsPrivate.Private.DataToString(id, true);
        end
        input.editBox:SetMaxBytes(nil); -- Dragonflight doesn't accept nil
        input.editBox:SetScript("OnEscapePressed", function()
          group:Close();
        end);
        input.editBox:SetScript("OnTextChanged", function()
          input:SetText(displayStr); input.editBox:HighlightText();
        end);
        input.editBox:SetScript("OnMouseUp", function()
          input.editBox:HighlightText();
        end);
        input:SetLabel(id.." - "..#displayStr);
        input.button:Hide();
        input:SetText(displayStr);
        input.editBox:HighlightText();
        input:SetFocus();
      end
    elseif(mode == "import") then
      OptionsPrivate.SetTitle(L["Importing"])
      input.editBox:SetScript("OnTextChanged", function(self)
        local pasted = self:GetText()
        pasted = pasted:match("^%s*(.-)%s*$")
        if #pasted > 20 then
          WeakAuras.Import(pasted)
        end
      end)
      input.editBox:SetText("");
      input.editBox:SetScript("OnEscapePressed", function() group:Close(); end);
      input.editBox:SetScript("OnMouseUp", nil);
      input:SetLabel(L["Paste text below"]);
      input:SetFocus();
    end
    group:DoLayout()
  end

  function group.Close()
    input:ClearFocus();
    frame.window = "default";
    frame:UpdateFrameVisible()
  end

  return group
end

function OptionsPrivate.ImportExport(frame, noConstruct)
  importexport = importexport or (not noConstruct and ConstructImportExport(frame))
  return importexport
end

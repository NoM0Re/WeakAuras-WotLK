--[[-----------------------------------------------------------------------------
Checkbox Widget
-------------------------------------------------------------------------------]]
local Type, Version = "CheckBox", 27
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local select, pairs = select, pairs

-- WoW APIs
local PlaySound = PlaySound
local CreateFrame, UIParent = CreateFrame, UIParent

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]
local function AlignImage(self)
	local img = self.image:GetTexture()
	self.text:ClearAllPoints()
	if not img then
		self.text:SetPoint("LEFT", self.checkbg, "RIGHT")
		self.text:SetPoint("RIGHT")
	else
		self.text:SetPoint("LEFT", self.image, "RIGHT", 1, 0)
		self.text:SetPoint("RIGHT")
	end
end

--[[-----------------------------------------------------------------------------
Scripts
-------------------------------------------------------------------------------]]
local function Control_OnEnter(frame)
	frame.obj:Fire("OnEnter")
end

local function Control_OnLeave(frame)
	frame.obj:Fire("OnLeave")
end

local function CheckBox_OnMouseDown(frame)
	local self = frame.obj
	if not self.disabled then
		if self.image:GetTexture() then
			self.text:SetPoint("LEFT", self.image,"RIGHT", 2, -1)
		else
			self.text:SetPoint("LEFT", self.checkbg, "RIGHT", 1, -1)
		end
	end
	AceGUI:ClearFocus()
end

local function CheckBox_OnMouseUp(frame)
	local self = frame.obj
	if not self.disabled then
		self:ToggleChecked()

		if self.checked then
			PlaySound("igMainMenuOptionCheckBoxOn")
		else -- for both nil and false (tristate)
			PlaySound("igMainMenuOptionCheckBoxOff")
		end

		self:Fire("OnValueChanged", self.checked)
		AlignImage(self)
	end
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]
local methods = {
	["OnAcquire"] = function(self)
		self:SetType()
		self:SetValue(false)
		self:SetTriState(nil)
		-- height is calculated from the width and required space for the description
		self:SetWidth(200)
		self:SetImage()
		self:SetDisabled(nil)
		self:SetDescription(nil)
	end,

	-- ["OnRelease"] = nil,

	["OnWidthSet"] = function(self, width)
		if self.desc then
			self.desc:SetWidth(width - 30)
			if self.desc:GetText() and self.desc:GetText() ~= "" then
				self:SetHeight(28 + self.desc:GetStringHeight())
			end
		end
	end,

	["SetDisabled"] = function(self, disabled)
		self.disabled = disabled
		if disabled then
			self.frame:Disable()
			self.text:SetTextColor(0.5, 0.5, 0.5)
			SetDesaturation(self.check, true)
			if self.desc then
				self.desc:SetTextColor(0.5, 0.5, 0.5)
			end
		else
			self.frame:Enable()
			self.text:SetTextColor(1, 1, 1)
			if self.tristate and self.checked == nil then
				SetDesaturation(self.check, true)
			else
				SetDesaturation(self.check, false)
			end
			if self.desc then
				self.desc:SetTextColor(1, 1, 1)
			end
		end
	end,

	["SetValue"] = function(self, value)
		local check = self.check
		self.checked = value
		if value then
			SetDesaturation(check, false)
			check:Show()
		else
			--Nil is the unknown tristate value
			if self.tristate and value == nil then
				SetDesaturation(check, true)
				check:Show()
			else
				SetDesaturation(check, false)
				check:Hide()
			end
		end
		self:SetDisabled(self.disabled)
	end,

	["GetValue"] = function(self)
		return self.checked
	end,

	["SetTriState"] = function(self, enabled)
		self.tristate = enabled
		self:SetValue(self:GetValue())
	end,

	["SetType"] = function(self, type)
		local checkbg = self.checkbg
		local check = self.check
		local highlight = self.highlight

		local size
		if type == "radio" then
			size = 16
			checkbg:SetTexture("Interface\\Buttons\\UI-RadioButton")
			checkbg:SetTexCoord(0, 0.25, 0, 1)
			check:SetTexture("Interface\\Buttons\\UI-RadioButton")
			check:SetTexCoord(0.25, 0.5, 0, 1)
			check:SetBlendMode("ADD")
			highlight:SetTexture("Interface\\Buttons\\UI-RadioButton")
			highlight:SetTexCoord(0.5, 0.75, 0, 1)
		else
			size = 24
			checkbg:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")
			checkbg:SetTexCoord(0, 1, 0, 1)
			check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")
			check:SetTexCoord(0, 1, 0, 1)
			check:SetBlendMode("BLEND")
			highlight:SetTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
			highlight:SetTexCoord(0, 1, 0, 1)
		end
		checkbg:SetHeight(size)
		checkbg:SetWidth(size)
	end,

	["ToggleChecked"] = function(self)
		local value = self:GetValue()
		if self.tristate then
			--cycle in true, nil, false order
			if value then
				self:SetValue(nil)
			elseif value == nil then
				self:SetValue(false)
			else
				self:SetValue(true)
			end
		else
			self:SetValue(not self:GetValue())
		end
	end,

	["SetLabel"] = function(self, label)
		self.text:SetText(label)
	end,

	["SetDescription"] = function(self, desc)
		if desc then
			if not self.desc then
				local f = self.frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", self.checkbg, "TOPRIGHT", 5, -21)
				f:SetWidth(self.frame.width - 30)
				f:SetPoint("RIGHT", self.frame, "RIGHT", -30, 0)
				f:SetJustifyH("LEFT")
				f:SetJustifyV("TOP")
				self.desc = f
			end
			self.desc:Show()
			--self.text:SetFontObject(GameFontNormal)
			self.desc:SetText(desc)
			self:SetHeight(28 + self.desc:GetStringHeight())
		else
			if self.desc then
				self.desc:SetText("")
				self.desc:Hide()
			end
			--self.text:SetFontObject(GameFontHighlight)
			self:SetHeight(24)
		end
	end,

	["SetImage"] = function(self, path, ...)
		local image = self.image
		image:SetTexture(path)

		if image:GetTexture() then
			local n = select("#", ...)
			if n == 4 or n == 8 then
				image:SetTexCoord(...)
			else
				image:SetTexCoord(0, 1, 0, 1)
			end
		end
		AlignImage(self)
	end
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
	local frame = CreateFrame("Button", string.format("%s%d", Type, AceGUI:GetNextWidgetNum(Type)), UIParent)
	frame:Hide()

	frame:EnableMouse(true)
	frame:SetScript("OnEnter", Control_OnEnter)
	frame:SetScript("OnLeave", Control_OnLeave)
	frame:SetScript("OnMouseDown", CheckBox_OnMouseDown)
	frame:SetScript("OnMouseUp", CheckBox_OnMouseUp)

	local checkbg = frame:CreateTexture(nil, "ARTWORK")
	checkbg:SetWidth(24)
	checkbg:SetHeight(24)
	checkbg:SetPoint("TOPLEFT")
	checkbg:SetTexture("Interface\\Buttons\\UI-CheckBox-Up")

	local check = frame:CreateTexture(nil, "OVERLAY")
	check:SetAllPoints(checkbg)
	check:SetTexture("Interface\\Buttons\\UI-CheckBox-Check")

	local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetJustifyH("LEFT")
	text:SetHeight(18)
	text:SetPoint("LEFT", checkbg, "RIGHT")
	text:SetPoint("RIGHT")

	local highlight = frame:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture("Interface\\Buttons\\UI-CheckBox-Highlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(checkbg)

	local image = frame:CreateTexture(nil, "OVERLAY")
	image:SetHeight(16)
	image:SetWidth(16)
	image:SetPoint("LEFT", checkbg, "RIGHT", 1, 0)

	local widget = {
		checkbg   = checkbg,
		check     = check,
		text      = text,
		highlight = highlight,
		image     = image,
		frame     = frame,
		type      = Type
	}
	for method, func in pairs(methods) do
		widget[method] = func
	end

	return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)

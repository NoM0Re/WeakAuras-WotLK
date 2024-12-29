
function WA_MaximizeMinimizeButtonFrame_Mixin(frame)
    if frame.init then return end
    frame.init = true
    frame.isMinimized = false
    frame.maximizedCallback = nil
    frame.minimizedCallback = nil

    local methods = {
        OnShow = function(self)
            if self.isMinimized then
                self:SetMaximizedLook()
            else
                self:SetMinimizedLook()
            end
        end,
        IsMinimized = function(self)
            return self.isMinimized
        end,
        SetOnMaximizedCallback = function(self, callback)
            self.maximizedCallback = callback
        end,
        SetOnMinimizedCallback = function(self, callback)
            self.minimizedCallback = callback
        end,
        Maximize = function(self, skipCallback)
            if self.maximizedCallback and not skipCallback then
                self:maximizedCallback()
            end
            self.isMinimized = false
            self:SetMinimizedLook()
        end,
        Minimize = function(self, skipCallback)
            if self.minimizedCallback and not skipCallback then
                self:minimizedCallback()
            end
            self.isMinimized = true
            self:SetMaximizedLook()
        end,
        SetMinimizedLook = function(self)
            self.MaximizeButton:Hide()
            self.MinimizeButton:Show()
        end,
        SetMaximizedLook = function(self)
            self.MaximizeButton:Show()
            self.MinimizeButton:Hide()
        end,
    }

    for name, func in pairs(methods) do
        frame[name] = func
    end
end

function WA_ButtonFrameTemplate_Mixin(frame)
    local methods = {
        ShowPortrait = function(self)
            self.PortraitContainer:Show();
            self.NineSlice.TopLeftCorner:Show();
            self.NineSlice.TopLeftCornerNoPortrait:Hide();
        end,
        HidePortrait = function(self)
            self.PortraitContainer:Hide();
            self.NineSlice.TopLeftCorner:Hide();
            self.NineSlice.TopLeftCornerNoPortrait:Show();
        end,
    }

    for name, func in pairs(methods) do
        frame[name] = func
    end
end

function WA_UpdateNineSliceBorders(frame)
    local NineSlice = frame.NineSlice
    if not NineSlice then return end

    -- Top Left Corner
    NineSlice.TopLeftCorner:ClearAllPoints()
    NineSlice.TopLeftCorner:SetPoint("TOPLEFT", NineSlice, -13, 16)
    NineSlice.TopLeftCorner:SetSize(75, 75)

    -- Top Right Corner
    NineSlice.TopRightCorner:ClearAllPoints()
    NineSlice.TopRightCorner:SetPoint("TOPRIGHT", NineSlice, 4, 16)
    NineSlice.TopRightCorner:SetSize(75, 75)

    -- Bottom Left Corner
    NineSlice.BottomLeftCorner:ClearAllPoints()
    NineSlice.BottomLeftCorner:SetPoint("BOTTOMLEFT", NineSlice, -13, -3)
    NineSlice.BottomLeftCorner:SetSize(32, 32)

    -- Bottom Right Corner
    NineSlice.BottomRightCorner:ClearAllPoints()
    NineSlice.BottomRightCorner:SetPoint("BOTTOMRIGHT", NineSlice, 4, -3)
    NineSlice.BottomRightCorner:SetSize(32, 32)

    -- Top Edge
    NineSlice.TopEdge:ClearAllPoints()
    NineSlice.TopEdge:SetSize(32, 75)
    NineSlice.TopEdge:SetPoint("TOPLEFT", NineSlice.TopLeftCorner, "TOPRIGHT", 0, 0)
    NineSlice.TopEdge:SetPoint("TOPRIGHT", NineSlice.TopRightCorner, "TOPLEFT", 0, 0)

    -- Bottom Edge
    NineSlice.BottomEdge:ClearAllPoints()
    NineSlice.BottomEdge:SetSize(32, 32)
    NineSlice.BottomEdge:SetPoint("BOTTOMLEFT", NineSlice.BottomLeftCorner, "BOTTOMRIGHT", 0, 0)
    NineSlice.BottomEdge:SetPoint("BOTTOMRIGHT", NineSlice.BottomRightCorner, "BOTTOMLEFT", 0, 0)

    -- Left Edge
    NineSlice.LeftEdge:ClearAllPoints()
    NineSlice.LeftEdge:SetSize(75, 8)
    NineSlice.LeftEdge:SetPoint("TOPLEFT", NineSlice.TopLeftCorner, "BOTTOMLEFT", 0, 0)
    NineSlice.LeftEdge:SetPoint("BOTTOMLEFT", NineSlice.BottomLeftCorner, "TOPLEFT", 0, 0)

    -- Right Edge
    NineSlice.RightEdge:ClearAllPoints()
    NineSlice.RightEdge:SetSize(75, 8)
    NineSlice.RightEdge:SetPoint("TOPLEFT", NineSlice.TopRightCorner, "BOTTOMLEFT", 0, 0)
    NineSlice.RightEdge:SetPoint("BOTTOMLEFT", NineSlice.BottomRightCorner, "TOPLEFT", 0, 0)
end

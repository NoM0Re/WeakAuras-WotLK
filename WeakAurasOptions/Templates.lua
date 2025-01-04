
function WA_MaximizeMinimizeButtonFrame_Mixin(frame)
    if frame and frame.init then return end
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

function WA_PortraitFrameTemplate_Mixin(frame)
    if frame and frame.init then return end
    frame.init = true
    frame.Bg:SetVertexColor(0.5882, 0.6275, 0.6706, 0.8) -- approx. PANEL_BACKGROUND_COLOR #ff1f1e21
    frame.layoutType = "PortraitMode"

    local methods = {
        ShowPortrait = function(self)
            self.PortraitContainer:Show();
            self.NineSlice.TopLeftCorner:Show();
            self.NineSlice.TopLeftCornerNoPortrait:Hide();
            self.layoutType = "PortraitMode"
        end,
        HidePortrait = function(self)
            self.PortraitContainer:Hide();
            self.NineSlice.TopLeftCorner:Hide();
            self.NineSlice.TopLeftCornerNoPortrait:Show();
            self.layoutType = "NoPortraitMode"
        end,
        GetFrameLayoutType = function(self)
            return self.layoutType or self:GetParent().layoutType;
        end
    }

    for name, func in pairs(methods) do
        frame[name] = func
    end
end

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

function WA_UpdateNineSliceBorders(frame)
    local NineSlice = frame.NineSlice
    if not NineSlice then return end
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

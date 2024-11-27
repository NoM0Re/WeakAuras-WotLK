
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
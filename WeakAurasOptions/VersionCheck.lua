local AddonName = ...
local Private = select(2, ...)

local L = WeakAuras.L

local optionsVersion = "5.20.1 Beta"

if optionsVersion ~= WeakAuras.versionString then
  local message = string.format(L["The WeakAuras Options Addon version %s doesn't match the WeakAuras version %s. If you updated the addon while the game was running, try restarting World of Warcraft. Otherwise try reinstalling WeakAuras"],
                    optionsVersion, WeakAuras.versionString)
  WeakAuras.IsLibsOk = function() return false end
  WeakAuras.ToggleOptions = function()
       WeakAuras.prettyPrint(message)
  end
end

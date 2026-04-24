if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.6',
  dateString = '2026-04-17',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.5...5.21.6',
  highlightText = [==[
]==],  commitText = [==[NoM0Re (1):

- Titan: Update Destruction Warlock talents

]==]
}

if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.2',
  dateString = '2026-01-30',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.1...5.21.2',
  highlightText = [==[
- Add Titan encounter info]==],  commitText = [==[InfusOnWoW (2):

- Update WeakAurasModelPaths from wago.tools
- Remove retail .toc files and disabled model path update for retail

NoM0Re (1):

- Titan: add next phase encounter list

]==]
}

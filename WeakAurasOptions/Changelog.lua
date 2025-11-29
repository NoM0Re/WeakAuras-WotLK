if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.7',
  dateString = '2025-11-27',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.6...5.20.7',
  highlightText = [==[
- Basic support for Wrath Titan (thanks WoW CN community)
- Support for new Masque version
- Various bug fixes]==],  commitText = [==[Copilot (1):

- Fix allstates:Get to return false instead of nil

InfusOnWoW (6):

- Masque Support: Support new masque version
- Profiling: Add an inherit font
- BT Multi Target mode: add warnings on it, and if it's missing a filter
- Update Discord List
- Fix regression in Abbreviate numbers on retail
- Update Discord List

NoM0Re (6):

- Titan: Replace encounter data with phase 1 raids & bosses
- Titan: remove neutral faction group
- Titan: fix repair dialog text assignment
- Glyph Load: Only show in Mists of Pandaria
- Remove atlas file from Wrath Titan Reforge
- Add Wrath Titan Reforged support

Stanzilla (4):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (2):

- Bump actions/checkout from 5 to 6
- Bump actions/upload-artifact from 4 to 5

mrbuds (2):

- Remove atlas files
- Model's Icon set to sword guy on classic, fixes #6075

]==]
}

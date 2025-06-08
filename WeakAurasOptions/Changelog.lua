if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.10-10-g7ac7dc84',
  dateString = '2025-06-03',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.10...7ac7dc84e2f702747d8bd01f2bfd63b8fc8bab7f',
  commitText = [==[InfusOnWoW (4):

- Load Instance Type: Add "None" to the list
- Fix missing aura_env for Custom onLoad/onUnload
- Alternate Power: Add UNIT_POWER_BAR_HIDE event
- Update Discord List

Stanzilla (1):

- Update WeakAurasModelPaths from wago.tools

mrbuds (5):

- Fix loadstring error's error with subtext #5892
- Use the new glyphID returned by GetGlyphSocketInfo
- Mists: add WeakAuras.CheckTalentForUnit and WeakAuras.CheckGlyphForUnit
- Fix error when clicking on load tab
- Mist of Pandaria (#5850)

]==]
}

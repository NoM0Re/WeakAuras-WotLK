if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.11',
  dateString = '2025-06-09',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.10...5.19.11',
  highlightText = [==[
Bugfixes and initial Mists of Pandaria support

Fixes:
- Custom Options: Fix lua error on subOptions sorting
- Fix missing aura_env for Custom onLoad/onUnload
- Alternate Power: Add UNIT_POWER_BAR_HIDE event
- Fix loadstring error's error with subtext #5892]==],  commitText = [==[InfusOnWoW (5):

- Custom Options: Fix lua error on subOptions sorting
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

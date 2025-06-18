if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.12',
  dateString = '2025-06-17',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.11...5.19.12',
  highlightText = [==[
- Bugfixes and performance improvements]==],  commitText = [==[Stanzilla (2):

- chore(toc): bump version for retail patch 11.5.7
- Update WeakAurasModelPaths from wago.tools

mrbuds (2):

- Health trigger: add absorb options on Mists
- Don't trigger partyX unit event with the filter :group when in raid

]==]
}

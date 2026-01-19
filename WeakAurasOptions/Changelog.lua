if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.21.1',
  dateString = '2026-01-11',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.0...5.21.1',
  highlightText = [==[
- Classic bug fixes]==],  commitText = [==[NoM0Re (3):

- Classic/TBC/Wrath: add groupRole and fetchRole to BuffTrigger2
- Fix: Regression in talent load
- Fix: Add missing difficulty entry

]==]
}

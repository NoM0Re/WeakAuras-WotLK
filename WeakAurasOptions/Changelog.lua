if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.2',
  dateString = '2025-08-15',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.1...5.20.2',
  highlightText = [==[
bugfix release for some broken textures]==],  commitText = [==[Pewtro (2):

- Re-export the .blp files
- Add Celestial Dungeon load option instance type

emptyrivers (1):

- some more difficulty ids

]==]
}

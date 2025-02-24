if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.3',
  dateString = '2025-02-24',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.2...5.19.3',
  highlightText = [==[
- Remove left-over debug output]==],  commitText = [==[InfusOnWoW (2):

- Update Discord List
- Update Atlas File List from wago.tools

Stanzilla (1):

- Update WeakAurasModelPaths from wago.tools

anon1231823 (1):

- Add esMX to toc files

emptyrivers (1):

- deduplicate localization phrases

mrbuds (2):

- Allstates helper methods (#5195)
- Cleanup leftover debug print in item in range condition

]==]
}

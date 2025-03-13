if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.5',
  dateString = '2025-03-10',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.4...5.19.5',
  highlightText = [==[
No new features this release, just fixes to some minor bugs]==],  commitText = [==[InfusOnWoW (9):

- Update Discord List
- Update Discord List
- Stop Motion Sub Element: Fix setting of custom row/colum etc settings
- Partially revert 4e628f546befa7
- Being in Excavation Site 9 IsInInstance() returns false
- Texture Sub Element: Don't resize main aura on atlas selection
- Workaround boss unit stupidity by Blizzard
- Workaround INSTANCE_ENGAGE_UNIT with incosistent UnitGUID/UnitExists
- Remove Stop Motion texture data

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (4):

- Bump cbrgm/mastodon-github-action from 2.1.12 to 2.1.13
- Bump tsickert/discord-webhook from 6.0.0 to 7.0.0
- Bump leafo/gh-actions-luarocks from 4 to 5
- Bump leafo/gh-actions-lua from 10 to 11

emptyrivers (1):

- remove spurious enUS translations

]==]
}

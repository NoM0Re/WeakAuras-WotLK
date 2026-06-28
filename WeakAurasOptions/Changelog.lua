if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.8',
  dateString = '2026-06-29',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.7...5.21.8',
  highlightText = [==[
TOC bumps and regression fixes]==],  commitText = [==[InfusOnWoW (7):

- Adjust Code options on Action tab to TimeMachine
- Update Discord List
- Fix Renaming of Auras that are used as anchors to other auras
- Custom Options: Fix setting of min/max values
- Fix manual progress if the user never sets the total
- Update Item Cooldowns on SPELL_UPDATE_USABLE
- Update Discord List

Jettie (1):

- Fix bug: AdditionalProgress is not showing up when using circular mode. (#6243)

NoM0Re (4):

- Mists: TOC Bump
- TBC: TOC Bump
- TBC/Mists: Disable AssistedCombat Trigger
- Titan: Update Shadow Priest Talents

Stanzilla (3):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (3):

- Bump Stanzilla/cat from 2.0.2 to 2.0.3
- Bump cbrgm/mastodon-github-action from 2.2.0 to 2.2.1
- Bump actions/checkout from 6.0.2 to 6.0.3

]==]
}

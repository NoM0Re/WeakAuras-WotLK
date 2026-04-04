if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.3',
  dateString = '2026-03-30',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.2...5.21.3',
  highlightText = [==[
- Release for new Titan realms patch]==],  commitText = [==[InfusOnWoW (8):

- Sound Repeat Option: Fix missing step value
- Add a missing WeakAuras.Add
- Remove the only dependency on state.trigger
- Tweak cloneId matching between triggers
- Make state.show optional
- Remove SPELL_UPDATE_USEABLE from global cooldown tracking
- Tweak Repair Dialogs text setting
- Update Discord List

NoM0Re (1):

- Titan: Update EncounterAndZoneLists for Phase 3

Stanzilla (6):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (3):

- Bump actions/upload-artifact from 6 to 7 (#6156)
- Bump cbrgm/mastodon-github-action from 2.1.25 to 2.1.26
- Bump cbrgm/mastodon-github-action from 2.1.22 to 2.1.25

]==]
}

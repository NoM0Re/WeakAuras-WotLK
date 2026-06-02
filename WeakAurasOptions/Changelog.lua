if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.7',
  dateString = '2026-06-03',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.6...5.21.7',
  highlightText = [==[
Fix Pride logo time check]==],  commitText = [==[InfusOnWoW (15):

- Fix Pride logo time check
- Custom Options: Fix regression in changing user settings on a group
- Create a font string for each font on options first load
- Fix lua error on creating a icon in a dynamic group
- Update Discord List
- Fix Item Cooldown Trigger if Item is on CD on first login
- Fix rename lua error
- Add an option to squelch auras on load
- AnimationOptions: Move to TimeMachine
- Move ActionOptions to TimeMachine
- InformationOptions: Move most Options to TimeMachine
- MOP PTR: Hack code so that the fake nameplate anchor shows up
- Icon: Fix ghost timed progress appearing on icons after Options close
- Progress Bar: Make tooltip area configurable
- Fix regression in tracking item cooldowns

NoM0Re (10):

- Titan: Update EncounterAndZoneLists for Phase 4
- Titan: Update Retribution Paladin Talents
- Fix: Model thumbnail transform not resetting correctly after changing api
- Minor fixes and cleanups across project
- Set consistent empty font flags
- Further Fix SetFont "None" flag
- ProgressTexture: Fix SetCropY and SetRegionHeight setters
- Mists: TOC Bump
- Mists: TOC Bump
- BossMods: fix typo in expired states

Stanzilla (6):

- Update WeakAurasModelPaths from wago.tools
- Harden GitHub Actions workflows
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (7):

- Bump Stanzilla/cat
- Bump nebularg/actions-luacheck
- Bump actions/github-script from 8.0.0 to 9.0.0
- Bump nebularg/actions-discord-webhook
- Update BigWigsMods/packager requirement to 12e08b28e30e3df84cc508525ebfcdf3818ad86c
- Bump leafo/gh-actions-lua from 12.0.0 to 13.0.0
- Bump cbrgm/mastodon-github-action from 2.1.27 to 2.2.0

emptyrivers (1):

- AuthorOptions: Adopt TimeMachine by ressurecting the code from PR #4863

mrbuds (1):

- Fix SetFont error with "None" flag

]==]
}

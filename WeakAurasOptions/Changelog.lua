if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.22.1',
  dateString = '2026-10-10',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.22.0...5.22.1',
  highlightText = [==[
]==],  commitText = [==[InfusOnWoW (3):

- Hardcore: Show a warning on the Options window about hardcore
- Hardcore: Use lowest compression level for hardcore
- Hardcode: Fix import warning for custom code

Nnoggie (2):

- Update wow-interface-updater to v1.3.0
- chore: update interface updater to v1.2.0

NoM0Re (6):

- Enable CreatureType, IncomingSummon, ProcGlow
- Update Character Stats
- Enable Absorb, Heal Absorb and Incoming Heal to Health Trigger
- WeakAuras: Upgrade deprecated API
- Titan: Prepare EncounterAndZoneLists
- WeakAuras: Update security

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

copilot-swe-agent[bot] (1):

- fix: update LibCompress source URL

dependabot[bot] (5):

- build(deps): bump BigWigsMods/packager
- build(deps): bump nearform-actions/github-action-notify-twitter
- build(deps): bump cbrgm/mastodon-github-action from 2.2.4 to 2.2.5
- build(deps): bump cbrgm/mastodon-github-action from 2.2.3 to 2.2.4
- build(deps): bump BigWigsMods/packager

emptyrivers (1):

- don't register a nonexistent sound

github-actions[bot] (3):

- Update WeakAurasModelPaths from wago.tools (#6324)
- Update WeakAurasModelPaths from wago.tools (#6322)
- Update WeakAurasModelPaths from wago.tools (#6318)

]==]
}

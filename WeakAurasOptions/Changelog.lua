if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.5',
  dateString = '2026-04-13',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.4...5.21.5',
  highlightText = [==[
More Updates for Titan and Regression Fixes]==],  commitText = [==[InfusOnWoW (2):

- Update Discord List
- Update WeakAurasModelPaths from wago.tools

NoM0Re (7):

- Titan: Enable Proc Glow
- Titan: disable AssistedCombat in GenericTrigger
- BossMods: fix clone state cleanup typo
- Titan: disable AssistedCombat and fix item set description
- Fix: Replace deprecated GetCurrencyInfo with C_CurrencyInfo API
- Titan: TOC Bump
- Remove redundant CheckItemSlotCooldowns call

Stanzilla (1):

- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (2):

- Bump cbrgm/mastodon-github-action from 2.1.26 to 2.1.27
- Bump exercism/pr-commenter-action from 1.5.1 to 1.5.2

]==]
}

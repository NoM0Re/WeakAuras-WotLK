if not WeakAuras.IsLibsOK() then return end
---@type string
local AddonName = ...
---@class OptionsPrivate
local OptionsPrivate = select(2, ...)
OptionsPrivate.changelog = {
  versionString = '5.21.4',
  dateString = '2026-04-06',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.21.3...5.21.4',
  highlightText = [==[
- regression fixes]==],  commitText = [==[InfusOnWoW (7):

- Fix regression in some triggers not hiding
- Fix regression in TSU helpers for creating/updating states
- Fix regressin in Spell Cooldown tracking with shared cooldowns
- And another try to fix the PR build
- Try again to fix PR build
- Try fixing PR build bot
- Item Trigger: Fix lua error on tracking invalid item ids

]==]
}

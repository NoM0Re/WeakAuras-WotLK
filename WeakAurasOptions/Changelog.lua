if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.10',
  dateString = '2025-05-31',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.9...5.19.10',
  highlightText = [==[
Fix babelfish.lua writing]==],  commitText = [==[InfusOnWoW (19):

- Fix babelfish.lua writing
- Localization: Restore a few accidentally dropped english translations
- Add a pride month logo and use it in June
- Guard against duration being 0 leading to division by zero error
- Revert "State: Don't put the trigger table into the state"
- Update Atlas File List from wago.tools
- Update Discord List
- Update Discord List
- State: Don't put the trigger table into the state
- Fix "Negator" localization
- Boss Mod Trigger: Fix count condition
- Rework TextEditor's edit error handling
- Update Discord List
- Sub Element Anchoring: Make options a bit less confussing
- Rename "Nameplate Type" to "Hostility"
- Unit Characteristics/Health/Power trigger
- On loadstring error, print a better hint where the error comes form
- Add a onLoad/onUnload custom function
- Update Discord List

Stanzilla (4):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

mrbuds (5):

- Add an "Assisted Combat Next Cast" trigger for 11.1.7
- Fix typo
- Use spellId arg of SPELL_UPDATE_COOLDOWN
- BossMod Announce: fix count condition
- Fix tooltips with custom code using unitAuraInstanceID

]==]
}

if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.5',
  dateString = '2025-10-09',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.4...5.20.5',
  highlightText = [==[
]==],  commitText = [==[InfusOnWoW (13):

- Update Discord List
- BT2: Make the spell id tooltip in the options clickable
- Conditions: Tweak handling of custom function
- Totem trigger: Add spellId check and use slot information from event
- Boss Mod Count Conditions: Use same cron syntax as for the trigger
- Conditions: Properly escape string checks to support [].
- Update Atlas File List from wago.tools
- Update Discord List
- CLEU: Replace combobox with one entry with a disabled checkbox
- Fix inserting links into the display text boxes
- Fix regression for textured Ticks
- Revert "Revert "Fix KR/TW/CN large number formatting for >= 100.000.000""
- Update Discord List

Stanzilla (5):

- chore: update retail toc for 11.2.5
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

Veldt (1):

- Add Bleak Arrows to reset_ranged_swing_spells

dependabot[bot] (1):

- Bump leafo/gh-actions-lua from 11 to 12

mrbuds (2):

- Function for checking if we are on a Hardcore server doesn't exists on Retail
- Scary warning on import on Hardcore server

]==]
}

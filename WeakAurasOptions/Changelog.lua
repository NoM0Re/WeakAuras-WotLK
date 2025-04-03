if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.6',
  dateString = '2025-04-02',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.5...5.19.6',
  highlightText = [==[
Fixes:

- Bug report url points to the correct issue template now.
- model subregions were punished & will now obey the rotation option.
- Fixed Bigwigs trigger following an update of that addon. (thanks @ntowle!)
- Fixed misc errors with fallback states (i.e. when options are open).
- Fixed some templates which were producing nonsense auras.
- Localization should have fewer duplicate phrases for our translators to work through.
- Fixed an oversight with how progress works for sub-elements attached to an empty region.
- The sliders on stop motion animation start/end properties should now behave as sliders, not just weird looking inputs.
- Fixed spell cache to account for some insane choices blizzard made.
- Ticks now correctly update their location when progress source is changed via conditions.
- String-valued properties can now be correctly "unset" via conditions without having to do arcane workarounds.
- A progress source from an inactive trigger no longer does insane things.
- Faction reputation trigger no longer gives a mangled %standing string for renown-style factions.

New Features:

- There's a new "Since Active" condition variable, which allows for temporary property changes when a trigger activates.
- Pending updates to installed auras have a context menu to help make it less frustrating if you want to do anything other than accept the update.
- Load has a new player guild option, works similarly to player name.
- Health trigger absorb & heal absorb overlays now support "Attach to End, backwards" mode.
- Several formatters learned how to pad strings with spaces on the left or right sides. WeakAuras.PadString(string, mode, length) is also available in custom code to perform the same task.
- Item Equipped trigger & load option learned how to do exact match on the item id.]==],  commitText = [==[InfusOnWoW (27):

- Sub Models: Fix rotation setting
- Revert "Simplify Condition Test functions"
- Conditions: Add an activationTime for triggers
- Simplify Condition Test functions
- Remove triggerState[id].activeTrigger
- Change code using triggerState[id].activeTrigger
- Fix Automatic Progress Sources on sub elements
- Update Atlas File List from wago.tools
- Update Discord List
- Add id also to fallback states
- Remove unused Private.GetActiveTrigger function
- Fix UpdateProgress notification
- Fix lua error for health trigger's absorb overlays withe fake states
- Update Atlas File List from wago.tools
- Update Discord List
- Fix lua error on showing fake states with ticks
- Fix "Automatic Progress" of Sub Elements attached to an Empty Base
- Update Atlas File List from wago.tools
- Load: Add a guild name option
- Health trigger: Add aborb at end reversed mode
- StopMotion: Fix up/down buttons for start/end percent
- Tweak spell cache building
- Formatters: Add a pad option to various formatters
- Ticks: Update Ticks on UpdateProgress not on Update
- Fix string Conditions not unsetting if string left empty default
- Item Equipped: Add exact match to load options/fix name matching
- Sub Regions: Fix progress not updating on trigger deactivation

Nick Towle (1):

- Fix BigWigs locale for Break and Pull bars (#5782)

Stanzilla (4):

- Update WeakAurasModelPaths from wago.tools
- pull enUS locale for Options from CF
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

emptyrivers (1):

- RENOWN_LEVEL_LABEL globalstring changed with 11.1

mrbuds (4):

- UpdatePendingButton: add context menu with list of linked auras
- Fix ascendance template
- Update bug report url
- BossMod triggers: bar timers doesn't require to be enable in addon settings anymore, add an option to still filter matching add settings

]==]
}

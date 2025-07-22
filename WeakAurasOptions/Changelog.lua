if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.0',
  dateString = '2025-07-21',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.12...5.20.0',
  highlightText = [==[
- **Added Undo & Redo Framework:** This lays the groundwork for undoing and redoing all aura edits. While the feature is still in development, you can test it now on URL edits. To enable it, type `/wa feature enable undo`.
- **New default formatters**: Setting `%unit` or `%guid` or `%p` will now auto select proper formatting options
- **Mists of Pandaria Updates:** Lots of Template updates and bug fixes to WA features.
- **Performance and Stability:** Addressed various bugs.]==],  commitText = [==[InfusOnWoW (16):

- Update Atlas File List from wago.tools
- Update Discord List
- Mop templates: Druid, Monk, DK, Warlock and Paladin Update
- Don't announce destroyng an empty universe
- Update WeakAurasModelPaths from wago.tools
- Update Discord List
- Update Atlas File List from wago.tools
- Mists: Add Power/Stagger trigger
- Don't send watch trigger events while Options are open
- Text: Call UpdateProgress so that relative animations work
- Progress Settings: Adjust on moving/deleting triggers
- Range Trigger: Fix progress source setting
- Add Default Formatters for text replacements
- Fix locale on english realms
- Update Discord List
- Update Discord List

Stanzilla (3):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

emptyrivers (2):

- always advance mergeOptions pointer to the end if no merge is found
- undo & redo support (#4863)

github-actions[bot] (2):

- Update Discord List (#5943)
- Update WeakAurasModelPaths from wago.tools (#5944)

mopstats (1):

- Add pet battle events for mop (#5938)

mrbuds (19):

- LibSpecialization tiny update
- LibSpecialization update
- Mists rogue templates
- Mists priest templates
- Load the Time Machine on Mists
- Mists mage templates
- Mists shaman templates
- Fix Mists talent known trigger
- Add missing shaman talents
- Fix Glyph data on first load
- Mists use a dedicated file for modelpaths
- Remove missing "Blizzard Alerts" textures on Mists
- timed format default set time_dynamic_threshold = 3
- default color for guid
- Fix formatter type test
- Allow default formatter to have sub formatter options
- Mists Template: Hunter
- Mists Template: Warrior
- Fix error with talent tree on 11.2.0 beta

]==]
}

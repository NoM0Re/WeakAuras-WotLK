if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.1',
  dateString = '2025-08-05',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.0...5.20.1',
  highlightText = [==[
new game patch, new weakauras version

- load status indicator (the little power icon) now changes shape depending on load status in addition to color
- item count trigger no longer claims to check the reagent bank, since that doesn't exist anymore
- custom code meant to run on every frame now has a builtin throttle option, so no more need for if GetTime() > (aura_env.last + 1) boilerplate :)]==],  commitText = [==[InfusOnWoW (2):

- Tweak loaded/standby/unloaded icons
- Bufftrigger: Fix Unit Caste condition

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

emptyrivers (4):

- drop reagent bank option
- toc bump
- lazily get rid of STATICPOPUPS_NUMDIALOGS
- protect weakauras against unaligned ai

mrbuds (3):

- Add throttle option for everyframe custom triggers
- Add throttle option for everyframe custom text
- Make profiling of BuffTrigger2 more granular

]==]
}

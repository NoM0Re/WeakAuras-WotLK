if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.9',
  dateString = '2025-04-25',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.8...5.19.9',
  highlightText = [==[
- Currency trigger: Add type checking to guard against unexpected data
- Unit Characteristics trigger: add creature type & family
- TSUHelper: hide __changed from pairs()]==],  commitText = [==[InfusOnWoW (4):

- Bump .toc files
- Icon: If OmniCC or ElvUI are installed hide blizzard cooldown numbers
- Currency trigger: Add type checking to guard against unexpected data
- Unit Characteristics trigger: add creature type & family
- TSUHelper: hide __changed from pairs()
- Update Discord List

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

mrbuds (3):

- Unit Characteristics trigger: add creature type & family (Retail only)
- Textute Atlas Picker: use C_Texture.GetAtlasElements on Retail
- TSUHelper: hide __changed from pairs()

]==]
}

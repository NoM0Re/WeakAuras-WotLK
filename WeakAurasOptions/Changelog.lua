if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.20.6',
  dateString = '2025-10-21',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.5...5.20.6',
  highlightText = [==[
bugfix release for 1.15.8 & toc bump for classic era & mop classic

fixes:

- icon visible condition behavior is more sane now
- another workaround for insane AbbreviateNumbers behavior
- adjusted to new api environment in classic era

removals:

- WeakAuras now detects & refuses to boot if it was installed on a Midnight client, instead of spewing thousands of errors.]==],  commitText = [==[Adal (1):

- update mists toc for 5.5.1

InfusOnWoW (5):

- Update Discord List
- Update Discord List
- Fix Icon visible Condition not reversing correctly
- Midnight: Disable WeakAuras with an message
- Mop/Classic: Workaround another bug in AbbreviateNumbers

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update WeakAurasModelPaths from wago.tools

mrbuds (1):

- Classic Era 1.15.8 update

]==]
}

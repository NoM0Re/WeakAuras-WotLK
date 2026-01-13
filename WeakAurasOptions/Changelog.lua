if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.21.0',
  dateString = '2026-01-12',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.20.7...5.21.0',
  highlightText = [==[
- TBC Anniversary support
- Fixes for Titan realms
- Improvements for Masque support
- Deprecation warning for Midnight]==],  commitText = [==[InfusOnWoW (2):

- Add a warning to the WeakAuras window about Midnight (#6126)
- Update Discord List

NoM0Re (6):

- TBC Anniversary support
- Retail: TOC Bump
- Mists: TOC Bump
- Titan: remove unused talent_types_specific
- MiniTalent: fix closing the widget after selecting a talent
- Titan: Raid Launch Fixes

Stanzilla (2):

- Update WeakAurasModelPaths from wago.tools
- Update Discord List

StormFX (1):

- Fix Masque glow support. (Closes #6098)

dependabot[bot] (5):

- Bump actions/upload-artifact from 5 to 6
- Bump peter-evans/create-pull-request from 7 to 8
- Bump leafo/gh-actions-luarocks from 5 to 6
- Bump cbrgm/mastodon-github-action from 2.1.19 to 2.1.22
- Bump peter-evans/create-pull-request from 6 to 7

github-actions[bot] (2):

- Update WeakAurasModelPaths from wago.tools (#6130)
- Update WeakAurasModelPaths from wago.tools (#6121)

]==]
}

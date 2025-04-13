if not WeakAuras.IsLibsOK() then return end

local AddonName = ...
local OptionsPrivate = select(2, ...)

OptionsPrivate.changelog = {
  versionString = '5.19.8',
  dateString = '2025-04-11',
  fullChangeLogUrl = 'https://github.com/WeakAuras/WeakAuras2/compare/5.19.7...5.19.8',
  highlightText = [==[
TOC update for SoD phase 8

New Features:

- states:Replace(id, newstate) & states:Get(id, key) are now available in TSU custom triggers
- subtext & condition change text learned to support UI escape sequences, like the text region type already does
- Spell Activation Overlay events are available in Cata classic, so the related trigger has been re-enabled for that game flavor
- Scarlet Enclave encounter IDs added for SoD

Fixes:

- Item Equipped load/trigger forces exact match now, to deal with e.g. normal/heroic versions of the same item
- unit formatters produces empty string "" instead of "nil" when the underlying unit token is invalid
- various fixes to options panel & thanks list so they don't look terrible (thanks @pewtro!)
- Fixed some templates which were invalidated in 11.1
- Reminded chat msg - emote trigger to pay attention to CHAT_MSG_TEXT_EMOTE again]==],  commitText = [==[InfusOnWoW (8):

- Item Equipped: Force "exact match" mode
- Make SubText + Conditions also use IndentionLib.encode/decode for text
- Make Unit formatting not return "nil"
- Tweak bottom buttons until they all fit
- Enable Spell Activation Overlay Glow trigger in Cata
- Chat: Fix Emote filter for /commands
- Templates: Update to 11.1 patch changes
- Update Discord List

Pewtro (1):

- Fix an issue with word wrapping in the Discord thanks list

Stanzilla (1):

- Update WeakAurasModelPaths from wago.tools

dependabot[bot] (1):

- Bump cbrgm/mastodon-github-action from 2.1.13 to 2.1.14

mrbuds (4):

- TSUHelpers: add states:Replace() and states:Get() functions, + bug fixes
- Add Encounter IDs for Scarlet Enclave
- Update Atlas File List from wago.tools
- SoD P8 toc update

]==]
}
# Changelog

Write release notes under a heading that matches the tag version, for example `## 5.0.0`.
Use :WALurk: or when in June :WALurkPride:

## 5.21.7

:WALurkPride: 5.21.7

# WeakAuras WotLK is out of Beta!

This release marks WeakAuras WotLK as officially released for Wrath of the Lich King 3.3.5a.

It all started with a simple goal: getting WeakAuras working for Awesome WotLK. Over a year of development and 500+ commits later, WeakAuras WotLK has reached roughly 97% parity with the modern WeakAuras2 codebase.

The remaining differences are mostly intentional WotLK compatibility work, unsupported Retail-era systems, and client-specific API limitations.

A big thank you to everyone who used the addon during the beta, reported bugs, opened issues, shared feedback, or helped others in the community.

Thank you all for being part of the journey.

New Features:
- Add an option to squelch auras on load
- AuthorOptions: Adopt TimeMachine
- Move ActionOptions, AnimationOptions, and most InformationOptions to TimeMachine
- Progress Bar: Make tooltip area configurable

Fixes:
- Fix Pride logo time check
- Further fix SetFont with the "None" flag
- Fix SetFont error with the "None" flag
- Fix Item Cooldown Trigger if item is on cooldown on first login
- Fix rename lua error
- Icon: Fix ghost timed progress appearing on icons after Options close
- ProgressTexture: Fix SetCropY and SetRegionHeight setters
- BossMods: Fix typo in expired states
- Fix regression in tracking item cooldowns
- Update WeakAurasModelPaths from wago.tools
- Update Discord List

Backport New Features:
- Introduce sub-elements for circular and linear Textures
- Add the shared circular/linear ProgressTexture code path
- Backport LibAPIAutoComplete for the text editor and event inputs
- Add APIDocumentation-based autocomplete to the WeakAuras text editor and event inputs
- Add `SetCollapsesLayout` support for undo/redo option work
- Add release packaging workflow for tag-based GitHub Releases
- Add stable `WeakAuras2.zip` release asset name for permanent latest-release downloads
- Add `CHANGELOG.md` release-note extraction for GitHub Releases
- Remove the `Beta` suffix from the displayed WeakAuras and Options versions

Backport Fixes:
- Block newer auras importing, as it caused enough issues
- Preserve unsupported imported options with compatibility warnings
- Rework Modernize handling for newer imports
- Backport ProgressTexture and Model code paths from upstream
- Fix PLAYER_FLAGS_CHANGED event registration
- Switch spell cache matching to a better regex
- Correct non-functional `SetPosition` calls to use separate x/y/z setters
- Purge WrathReborn code, rip
- Keep license and notice files in release archives

## 5.21.6

:WALurk: 5.21.6

## 5.21.5

:WALurk: 5.21.5

Fixes:
- Fix Boss Mods typo

Backport Fixes:
- Refactor encounter dispatcher

## 5.21.4

:WALurk: 5.21.4

Fixes:
- Fix regression in some triggers not hiding
- Fix regression in TSU helpers for creating/updating states

## 5.21.3

:WALurk: 5.21.3

New Features:
- State System Changes
- Reworked how states are shown/hidden
- `state.show` is no longer required to control visibility
- A state is now shown simply by existing in `allstates`
- Removing a state from `allstates` will hide it
- `state.show = false` is still supported for backwards compatibility and hides clones
- Setting `state.show = nil` is now deprecated and triggers a warning in custom TSU updaters
- Added compatibility handling for existing auras relying on old behavior
- Fixed stale state data being used during progress updates by ensuring states are removed before updates run

Fixes:
- Sound Repeat Option: fixed missing step value

Backport New Features:
- Updated compatibility functions and moved them to a private scope, still accessible in the WeakAuras code editor

Backport Fixes:
- Fixed importing for newer auras
- Fixed PreShow when no expirationTime is present
- Reworked Modernize system
- Lifted unit restriction on Combo Points and added a note about limitations
- Fixed Dynamic Groups not loading correctly on login due to unreliable client load timing
- Added nil check to MoverSizer

## 5.21.2

:WALurk: 5.21.2

Backport Fixes:
- Removed the Midnight support ending warning
- Fixed combo points not updating while in a vehicle
- Fixed Class & Spec localizations for zhCN, thanks to @Emi_Noether

## 5.21.1

:WALurk: 5.21.1

Backport New Features:
- Updated LibGetFrame

Backport Fixes:
- Fix Texture desaturate state lost on texture change

## 5.21.0

:WALurk: 5.21.0

New Features:
- Talent Known: Trigger now uses WeakAurasMiniTalent
- Add a warning to the WeakAuras window about Midnight for this version

Fixes:
- MiniTalent: Keep talent widget open after selecting a talent

Backport New Features:
- Load: Talent Option now shows when a spec is selected, not only class

Backport Fixes:
- Fixed long-standing frame level overflow issues
- Added frame level cap to prevent UI restrictions
- Currency: Fixed options table not initializing correctly on login
- Talents: Load Wrath talent data only on Wrath realms
- LibGroupTalents: Protected UNIT_AURA handler against nil units
- AceConfigDialog: Restored missing popup template
- Removed STATICPOPUP_NUMDIALOGS
- Add Stormforge PTR realm detection
- Purged TBC, as it is unused

## 5.20.7

:WALurk: 5.20.7

New Features:
- Character Stats: Add Defense

Fixes:
- Fix `allstates:Get` returning nil instead of false
- Model region updated to Arthas, replacing a model that can cause seizures

Backport New Features:
- BuffTrigger: Introduce inRange trigger
- Rework Magnetic Edit to Retail behavior
- Add prefix negation to zoneId and encounterId load checks
- Add Stormforge support

Backport Fixes:
- Progress Texture: Uninitialized inverse option caused progress to mirror/ignore inversion
- Dynamic Group: Delay Resize to next frame to fix child positioning
- Spell Cache: Correct rebuild condition to avoid constant rebuilding
- Encounter: encounterid load option checking wrong variable
- Fix missing polling for ignoreInvisible, thanks to @jgreten
- Fix missing polling for inRange, thanks to @jgreten
- Handle multiple Frostmourne realm names
- Special check for DBM-Frostmourne compatibility
- Second special check for DBM-Frostmourne for newest methods
- Prevent BossMods nil access when no BossMod is initialized and remove restrictions, thanks to @scrublama
- Change nameplate detection object from `WeakAuras.WatchNameplates()`, thanks to @KhalGH
- Handle unsupported DBM state in Unified

## 5.20.6

:WALurk: 5.20.6

New Features:
- None

Fixes:
- Icon visible condition behavior is more sane now

Backport New Features:
- None

Backport Fixes:
- Talents: Ignore selected but not visible talents in the check
- InputBoxTemplate: Set FontObject correctly

## 5.20.5

:WALurk: 5.20.5

New Features:
- BT2: Make spell ID tooltip in options clickable
- Boss Mod Count Conditions: Use the same cron syntax as for the trigger
- CLEU: Replace combobox with a disabled checkbox entry

Fixes:
- Conditions: Improve handling of custom functions
- Conditions: Properly escape string checks to support `[]`
- Display Text: Fix inserting links into text boxes
- Ticks: Fix regression for textured ticks

Backport New Features:
- Replace Blizzard_APIDocumentation with Wrath Private Data
- Implement Encounter Trigger and Load Options via DBM
- Fire ENCOUNTER_START / ENCOUNTER_END and DBM callback events for custom triggers

Backport Fixes:
- Boss Mods: Small refactor and code consistency improvements
- Fix non-localized TIME_UNIT_DELIMITER

## 5.20.4

:WALurk: 5.20.4

Fixes:
- No code changes since 5.20.3; CurseForge was not correctly distributing this version for their addon

## 5.20.3

:WALurk: 5.20.3

New Features:
- Text to speech voice via awesome_wotlk is no longer a per-aura setting and now follows the game's TTS CVars
- Default TTS values: Voice = 1, Speed = 0, Volume = 100
- Include overEnergize in combat log state
- BossMod Trigger: Add multiselect filter for break and pull timer

Fixes:
- Fix typo in variable name
- Totem Trigger: Fix "inverse" option not being visible
- Custom Text: Tweak rules for text replacement `%cfoo ~= %c`
- Ticks: Fix color sometimes applying to the wrong tick

Backport New Features:
- With the awesome_wotlk retail backport of C_VoiceChat, Text-to-Speech can be used directly inside WeakAuras
- Add Item Type Equipped trigger and load trigger
- Change awesome_wotlk distribution to @someweirdhuman's
- Add AwesomeCVar to OptionalDeps
- Add README installation instructions
- Transmission: Bring transmission logic up to date

Backport Fixes:
- TimeUtils updated to fix KR/TW/CN large number formatting for >= 100,000,000
- LibDeflate: Codec delimiter
- Epoch: Fix error with Pools
- Conditions: ProgressSource condition formatter
- Load: Wrap all zone-change events to ensure reliable aura loading
- Several Epoch related changes to support the server
- Updated wiki pages for awesome_wotlk and WeakAuras Companion

## 5.20.2

:WALurk: 5.20.2

New Features:
- None

Fixes:
- Bugfix release for some broken textures

Backport New Features:
- Added Talent support for an additional Epoch realm

Backport Fixes:
- Fixed an issue where Stealth and Prowl spell triggers appeared on cooldown instead of paused

## 5.20.1

:WALurk: 5.20.1

New Features:
- Custom code OnUpdate: Added a built-in throttle option for custom code that runs every frame
- Load status indicator: The power icon now changes shape in addition to color

Fixes:
- Bufftrigger: Fixed the Unit Caster condition

Backport New Features:
- The searchbar template has been ported to Lua and now has a slightly different look
- XML templates have been ported to Lua
- Updated AceGUI/AceConfig to the latest version to fix `$parent` if parent is nil frame issues on this game version

Backport Fixes:
- Corrected the Enhancement spec locale for deDE
- Removed LibBabble: TalentTree because it was not needed and caused issues with LibGroupTalents for other addons
- Fixed the Elemental locale, which was being overwritten with the wrong localization for some locales

## 5.20.0

:WALurk: 5.20.0

New Features:
- Added Undo & Redo Framework for aura edits, currently testable on URL edits with `/wa feature enable undo`
- New default formatters: Setting `%unit`, `%guid`, or `%p` now auto-selects proper formatting options

Fixes:
- Always advance mergeOptions pointer to the end if no merge is found
- Do not send watch trigger events while Options are open
- Text: Call UpdateProgress so relative animations work
- Progress Settings: Adjust on moving/deleting triggers
- Fix locale on English realms

Backport New Features:
- BuffTrigger: Added "Cast by Player" and "Is Boss Debuff" option
- Added Blizzard_APIDocumentation and a Search API button to the Code Editor using Wrath Classic data
- WeakAurasTemplates is now included, backported with data from Wrath of the Lich King Classic

Backport Fixes:
- Addressed nameplate anchoring issues caused by anchoring to hidden frames
- Corrected update behavior for "Group Leader/Assist" load options
- Fixed an issue where the "Inverse" option on the Cast Trigger was not applied correctly

## 5.19.12

:WALurkPride: 5.19.12

New Features:
- None

Fixes:
- Do not trigger partyX unit event with the filter `:group` when in raid

Backport New Features:
- None

Backport Fixes:
- Money Trigger: Now uses GetCoinIcon function instead
- LibGetFrame: Improved the backported version and fixed a typo
- Mounted Frame: Slightly improved measurement performance
- Faction Reputation Trigger: Removed localizations and now retrieves data from GetFactionInfoByID
- Load Option Race: Added localization by extracting it from GetFactionInfoByID
- Creature Types/Families Trigger Option: Removed a few localizations that were exact matches from GetFactionInfoByID

## 5.19.11

:WALurkPride: 5.19.11

New Features:
- None

Fixes:
- Custom Options: Fix lua error on subOptions sorting
- Fix missing aura_env for Custom onLoad/onUnload
- Fix loadstring error's error with subtext
- Fix error when clicking on load tab
- Update Discord List

Backport New Features:
- Integrated Wayback Machine support into the code editor via buttons, saving a maximum of 10 entries
- Added Trigger: Spell Cast Succeeded
- Updated all libraries to their latest versions, except AceGUI and AceConfig

Backport Fixes:
- Fixed a regression causing stuttery power updates by re-adding FRAME_UPDATE for non-multi-unit frames
- Fixed SwingTimer Offhand in a minimal way that works for most common cases

## 5.19.10

:WALurkPride: 5.19.10

New Features:
- Add a pride month logo and use it in June
- Add an onLoad/onUnload custom function

Fixes:
- LibCustomGlow: Fixed "Attempted to release inactive object"
- Localization: Restore a few accidentally dropped English translations
- Guard against duration being 0 leading to division by zero error
- Fix "Negator" localization
- Boss Mod Trigger: Fix count condition
- Rework TextEditor's edit error handling
- Sub Element Anchoring: Make options a bit less confusing
- Rename "Nameplate Type" to "Hostility"
- Unit Characteristics/Health/Power trigger updates
- On loadstring error, print a better hint where the error comes from
- BossMod Announce: Fix count condition
- Update Discord List

Backport New Features:
- Glyph Load Option
- Add ProcGlow to LibCustomGlow-1.0 and WeakAuras
- Spell Triggers: New trigger and condition options, including "Disable Spell Known Check" and "Show CD of Charge"
- New flavor-detection functions: `WeakAuras.IsWrath()`, `WeakAuras.IsTBC()`, `WeakAuras.IsClassicPlus()`, and `WeakAuras.IsClassicPlusOrTBC()`

Backport Fixes:
- RegionType Icon
- Prevent flickering when reverse state remains unchanged, thanks to @Zidras
- LibCustomGlow: Minor performance improvement to ProcGlow and improved structure/indentation
- Init Rework: Renamed `WeakAuras.isAwesomeEnabled()` to `WeakAuras.IsAwesomeEnabled()`
- Init Rework: Added flavor functions
- GenericTrigger Rework: Aligned with retail structure
- Spell Details: Major rework for performance and functionality, including ignoreRunes fix
- Renamed `WeakAuras.WatchPlayerMoveSpeed` to `WeakAuras.WatchForPlayerMoving`
- Added PLAYER_MOVING_UPDATE while still firing PLAYER_MOVE_SPEED_UPDATE
- Improved Item Count performance
- Prevent nil error when cleaning up states
- Regex: Short weapon enchant name now extracts without Roman numeral suffix, thanks to @Artur91425
- Types Rework: Matched retail structure
- Disabled Death Knight for TBC and ClassicPlus flavors
- Prototypes: Further aligned built-in triggers with retail
- Refactored `WeakAuras.IsSpellKnown()` and pet variants
- Load Options: Reorganized load options order
- Removed SPELL_UPDATE_USABLE event for race and spec_position
- Renamed zoneId to Player Location ID(s)
- Power Trigger: Huge performance boost
- Combo Points merged into Power Trigger, thanks to @Artur91425
- Spell Trigger: Updated to new SpellDetails and retail structure
- Action Usable Trigger: Listens to rune events only if player uses Rune Power
- Death Knight Rune Trigger: Small performance gain
- Character Stats: Reorganized trigger options order
- Character Stats: Added PLAYER_DAMAGE_DONE_MODS to events
- Item Trigger: Fixed IsItemInRange
- Currency Trigger: Learned how to handle Honor and Arena Points
- Removed redundant TimeUtil
- Modernize: Migrated missing "power" and "power_operator" fields in Power Trigger

## 5.19.9

:WALurk: 5.19.9

New Features:
- Unit Characteristics trigger: Add creature type and family

Fixes:
- Currency trigger: Add type checking to guard against unexpected data
- TSUHelper: Hide `__changed` from `pairs()`
- Update Discord List

Backport New Features:
- Faction Reputation Trigger has been added
- Retail SharedMedia and SharedMediaAdditionalFonts have been ported

Backport Fixes:
- Band-aid ElvUI Nameplate anchoring to a hidden element
- Fixed toc version of WeakAuras Stop Motion
- Fixed threat unit "At Least One Enemy"
- Workaround for LGT not recognizing Druid Guardian class/spec
- Fixed deDE localization for Druid Restoration

## 5.19.8

:WALurk: 5.19.8

New Features:
- `states:Replace(id, newstate)` and `states:Get(id, key)` are now available in TSU custom triggers
- Subtext and condition change text learned to support UI escape sequences

Fixes:
- Item Equipped load/trigger forces exact match for normal/heroic versions of the same item
- Unit formatters produce empty string instead of "nil" when the underlying unit token is invalid
- Various fixes to options panel and thanks list, thanks Pewtro
- Reminded chat msg / emote trigger to pay attention to CHAT_MSG_TEXT_EMOTE again

Backport Fixes:
- WeakAuras now also supports DBM 7.0.5+ versions for trigger compatibility
- Added zLocales file to make releases easier

## 5.19.7

:WALurk: 5.19.7

Fixes:
- Revert a change to item equipped load and triggers that caused unacceptable performance characteristics
- Pending updates section of options has minor cosmetic improvements

## 5.19.6

:WALurk: 5.19.6

Fixes:
- Model regions now obey the rotation option
- Fixed BigWigs trigger following an update of that addon, thanks ntowle
- Fixed miscellaneous errors with fallback states when options are open
- Localization should have fewer duplicate phrases for translators
- Fixed an oversight with how progress works for sub-elements attached to an empty region
- Stop motion animation start/end sliders now behave as sliders
- Ticks now correctly update their location when progress source changes via conditions
- String-valued properties can now be correctly unset via conditions
- A progress source from an inactive trigger no longer behaves incorrectly

New Features:
- New "Since Active" condition variable
- Pending updates to installed auras have a context menu
- Load has a new player guild option
- Several formatters learned how to pad strings with spaces on the left or right sides
- `WeakAuras.PadString(string, mode, length)` is available in custom code
- Item Equipped trigger and load option learned exact match on item id

Backport Fixes:
- Fixed spell cache ignores gear icon correctly
- Fixed spell cache causing BT2 auraNames icons not to display
- Fixed lua error when `WeakAuras.GetRegion` is wrapped in an anonymous function with no scope to `aura_env`
- Fixed Class & Spec Load/Triggers to use retail logic and not depend on creator locale
- Fixed ruRU and esES LibBabble-TalentTree-3.0 locales
- Added ChatFrame Stratafix into the addon

## 5.19.5

:WALurk: 5.19.5

Fixes:
- Minor bug fixes

## 5.19.3

:WALurk: 5.19.3

New Features:
- New AllStates (TSU) helper methods for efficiently creating, updating, and removing states
- Added `states:Update(key, newState)`
- Added `states:Remove(key)`
- Added `states:RemoveAll()`
- These helpers update existing states instead of replacing them, return true if a change was made, and simplify custom trigger state management
- More details: https://github.com/NoM0Re/WeakAuras-WotLK/wiki/Trigger-State-Updater-(TSU)#all-states-helper-methods

Notes:
- This does not replace the existing allstates structure

## Announcements

### 2026-05-24 - LibAPIAutoComplete

:WALurk: Enable LibAPIAutoComplete for TextEditor and Events

- LibAPIAutoComplete has been backported
- Added APIDocumentation-based autocomplete to the WeakAuras text editor and event inputs

### 2026-05-22 - ProgressTexture Refactor Test Build

:WALurk: Introduce sub elements for circular/linear Textures

- Upcoming ProgressTexture refactor: https://github.com/NoM0Re/WeakAuras-WotLK/pull/108
- Added the new shared circular/linear ProgressTexture code path
- Heavily refactored ProgressTexture
- Added Circular Texture sub-elements
- Added Linear Texture sub-elements
- Fixed a bunch of bugs related to ProgressTexture regions
- Before testing, back up your WTF folder
- Test build: https://github.com/NoM0Re/WeakAuras-WotLK/archive/refs/heads/progress-refactor-2.0.zip

### 2025-12-25 - Frame Level Overflow

:WALurk: How a hidden WeakAuras bug survived almost four years

- WeakAuras had a long-standing frame level issue introduced with nested groups in WA 4.0
- On the WotLK client, frame levels are stored as a signed 8-bit integer, giving a safe range of 0-127
- Frame levels are now derived from tree depth instead of being assigned sequentially
- WeakAurasFrame can now live on FrameStrata MEDIUM without fighting Blizzard UI frames using SetTopLevel(true)
- If elements need to render above or below others within the same group, FrameStrata should be adjusted explicitly

### 2025-10-04 - Encounter Trigger / Load Options via DBM

:WALurk: Encounter Trigger / Load Options via DBM

- Adds support for Encounter Triggers and Load Options
- Fires Blizz-like ENCOUNTER_START and ENCOUNTER_END events
- DBM callbacks are also sent directly so custom triggers can catch them
- Requires DBM-Warmane Revision 20250929200404 or newer
- Update DBM: https://github.com/Zidras/DBM-Warmane/?tab=readme-ov-file#how-to-install-for-the-first-time

### 2025-10-03 - WeakAuras and Midnight

:WALurk: Upcoming changes to Retail: Midnight

- Upstream WeakAuras announced major changes around the Midnight expansion
- This WotLK port should remain mostly unchanged, with adjustments only if truly needed
- Patreon post: https://www.patreon.com/posts/weakauras-x-140349416

### 2025-10-01 - Wrath Private API Documentation

:WALurk: Blizzard_APIDocumentation is finally updated with Wrath Private Data

- Function APIs and Events are merged and can be looked up through the Code Editor with the Search API button
- APIDocumentation is loaded on demand when Search API is clicked
- Reloading the UI after using it is still recommended

### 2025-08-25 - Text-to-Speech via awesome_wotlk

:WALurk: Text-to-Speech in WeakAuras via awesome_wotlk

- With the awesome_wotlk retail backport of C_VoiceChat, Text-to-Speech can be used directly inside WeakAuras
- Set it up through Conditions and Actions
- awesome_wotlk: https://github.com/someweirdhuman/awesome_wotlk?tab=readme-ov-file#installation

### 2025-07-05 - APIDocumentation

:WALurk: Blizzard_APIDocumentation

- APIDocumentation is now included, backported with data from Wrath of the Lich King Classic
- It is accessible in the Code Editor via the Search API button
- The AddOn is loaded on demand and should be followed by a UI reload after use

### 2025-06-30 - Wiki Pages

:WALurkPride: Added three new wiki pages

- https://github.com/NoM0Re/WeakAuras-WotLK/wiki/Large-Address-Aware
- https://github.com/NoM0Re/WeakAuras-WotLK/wiki/awesome_wotlk
- https://github.com/NoM0Re/WeakAuras-WotLK/wiki/WeakAuras-Companion

### 2025-06-19 - WeakAuras Templates

:WALurkPride: WeakAuras Templates

- WeakAurasTemplates is now included, backported with data from Wrath of the Lich King Classic
- Provides a curated collection of premade WeakAura templates for classes and specializations

### 2025-06-04 - Wayback Machine Support

:WALurkPride: Added Wayback Machine Support via Buttons

- The Wayback Machine is integrated using buttons because SetScript methods for OnKeyDown/OnKeyUp are not available on this game version

### 2025-05-01 - ProcGlow

:WALurk: Added ProcGlow to LibCustomGlow-1.0 and WeakAuras

- The retail ProcGlow animation is now part of the library
- Backported with custom flipbook logic and support for start and loop sequences

### 2025-04-26 - AddOns Update Tool Config

- Created a config for alchem1ster's World of Warcraft AddOns Update Tool
- Tool: https://github.com/alchem1ster/AddOns-Update-Tool/releases
- Source: https://github.com/alchem1ster/AddOns-Update-Tool

### 2025-04-22 - SharedMedia

:WALurk: Ported Retail SharedMedia and SharedMediaAdditionalFonts

- SharedMedia adds more bar textures and fonts
- SharedMediaAdditionalFonts adds more fonts
- Links are on the WeakAuras README extensions section

### 2025-04-15 - Faction Reputation Trigger

:WALurk: Faction Reputation Trigger has been added

- Uses Retail FactionIDs
- Depends on accurate translations
- Missing translations were marked in zLocales for review

### 2025-04-07 - DBM Compatibility

:WALurk: WeakAuras now also supports DBM 7.0.5+ versions for trigger compatibility

- Latest DBM-Warmane is still strongly recommended for full functionality and best support
- Update DBM: https://github.com/Zidras/DBM-Warmane/?tab=readme-ov-file#how-to-install-for-the-first-time

### 2025-04-03 - DBM Update Notice

- DBM must be updated to the latest 12th Mar+ DBM-Warmane version for DBM triggers to work
- Thanks to @Zidras
- Commit: https://github.com/Zidras/DBM-Warmane/commit/b6804570cab39a1c0412f964d1f2c15a63b96eed
- Update DBM: https://github.com/Zidras/DBM-Warmane/?tab=readme-ov-file#how-to-install-for-the-first-time

### 2025-03-31 - Class & Spec Data Reset Notice

- Due to an error in the Class & Spec implementation for Load Conditions and Triggers, Class & Spec data for those triggers was erased and must be reselected
- The system now applies Retail logic

### 2025-02-23 - Onyxia Support

- Onyxia is now supported
- Using the same aura on other realms such as Icecrown may cause conflicts because of talent index differences, but should not cause Lua errors

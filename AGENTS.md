# Agent Guide: WeakAuras2 WotLK Port

This repository is a Wrath of the Lich King 3.3.5a port of WeakAuras2.
Agents should treat the upstream WeakAuras2 project as the primary design and behavior reference, and this repository as a compatibility port.

---

## 1. Project Goal

* **Project:** WeakAuras 2, ported/adapted for WoW WotLK 3.3.5a.
* **Target game version:** Wrath of the Lich King, patch 3.3.5a.
* **Interface version:** `30300`.
* **Language/runtime:** Lua 5.1, World of Warcraft addon environment.
* **Primary objective:** Keep this codebase as close as practical to upstream WeakAuras2 while making it run correctly on 3.3.5a.

This is intended to be a near 1:1 port. Do not add custom features, custom architecture, or speculative rewrites unless the user explicitly asks for them. Prefer small compatibility workarounds over original implementations.

When a modern WeakAuras2 file differs from this repository, first assume the upstream version is important context. Preserve upstream structure, naming, and behavior wherever 3.3.5a allows it.

---

## 2. Porting Rules

* Before changing behavior, check how upstream WeakAuras2 does it when possible.
* Keep file layout, function names, tables, option keys, and control flow close to upstream.
* Make the smallest 3.3.5a compatibility change that solves the problem.
* Avoid custom abstractions unless they directly replace an unavailable Retail API or runtime feature.
* Prefer compatibility shims/wrappers over editing many call sites.
* Do not modernize Lua syntax beyond what WoW 3.3.5a supports.
* Do not assume Retail, Classic Era, Cataclysm Classic, or Dragonflight APIs exist.
* If an upstream feature cannot be supported on 3.3.5a, preserve the surrounding structure and disable/degrade only the unsupported part.

The ideal patch looks like upstream WeakAuras2 with only the minimum necessary WotLK differences.

---

## 3. Critical API Context

The `APIDocumentation` folder is the local source of truth for the 3.3.5a API surface.

* Use `APIDocumentation/Documentation/*.lua` to verify exact functions, events, argument lists, and return values.
* Use `APIDocumentation/Blizzard_APIDocumentation.lua` to understand how API docs are registered.
* Be especially careful with:
  * `C_*` namespaces.
  * Combat log event payloads.
  * Aura APIs such as `UnitAura`, `UnitBuff`, and `UnitDebuff`.
  * Inspect/talent APIs.
  * Item, spell, cooldown, and action bar APIs.
  * Events that exist in Retail but not in WotLK.

If the API docs and upstream WeakAuras2 disagree, adapt the upstream behavior to the documented 3.3.5a API with the smallest compatibility layer possible.

---

## 4. Repository Layout

### Root

* `AGENTS.md`: agent rules for this port.
* `prompt.txt`: generated code2prompt dump. Useful as a broad index/snapshot, but not the primary source of truth.
* `stylua.toml`: formatting rules.
* `CONTRIBUTING.md`: upstream contribution/style conventions.
* `.luacheckrc` and `.luarc.json`: Lua diagnostics configuration.

### `WeakAuras`

Core runtime addon.

Important files:

* `WeakAuras.toc`: load order and addon metadata.
* `Init.lua`, `WeakAuras.lua`, `DefaultOptions.lua`: initialization and core state.
* `Types_ClassicPlus.lua`, `Types_Wrath.lua`, `Types.lua`: type and option data. Load order matters.
* `BuffTrigger2.lua`, `GenericTrigger.lua`: trigger/event evaluation.
* `Conditions.lua`: conditional display logic.
* `AuraEnvironment.lua`, `AuraEnvironmentWrappedSystems.lua`: custom code environment and exposed APIs.
* `RegionTypes`, `BaseRegions`, `SubRegionTypes`: display implementations.
* `Locales`: localization files.

### `WeakAurasOptions`

Load-on-demand configuration UI, loaded by `/wa`.

Important files:

* `WeakAurasOptions.toc`: load order for options code.
* `TriggerOptions.lua`, `BuffTrigger2.lua`, `GenericTrigger.lua`: trigger configuration UI.
* `DisplayOptions.lua`, `ConditionOptions.lua`, `LoadOptions.lua`, `ActionOptions.lua`, `AnimationOptions.lua`: major option sections.
* `AceGUI-Widgets`: custom widgets used by the options UI.
* `Locales`: localized option strings.

### Other Addons

* `WeakAurasTemplates`: template data and UI.
* `WeakAurasArchive`: archive support.
* `WeakAurasModelPaths`: model path data.
* `WeakAurasStopMotion`: stop motion textures and support.
* `APIDocumentation`: local 3.3.5a API documentation addon.

---

## 5. Load Order Rules

Always respect `.toc` file order. WoW addon files are loaded sequentially, and many files depend on globals/tables created earlier.

Before moving code, adding dependencies, or introducing a new file:

* Check the relevant `.toc`.
* Prefer editing an existing corresponding file over adding a new file.
* If a file must be added, update the `.toc` in the correct position.
* Do not assume modules can be imported like normal Lua packages.

---

## 6. Coding Standards

Follow the existing style and upstream WeakAuras conventions.

* Lua indentation is 2 spaces.
* Use Unix line endings.
* `stylua.toml` sets `column_width = 180`.
* Avoid semicolons in new code.
* Preserve existing semicolons when editing code that already uses them; they are useful for comparing against upstream/developer code.
* Match surrounding style when editing older code that already uses semicolons.
* Keep Lua 5.1 compatibility.
* Avoid unnecessary churn and broad reformatting.
* Do not rewrite vendored libraries or generated/media data unless explicitly needed.

User-facing strings must be localized:

* Use `L["Some text"]`.
* Use double quoted strings inside localization keys.
* Keep the localization table named `L` in code so the scraper can find strings.
* Add or preserve locale entries consistently when changing UI text.

---

## 7. Files To Treat Carefully

Avoid editing these unless the task requires it:

* `WeakAuras/Libs`
* `WeakAurasOptions/Libs`
* media assets: `.blp`, `.tga`, `.ogg`, `.mp3`, fonts, texture sources
* generated dumps such as `prompt.txt`
* large locale sweeps unless changing a user-facing string

For upstream porting work, prefer changing the smallest compatibility boundary rather than repeatedly patching generated/vendor-like data.

---

## 8. Validation

When possible:

* Run `stylua` on touched Lua files.
* Run `luacheck` if available and practical.
* Check `.toc` load order after adding or moving files.
* For API-sensitive changes, verify against `APIDocumentation`.

Many issues can only be fully verified inside the WoW 3.3.5a client. If a change cannot be tested locally outside the game, state that clearly.

---

## 9. Agent Behavior

When working in this repository:

* Preserve upstream WeakAuras2 intent.
* Prefer porting and compatibility fixes over custom feature code.
* Keep diffs minimal and easy to compare with upstream.
* Search before changing shared systems.
* Explain any unavoidable divergence from upstream.
* Do not remove compatibility code unless you understand why it exists.
* Do not make broad refactors as part of a bug fix.

The maintainer usually wants upstream behavior ported to 3.3.5a, not new behavior invented for this fork.

# Agent Guide: WeakAuras2 WotLK Port

This repository is a Wrath of the Lich King 3.3.5a port of WeakAuras2.
Treat upstream WeakAuras2 as the primary design and behavior reference, and this repository as a compatibility port.

---

## 1. Project Goal

* **Project:** WeakAuras 2, ported/adapted for WoW WotLK 3.3.5a.
* **Target game version:** Wrath of the Lich King, patch 3.3.5a.
* **Interface version:** `30300`.
* **Language/runtime:** Lua 5.1, World of Warcraft addon environment.
* **Primary objective:** Keep this codebase as close as practical to upstream WeakAuras2 while making it run correctly on 3.3.5a.

This is intended to be a near 1:1 port. Prefer small compatibility workarounds over original implementations.

Maintainer policy: if a feature does not exist in upstream WeakAuras2, it does not belong in this repository. New feature ideas should go upstream first; only port them here after they exist upstream and can be supported on WotLK 3.3.5a.

Do not add custom features, custom architecture, speculative rewrites, or port-only behavior unless the user explicitly confirms they want to diverge from upstream.

---

## 2. Porting Rules

* Before changing behavior, check how upstream WeakAuras2 does it when possible.
* When a modern WeakAuras2 file differs from this repository, first assume the upstream version is important context.
* Keep file layout, function names, tables, option keys, and control flow close to upstream.
* Make the smallest 3.3.5a compatibility change that solves the problem.
* Prefer compatibility shims/wrappers over editing many call sites.
* Avoid custom abstractions unless they directly replace an unavailable Retail API or runtime feature.
* Do not modernize Lua syntax beyond what WoW 3.3.5a supports.
* Do not assume Retail, Classic Era, Cataclysm Classic, or Dragonflight APIs exist.
* If an upstream feature cannot be supported on 3.3.5a, preserve the surrounding structure and disable/degrade only the unsupported part.

The ideal patch looks like upstream WeakAuras2 with only the minimum necessary WotLK differences.

---

## 3. WotLK API Context

The `APIDocumentation` folder is the local source of truth for the 3.3.5a API surface.

* Use `APIDocumentation/Documentation/*.lua` to verify exact functions, events, argument lists, and return values.
* Use `APIDocumentation/Blizzard_APIDocumentation.lua` to understand how API docs are registered.
* If the API docs and upstream WeakAuras2 disagree, adapt upstream behavior to the documented 3.3.5a API with the smallest compatibility layer possible.

Be especially careful with:

* `C_*` namespaces.
* Combat log event payloads.
* Aura APIs such as `UnitAura`, `UnitBuff`, and `UnitDebuff`.
* Inspect/talent APIs.
* Item, spell, cooldown, and action bar APIs.
* Events that exist in Retail but not in WotLK.

---

## 4. Load Order

Always respect `.toc` file order. WoW addon files are loaded sequentially, and many files depend on globals/tables created earlier.

Before moving code, adding dependencies, or introducing a new file:

* Check the relevant `.toc`.
* Prefer editing an existing corresponding file over adding a new file.
* If a file must be added, update the `.toc` in the correct position.
* Do not assume modules can be imported like normal Lua packages.

---

## 5. Repository Layout

### Root

* `AGENTS.md`: agent rules for this port.
* `stylua.toml`: formatting rules.
* `CONTRIBUTING.md`: contribution scope and process.
* `.luacheckrc`: Luacheck configuration used by GitHub Actions lint workflows.
* `.luarc.json`: Lua Language Server/editor diagnostics configuration. This does not control CI.
* `LICENSE` and `NOTICE`: licensing, attribution, and official-repository notices. Keep these in source and release/package outputs unless the user explicitly requests a licensing review.

### Core Addons

* `WeakAuras`: core runtime addon.
* `WeakAurasOptions`: load-on-demand configuration UI, loaded by `/wa`.
* `WeakAurasTemplates`: template data and UI.
* `WeakAurasArchive`: archive support.
* `WeakAurasModelPaths`: model path data.
* `WeakAurasStopMotion`: stop motion textures and support.
* `APIDocumentation`: local 3.3.5a API documentation addon.

Important files:

* `WeakAuras/WeakAuras.toc` and `WeakAurasOptions/WeakAurasOptions.toc`: load order and addon metadata.
* `WeakAuras/Init.lua`, `WeakAuras/WeakAuras.lua`, `WeakAuras/DefaultOptions.lua`: initialization and core state.
* `WeakAuras/Types_Wrath.lua`, `WeakAuras/Types.lua`: type and option data. Load order matters.
* `WeakAuras/BuffTrigger2.lua`, `WeakAuras/GenericTrigger.lua`: trigger/event evaluation.
* `WeakAurasOptions/TriggerOptions.lua`, `WeakAurasOptions/BuffTrigger2.lua`, `WeakAurasOptions/GenericTrigger.lua`: trigger configuration UI.

---

## 6. Coding Standards

Follow the existing style and upstream WeakAuras conventions.

* Lua indentation is 2 spaces.
* Use Unix line endings.
* Keep Lua 5.1 compatibility.
* Avoid semicolons in new code.
* Preserve existing semicolons when editing code that already uses them; they are useful for comparing against upstream/developer code.
* Match surrounding style when editing older code.
* Avoid unnecessary churn and broad reformatting.
* Preserve line endings and whitespace locally. Do not normalize whole files just because a small edit is needed.
* Do not rewrite vendored libraries or generated/media data unless explicitly needed.

### Stylua

* `stylua.toml` sets `column_width = 180`.
* Use `stylua` for new Lua files and clearly isolated new code when practical.
* Do not run `stylua` over entire existing Lua files by default; many legacy/upstream-port files are intentionally not fully reformatted.
* When editing existing Lua files, keep formatting local to the changed lines and match surrounding style unless the user explicitly asks for a broader formatting pass.

### Localization

User-facing strings must be localized:

* Use `L["Some text"]`.
* Use double quoted strings inside localization keys.
* Keep the localization table named `L` in code so the scraper can find strings.
* Add or preserve locale entries consistently when changing UI text.

---

## 7. Diagnostics And Tooling

Luacheck/LuaRocks and the GitHub Actions lint workflow are the validation priority. Stylua is secondary and only for new files or isolated new code.

### Config Files

* `.luacheckrc` is used by Luacheck and GitHub Actions.
* `.luarc.json` is for the Lua Language Server/editor experience only.
* Do not assume `.luarc.json` affects Luacheck or CI.
* When adding a new accepted global, shim, or API surface, update `.luacheckrc` for CI and `.luarc.json` for editor diagnostics when both are relevant.
* Do not replace `.luacheckrc` with `.luarc.json`, or the other way around; they serve different tools.

### Local Dependencies

The lint workflow is the reference setup, but local validation should use the same tools when practical.

On Windows, `cmd`/PowerShell should be able to find:

* `lua`
* `luarocks`
* `luacheck`

If `lua` or `luarocks` is missing from `PATH`, ask the user before making persistent user/system `PATH` changes. Session-local `PATH` changes are okay when needed for validation.

If LuaRocks has installed `luacheck` but `cmd /c "where luacheck"` cannot find it, add the LuaRocks user binary directory to `PATH` for the current command session. For the maintainer's usual Windows setup:

```powershell
$env:PATH = "$env:APPDATA\luarocks\bin;$env:PATH"
```

Then verify:

```powershell
cmd /c "where lua && where luarocks && where luacheck"
cmd /c "luacheck . -q"
```

If `luacheck` is not installed but `lua` and `luarocks` are available:

```powershell
luarocks install luacheck
```

Do not install Lua or LuaRocks into this repository. They should live in their normal user/system locations. Use `.agents-cache/` only for disposable agent metadata, downloaded archives, or temporary cache files that are not part of the tool installation.

If local Lua/LuaRocks differs from the workflow environment and installing the CI-equivalent toolchain is not practical, say so and treat GitHub Actions as the authoritative lint result.

---

## 8. Validation

When possible:

* Run `luacheck . -q` after installing or exposing `luacheck` via LuaRocks and the local `PATH`.
* Treat the GitHub Actions lint workflow result as authoritative when local tooling differs.
* Run `stylua` only for new Lua files, or on a narrow changed range/block where it will not reformat unrelated legacy code.
* Use `git diff --check` to catch whitespace errors before finishing.
* Check `.toc` load order after adding or moving files.
* For API-sensitive changes, verify against `APIDocumentation`.

Many issues can only be fully verified inside the WoW 3.3.5a client. If a change cannot be tested locally outside the game, state that clearly.

---

## 9. Files To Treat Carefully

Avoid editing these unless the task requires it:

* `WeakAuras/Libs`
* `WeakAurasOptions/Libs`
* media assets: `.blp`, `.tga`, `.ogg`, `.mp3`, fonts, texture sources
* generated dumps such as `prompt.txt`
* large locale sweeps unless changing a user-facing string
* licensing and attribution files such as `LICENSE`, `NOTICE`, and embedded third-party license files

For upstream porting work, prefer changing the smallest compatibility boundary rather than repeatedly patching generated/vendor-like data.

---

## 10. Release, License, And Attribution

* Preserve the official-repository, license, and redistribution language in README/NOTICE/CONTRIBUTING unless the user asks to revise it.
* Keep `LICENSE` and `NOTICE` in release/package outputs.
* Do not remove compatibility code unless you understand why it exists.
* Do not remove attribution, copyright notices, third-party license files, or GPL notices.
* Do not add extra license restrictions that conflict with GPLv2.

---

## 11. Wiki Sync

When syncing the WotLK wiki from upstream WeakAuras2:

* Fetch the WotLK wiki first.
* Copy upstream WeakAuras2 wiki content over it.
* Preserve WotLK-specific pages such as `awesome_wotlk`, `Large-Address-Aware`, and `WeakAuras-Companion`.
* Rewrite internal GitHub links to `NoM0Re/WeakAuras-WotLK`.
* Do not publish upstream team-internal pages unless the user explicitly wants them.
* Run `git diff --check` in the wiki repository before finishing.

---

## 12. Agent Behavior

When working in this repository:

* Preserve upstream WeakAuras2 intent.
* Prefer porting and compatibility fixes over custom feature code.
* Keep diffs minimal and easy to compare with upstream.
* Search before changing shared systems.
* Explain any unavoidable divergence from upstream.
* Do not make broad refactors as part of a bug fix.
* Do not revert user changes unless explicitly asked.

The maintainer usually wants upstream behavior ported to 3.3.5a, not new behavior invented for this fork.

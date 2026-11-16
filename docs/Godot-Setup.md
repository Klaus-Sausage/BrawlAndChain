# Local Godot setup and launch verification

Verified 2026-11-16 (Australia/Melbourne), on the owner's Pop!_OS 24.04 LTS x86_64 PC at `/home/klaus/Documents/BrawlAndChain`.

The original local launch record below is preserved. Current managed-cloud foundation tools/results are appended separately; read [Progress](Progress.md) for current gameplay status.

## Pinned tools

- Standard **Godot 4.7.2 stable**, GDScript, not .NET. CLI reports `4.7.2.stable.official.ed1daf0bf`.
- Compatibility renderer: `gl_compatibility`; web uses WebGL 2.0. `.godot-version` records the release for people/tools; Godot does not enforce that file automatically.
- Editor: `/home/klaus/.local/share/godot/editors/4.7.2-stable/godot`.
- Command symlink: `/home/klaus/.local/bin/godot`.
- App-menu launcher: `/home/klaus/.local/share/applications/godot-4.7.2.desktop`, named **Godot 4.7.2 (Standard)**. It starts the editor with Compatibility rendering. Launcher file created; app-menu click itself was not tested.
- Matching standard web templates: `/home/klaus/.local/share/godot/export_templates/4.7.2.stable/`. Installed `version.txt` and all eight `web_*.zip` variants from the standard template archive. Other platform templates were not installed. Native verification runs through the editor binary, not a separately exported Linux executable.

## Download and installation record

No existing Godot executable or templates were found in the checked command path/template directory. Downloaded from the [official Linux download page](https://godotengine.org/download/linux/) using these release-specific URLs:

- [Standard Linux x86_64 editor](https://downloads.godotengine.org/?version=4.7.2&flavor=stable&slug=linux.x86_64.zip&platform=linux.64)
- [Standard export templates](https://downloads.godotengine.org/?version=4.7.2&flavor=stable&slug=export_templates.tpz&platform=templates)

Verified SHA-256 against the asset digests in the [official GitHub release metadata](https://api.github.com/repos/godotengine/godot-builds/releases/tags/4.7.2-stable):

| Archive | SHA-256 |
| --- | --- |
| `Godot_v4.7.2-stable_linux.x86_64.zip` | `cadd3204e728a35d3f13adb7fd0d7902636b79f6b95c40c265eb73b6c35329e4` |
| `Godot_v4.7.2-stable_export_templates.tpz` | `f298490b8d44d934be425a5a65a51bf15f422428b229a06a6e11d9ffea248011` |

Archives were downloaded to `/tmp/brawl-godot-install/`. Extracted the editor, installed it mode 755 at the path above, created the symlink and desktop launcher, and selectively extracted web templates, first checking `version.txt` equals `4.7.2.stable`. Temporary downloads are not a persistent backup; installed tools are outside Git. No administrator package installation was needed. A new PC/cloud machine needs its own Godot/template installation.

[Official web export documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html) establishes Compatibility/WebGL 2.0 and single-threaded web export support. The committed `Web` preset uses `variant/thread_support=false`, `variant/extensions_support=false`, and no custom templates. This simple single-threaded check uses ordinary HTTP on loopback and does not require cross-origin isolation headers. The project does not exercise audio.

## Repeat the checks

Update: the default scene is now the [private visual preview](Visual-Preview.md). To repeat the original launch test below, specify `res://scenes/launch_test.tscn` after `--path .`; F5 runs the new default scene.

Run from the repository root. Use the absolute executable path if `godot` is not on a new terminal's PATH.

```bash
cd /home/klaus/Documents/BrawlAndChain
godot --version
godot --headless --editor --path . --import
godot --editor --path . --rendering-method gl_compatibility
```

Open the project in the graphical editor and press F6 for the launch scene or F5 for the main scene. Or launch directly:

```bash
godot --path .
```

The screen shows the engine version, platform, renderer and an advancing timer. Click **Run launch check**; expect green `PASS — GDScript input callback received.`. An optional native automated render check captures `/tmp/brawl-launch-native.png` after two seconds and exits with the image-save result:

```bash
godot --path . -- --smoke-test
```

Generate and serve the release web export:

```bash
mkdir -p exports/web
godot --headless --path . --export-release Web exports/web/index.html
python3 tools/serve_web.py
```

Open `http://127.0.0.1:8060/`, then click **Run launch check**. Stop the server with Ctrl+C. Use HTTP rather than opening `index.html` as a `file://` URL. `tools/serve_web.py` binds only to `127.0.0.1`. It serves the generated `exports/web/` directory, not the repository. Generated exports and `.godot/` caches are ignored; scenes, scripts, `.uid`, and export presets are tracked. `docs/` and `tools/` have `.gdignore` files to avoid importing documentation/evidence as game resources.

## Actual results

| Check | Result and evidence |
| --- | --- |
| Version and download integrity | PASS: exact CLI version above; both SHA-256 digests matched official release metadata. |
| Headless editor import | PASS: project imported and GDScript parsed. [Import log](setup-evidence/editor-import.log). |
| Graphical standard editor | PASS: started with this project and Compatibility/OpenGL on the actual desktop, exited code 0 after `--quit-after 180`. [Editor log](setup-evidence/editor-launch.log). Native editor mouse/keyboard operation was not automated. |
| Native runtime/rendering | PASS: non-headless launch on NVIDIA GeForce RTX 3080, NVIDIA driver `595.104.02`, OpenGL 3.3.0. `LAUNCH_READY platform=Linux renderer=gl_compatibility`; captured a real 960×540 rendered frame after two seconds, image-save result 0, process exit 0. [Log](setup-evidence/native-launch.log), [frame](setup-evidence/native-launch.png). Native input click was not tested; screenshot shows ready state. |
| Release web export | PASS: matching 4.7.2 standard single-threaded template produced HTML/JS/PCK/WASM files, exit 0. Clean repeated export has no errors. [Export log](setup-evidence/web-export.log). |
| Browser runtime and actual input | PASS: Codex in-app Chromium browser loaded `http://127.0.0.1:8060/`, displayed `Platform: Web`, `gl_compatibility` and advancing timer. Actual pointer click produced green PASS and `LAUNCH_INPUT_PASS`. Console confirms WebGL 2.0, Emscripten 4.0.20 and single-threaded/no GDExtension build; returned no warnings/errors. [Console record](setup-evidence/browser-console.log), [screenshot](setup-evidence/web-launch.jpg). Browser executable version was not collected; Firefox/Brave were not tested. |

The native/editor logs contain `Failed to create wd.xic ... xim server may not have started yet`. Rendering and startup succeeded despite this X11 input-method warning. Text entry/IME is untested. The first sandboxed web export generated output but logged blocked socket/editor-settings writes; the repeated export with normal local permissions completed cleanly, and that clean log is the saved evidence.

This is a technical launch check, not playable version 0.0.1. No gameplay, assets, audio, MONEY SHOT, control scheme, physics model, performance target, networking or console export was implemented or validated. Next: owner agrees one focused first-playable question; separately test browser audio/music/slowdown timing before substantial content.

## Managed cloud foundation checks — 2026-11-16

This session verified the same pinned standard editor and matching web templates in the managed cloud checkout /workspace/BrawlAndChain. These paths are temporary environment tools, not repository backups:

- Editor: /tmp/brawl-godot-install/editor/Godot_v4.7.2-stable_linux.x86_64.
- Web templates: /tmp/brawl-godot-data/godot/export_templates/4.7.2.stable/.
- Writable editor configuration/cache: /tmp/brawl-config and /tmp/brawl-cache.

Set these explicitly in a new shell for this environment; other machines must install their own matching editor/templates:

```bash
export GODOT_BIN=/tmp/brawl-godot-install/editor/Godot_v4.7.2-stable_linux.x86_64
export XDG_DATA_HOME=/tmp/brawl-godot-data
export XDG_CONFIG_HOME=/tmp/brawl-config
export XDG_CACHE_HOME=/tmp/brawl-cache
python3 tools/check_project.py --godot "$GODOT_BIN"
python3 tools/export_web.py --godot "$GODOT_BIN"
```

The check wrapper rejects a different editor before import. All four current harnesses passed with fixed-60 execution: preview, authority (including varied/absent visuals), music scheduling/restoration and 22 exchange checks; final marker PROJECT_CHECKS_PASS harnesses=4. Fixed-60 execution is not a measured 60 FPS result. The export wrapper writes ignored exports/private-preview/ and records runtime-source/artifact hashes; --update-preview explicitly refreshes generated files in web-preview/ without changing the default scene.

Serve exports/private-preview/ over HTTP, then run the browser check in another terminal:

```bash
python3 -m http.server 8060 --bind 127.0.0.1 --directory exports/private-preview
```

```bash
python3 tools/check_browser_preview.py --url http://127.0.0.1:8060/
```

Browser automation requires Python Playwright and Chromium; BRAWL_BROWSER_BIN can select an installed executable. This session used Chromium 156.0.8078.79 headless with software WebGL 2. The three-scene check passed real input, exchange outcomes and nonzero Web Audio plus music-event/reset/return behavior. It does not verify listening quality, owner feel, gamepad, real focus-loss handling or FPS. A visible Chrome attempt lacked WebGL 2 and native rendering could not access the managed display; no new native-window gameplay result is claimed.

Saved evidence: [headless output](foundation-evidence/headless-checks.log), [browser results](foundation-evidence/browser-results.json), and frames linked from [Visual Preview](Visual-Preview.md). The original local results above remain historical evidence for that machine, not proof that a cloud/native path works.

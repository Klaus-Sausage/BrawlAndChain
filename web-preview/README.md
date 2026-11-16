# Private browser previews

Godot 4.7.2 single-threaded WebGL 2 Compatibility export. The accepted 0.0.1 preview remains the default; the guard, audio and combo experiments are separate entries in the same build. Keep this build private: temporary Mystara asset reuse rights remain unverified.

From the repository root:

```bash
python3 -m http.server 8060 --bind 127.0.0.1 --directory web-preview
```

Copy an address below into a current browser with WebAssembly and WebGL 2 support. The owner reports that clicking localhost links in chat fails while pasting the address works, so keep local preview addresses as copyable plain text:

| Entry | URL | Controls |
| --- | --- | --- |
| Accepted movement/strike reference | `http://127.0.0.1:8060/` | WASD, fresh-press J, F2 diagnostics |
| Reciprocal combat experiment | `http://127.0.0.1:8060/?lab=combat-exchange` | WASD, J, hold K to guard, R reset, F2 diagnostics |
| Light/Heavy combo experiment | `http://127.0.0.1:8060/?lab=combos` | J Light, L Heavy, K guard, R reset; try J–J–J and J–J–L |
| MONEY SHOT audio/time lab | `http://127.0.0.1:8060/?lab=money-shot` | Click Start audio, then Test finish; Reset interrupts; Preview returns to the reference |

Click the game canvas before keyboard input. In the exchange, approach the goblin; its amber tell precedes one melee attack. Guard faces forward and plants the hero. The owner said this first exchange “feels great” (D-073), accepting its feel gate. Hidden health, mechanics and tuning remain experimental; this does not lock the Barbarian kit/balance or approve later Light/Heavy and Thief comparison work. See [the exchange brief](../docs/Combat-Experiment.md).

The owner accepted the lab's steady rhythm and smooth resolution (D-074), without selecting final music or completing boss integration. Its UI reports scheduling lateness rather than measured audible latency. The separate [combo experiment](../docs/Combo-Experiment.md) follows the selected knockback Heavy finish (D-075); its tuning and feel need review. These previews do not establish controller support or the full slice's 60 FPS performance target. See [verification](../docs/Progress.md).

## Update an existing playtest checkout

The earlier worktree instructions create a detached playtest checkout. In a second terminal, with the server still running, update the dedicated folder using:

```bash
git -C /home/klaus/Documents/BrawlAndChain-playtest fetch origin
git -C /home/klaus/Documents/BrawlAndChain-playtest switch --detach origin/feat/private-slice-foundation
```

Reload the browser after the update. These commands do not force-discard local edits; they update only the dedicated playtest checkout.

Opening HTML directly with `file://` is unsupported. GitHub stores this private build but does not host a playable page. Stop the local server with Ctrl+C.

## Rebuild from source

Install the pinned editor and matching Web templates as described in [Godot setup](../docs/Godot-Setup.md). Set `GODOT_BIN` if `godot` points to another version.

```bash
python3 tools/check_project.py
python3 tools/export_web.py --update-preview
```

The tools reject a mismatched editor. Export without `--update-preview` writes only `exports/private-preview/`. `source-manifest.json` records runtime input and exported artifact hashes, the source commit, dirty status, and engine version. The source commit can precede the later commit containing these generated files; the input hashes identify the exact runtime content.

For repeatable browser checks, install Python Playwright and provide Chromium on PATH (or set `BRAWL_BROWSER_BIN`), serve the export, and run:

```bash
python3 tools/check_browser_preview.py --url http://127.0.0.1:8060/
```

Results and screenshots are written to ignored `exports/browser-evidence/`.

# Development Progress and Build Log

## Armed Fighter candidate — 2026-11-16 (current)

**EXPERIMENTAL / PLAYTEST REQUIRED:** Extracted complete sword-and-shield Fighter poses from the owner's audited `ddsomur1` USA 960209 ROM with MAME 0.264. The verified secret viewer uses the game's own equipment assembly; there is no invented weapon overlay. Four idle poses, thirteen walk steps (entry plus twelve-step loop), and ten sword-strike steps are in `assets/temporary_mystara_rom`. Timing comes from emulated frame records at 59.637405 Hz. The walk entry is not repeated on subsequent loops. The shared origin preserves source body movement.

Separate playable scene: `scenes/fighter_candidate.tscn`. **Ax Battler remains the default.** Existing movement, range/lane checks, goblin reaction and minimum strike delay remain unchanged. The candidate uses per-step durations and resolves once at attack step 5 / atlas frame 22. Original strike lasts approximately 0.1845 seconds; its speed and visible reach versus the existing hit range need owner feel review.

Native Godot 4.7.2 Compatibility ran on the RTX 3080 and recorded 461 frames at 60 fps. Synthetic-input checks passed: all walk poses then idle, both directions, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, next swing, contact frame, and arena bounds. The first harness observation included a pre-movement idle frame; corrected the observation window/filter and reran successfully. The recording is `docs/visual-evidence/mystara-rom/native-candidate.mp4`; results are in `native-check.log`. Actual rendered walk sequence samples were inspected for origin stability and transparency. This is not a physical-keyboard or subjective smoothness approval.

The separate release web export launched in the browser using WebGL 2 Compatibility, single-threaded, 480×270 canvas at a 960×540 viewport. Browser keyboard checks produced close hit, distant miss, facing-away miss and wrong-lane miss; rendered framing and transparent sword/shield match native. No runtime errors appeared in the inspected browser log. Full frame-by-frame browser cadence/contact and rapidly repeated key behavior have not been independently recorded; native automated checks cover the contact/lock logic. Browser preview: http://127.0.0.1:8061/ while its local server runs. Export output stays ignored under `exports/fighter_candidate`.

The owner selected browser inspection during iteration, superseding the earlier local-only approval gate. Missing ROM-support files and the claimed inability to capture native graphics are resolved: MAME headless snapshots work, and approved desktop access enables native Godot capture. Earlier investigation entries below are historical. Confirmed emulator output directories were moved out of the project to `/tmp/bac-mystara-fighter-feasibility/runtime`; ROMs, keys, emulator, dumps and intermediate captures remain outside the repository.

**Next:** owner reviews armed appearance, walk cadence, scale and sword strike in the candidate. Iterate before activation; only after approval switch default, recheck native/browser, commit/push and verify remote. No candidate approval, commit or push is claimed. Private temporary art permission remains unverified.


Updated 2026-11-16 (Australia/Melbourne).

## Current state — private 0.0.1 Ax Battler review build

2026-11-16: Implemented the owner-approved Ax Battler art swap on the private 0.0.1 scene. Preserved the exact 496×544 Golden Axe II sheet and its contributor/source metadata; created a separate transparent 8-frame atlas with shared y=80 feet (idle, three distinct walk poses, four sword-attack poses). Existing Mystara originals and derivatives were not modified. After owner feedback that the walk was cycling idle, the duplicate pose was removed from the walk range; idle is now frame 0, walk frames 1–3 at 8 fps, attack frames 4–7 at 16 fps, with contact on attack frame 2 / atlas frame 6. Movement, hit checks, goblin reactions, camera, arena and composition settings were unchanged. Temporary Mystara and Golden Axe II reuse permission remain unverified; keep the private build private. No combos, enemy animation/AI/attacks, health UI, damage numbers, abilities, audio or networking.

PASS for technical checks, but the walk has not passed feel review: Godot 4.7.2 imported the 768×96 atlas; a non-headless NVIDIA RTX 3080 Compatibility run rendered/captured 480×270; a native sequence capture showed walk frames `[1, 2, 3]`. Synthetic-input checks showed the cycle never enters idle frame 0 while moving, returns to idle when stopped, and still/moving hits resolve on atlas frame 6; repeat lock, goblin reaction, facing-away miss and wrong-lane miss also passed. The synthetic harness did not verify native OS keyboard delivery. Owner reports the revised walk still feels “all janky.” Native renderer evidence: [Visual Preview](Visual-Preview.md). The only native warning was the known X11 input-method initialization warning. **Do not export web or commit/push until a revised native walk passes owner review.** This is not the public 0.1.0 slice.

## Mystara Fighter extraction feasibility — 2026-11-16

**Latest result:** The owner added `ddsomu.key` and `qsound_hle.zip` to Downloads. The key and the archive's `dl-1425.bin` match the required sizes, CRC32s and SHA-1s. A temporary ROM path under `/tmp/bac-mystara-fighter-feasibility/rompath` uses links to the supplied files; MAME 0.264 reports `romset ddsomur1 [ddsom] is good`. A subsequent eight-second run with `-video none -sound none` and a Lua `screen:snapshot()` callback produced a genuine 384×224 game boot screenshot, inspected visually at `/tmp/bac-mystara-fighter-feasibility/headless-probe.png`. This disproves the earlier claim that a missing graphical desktop prevents capture. Script: `/tmp/bac-mystara-fighter-feasibility/capture_probe.lua`. Next: establish the secret-viewer patch for this exact USA revision, drive its inputs through Lua, and capture complete weapon-bearing Fighter poses. No complete animation has been extracted yet. The earlier missing-file limitation below is historical and resolved.

Owner supplied `/home/klaus/Downloads/ddsomur1/` after the installed Steam archive's merged graphics ROM proved difficult to decode directly. All eight split CPS2 graphics chips match the [MAME driver CRCs](https://github.com/mamedev/mame/blob/master/src/mame/capcom/cps2.cpp#L3258-L3286). Using the CPS2 GFX layout, the chips now decode into clean 16×16 graphics tiles; the tile galleries and working files are only in `/tmp/bac-mystara-fighter-feasibility`. Comparing against the preserved Fighter sheet, 11 of 13 occupied idle-frame tile cells and many walk/attack cells match exactly, confirming the ROM contains the same art. This is not yet a complete extracted animation atlas: game-specific frame assembly and the character palette are not recovered. The separate `tileattribs` binary remains uninterpreted.

A user-level MAME 0.264 package was fetched from the configured Pop!_OS repository and extracted under `/tmp` (no system install). The [D&D debug-menu analysis](https://sudden-desu.net/entry/secret-menu-dungeons-dragons-shadow-over-mystara/) describes a `Beta beta mode` sprite viewer and a `Char tbl mode` animation/frame viewer, which could assemble the full frames. MAME's ROM audit and launch attempt stop because the supplied folder lacks `ddsomu.key` (20 bytes, CRC `09ae0f7c`) and the `qsound_hle` device ROM `dl-1425.bin` (24,576 bytes). The owner confirmed those files are not available. Neither file was found elsewhere in Downloads or the installed Steam game. The original ROMs and decoded art remain outside the repository.

As a fallback, added optional `scenes/hero_art_comparison.tscn` / `scripts/hero_art_comparison.gd`, which display the preserved Fighter atlas alongside Ax Battler over the existing private preview background. Keys 1/2/3 select idle/walk/attack. This is only a review scene: it does not use newly extracted MAME animation frames, does not change the default scene or gameplay, and does not activate Mystara art. Godot 4.7.2 Compatibility headless launch passed and logged a 480×270 viewport. A screenshot/native-window review could not be completed in this managed shell because neither X11 nor Wayland is available; a capture attempt stalled before producing an image. Ax Battler remains the active hero and the reported walk-cycle concern remains open. No web export, commit, or push was performed. Next: open the optional comparison scene in the owner's local Godot window and decide whether the existing Fighter atlas merits further work; if exact original animation frames are still needed, a complete MAME set including its key and QSound device ROM is required.

## Previous state — private visual study

2026-11-16: Implemented the owner-approved static Mystara visual study as the default scene. Preserved original source sheets and credits, created transparent crops, placed Fighter/Barbarian stand-in and goblin facing each other on a shared foot baseline, and composed the Trintan village/floor. Replaceable visual child nodes, fixed camera, nearest filtering, 480×270 internal canvas with 960×540 desktop window and integer scaling. Original launch test remains available with its own content-scale restoration.

PASS: import, non-headless native frame capture, release web export and visual browser inspection; preserved launch-check scene still captures 960×540 successfully. Native/browser show matching composition, clean transparency and pixel scaling. Browser console returned no warnings/errors. Native retains the known X11 IME warning. See [Visual Preview](Visual-Preview.md) for source provenance, screenshots, commands and limitations. No gameplay or public release created. Owner reviewed the preview and approved its current character scale, camera distance and composition on 2026-11-16. Canvas/display dimensions remain provisional. Next: agree a first-combat objective.

## Previous state — local Godot launch setup

2026-11-16: Installed and verified standard Godot **4.7.2.stable.official.ed1daf0bf** with GDScript and matching **4.7.2.stable** web export templates on the owner's Pop!_OS 24.04 x86_64 PC. Compatibility rendering is configured. A minimal technical project now exists: one scene, typed GDScript, version/renderer/platform text, timer and launch-check button. No gameplay exists and this is not playable 0.0.1.

PASS: official archive SHA-256 checks; editor import; graphical editor startup; non-headless native 960×540 frame capture on RTX 3080; clean release web export; visible Chromium/WebGL 2.0 browser startup and actual click yielding `LAUNCH_INPUT_PASS`. Native/editor X11 IME warning remains; text entry/IME, native input click, other browsers, performance and audio timing are untested. The initial sandboxed export logged permission errors; the repeated export with normal permissions passed cleanly.

Exact paths, downloads, installation record, repeatable commands, logs and screenshots: [Godot setup](Godot-Setup.md). Generated output/caches are ignored; source, script UID and shareable preset are tracked. Cloud Godot installation is not verified by this local work. Next: agree one focused first-playable question; retain early browser music/slowdown experiment. No gameplay implementation was performed.

## Historical state — Godot documentation update

Owner approved implementing the Unity → Godot documentation plan. **Current engine/language: Godot 4 + GDScript.** Typed GDScript is the recommended initial convention; Compatibility rendering is the planned browser baseline. Exact release, Godot installations, matching export templates, physics configuration, and browser exports remain unverified. No game project or code was ported or created, and no gameplay test was run.

Updated maintained design, decision register, assistant instructions, README/handoff, open questions, and ignore rules. Preserved historical engine rationale and source archives. Adaptive MONEY SHOT audio/music remains required in the slice; an early Godot browser timing/latency experiment is now explicit. Gameplay scope and future multiplayer-authority separation are unchanged.

## Verified cloud GitHub access — 2026-11-16

Repository: `https://github.com/Klaus-Sausage/BrawlAndChain`. Read access verified by `ls-remote` and a fresh temporary clone at `10361e8568bbe705d9edb85c32ea81dc30818e59`. Write access verified by pushing `codex/write-access-check-683329c69bee` at that existing commit, reading back the same commit, and deleting the branch with an expected-commit lease. Confirmed temporary branch absent and default branch unchanged after the test. This was a real push/delete check, not only a dry run.

The published `Default Cloud` setup-clone record below remains valid historical evidence; launching a fresh task from that published configuration is still untested. This older conversation's `/workspace/BrawlAndChain` folder is an earlier documentation archive, not a Git checkout. The current update uses a separate Git worktree at `/workspace/BrawlAndChain-Godot`, branched from verified repository commit `10361e8`, to preserve those existing files. Automatic cloud/PC synchronization is not configured.

## Private GitHub backup setup — 2026-11-16 (setup record)

Owner request: read project guidance and set up private GitHub backup. Working folder is `/home/klaus/Documents/BrawlAndChain`. Inspected the folder before initialization: no working Git repository or history existed. GitHub CLI network-authenticated as `Klaus-Sausage`; target repository did not exist. Initialized `main` and added ignore rules for local assistant/credential directories and generated Unity files, preserving source documents and `.meta` files.

Private remote created: `https://github.com/Klaus-Sausage/BrawlAndChain`; `origin/main` tracks local `main`. Initial commit `6c4b358` pushed successfully. GitHub API confirmed `isPrivate: true`; a fresh HTTPS clone into `/tmp/brawl-and-chain-backup-check-20261116` matched all 12 tracked files byte-for-byte, including the original PDF. `git diff --cached --check` passed before the initial commit. Repository-local commit identity uses the account’s GitHub noreply address.

Next action: commit/push future changes and pull before moving between separate checkouts. Automatic sync is not configured. No gameplay work performed.

## Cloud repository connection — 2026-11-16 (before access verification)

Owner completed GitHub connector authorization and reported restricting it to BrawlAndChain. In Codex Cloud setup, verified connected identity `Klaus-Sausage` and selected only `Klaus-Sausage/BrawlAndChain` for the existing private `Default Cloud` environment. Saved the draft; the setup workspace reported a successful clone of `main` into `/workspace/BrawlAndChain`, clean and matching `origin/main`. Published the environment; the UI confirmed publication and loaded a new draft based on the published version. Existing internet and privacy settings were unchanged. No new gameplay task was started. A separate task from the published configuration has not yet been tested; cloud write/push behavior is not verified by the clone check. Local/cloud folders remain separate; pull before work and commit/push changes before switching.

## Historical state — 2026-11-15


Documentation package rebuilt at `/workspace/BrawlAndChain` from the owner's 140-page Historical Design Chat PDF and later Codex confirmations. All extracted pages and the original PDF are preserved with maintained GDD, decisions, open questions, assistant instructions, and fresh-chat handoff.

Earlier cloud documentation files became unavailable. Cause unknown; do not claim they were deliberately deleted or that cloud persistence is configured. The earlier incomplete handoff/GDD originals are absent and are not fabricated as archived files in this bundle.

**No Unity project, gameplay code, game art/audio asset library, or playable build has been created here.** No gameplay playtest has occurred. Unity editor/version, renderer, packages, SDKs, hosting, Git remote, backup, and PC checkout have not been configured or verified.

Owner's PC output verifies Pop!_OS 24.04 LTS, x86_64, Git 2.43.0. Node/npm and Unity installation status remain unknown. The owner can select the cloud environment in the installed app; exact app/project features should be checked before giving UI instructions.

## Original documentation recovery — 2026-11-15

- Read actual historical design exchanges and later revisions, rather than relying on the contradictory opening summary or incomplete closing export.
- Recovered Reacharound, Circle Jerk, MUM RULES, complete-set rules, UI/presentation/audio direction, boss sequence, and explicit slice scope.
- Incorporated later direct confirmations: hero switching/AI handover and PC/PS5/Switch 2 intentions.
- Recorded true open/playtest items; preserved distinct full-game, slice, and prototype scope.
- Created a portable download package with source evidence and instructions for the next chat.

## Original package verification — 2026-11-15

PASS: All 10 Markdown files are nonempty and all local Markdown links resolve. The transcript preserves all 140 nonempty extracted pages in order; the archived PDF matches the uploaded original byte-for-byte. Key recovered decisions are present in the maintained GDD. The final ZIP is checked against every package file after creation. No Unity or gameplay validation applies to this documentation-only task.

## Godot documentation verification — 2026-11-16

PASS: Reviewed the expected eight-file diff; all 10 Markdown files are nonempty and all local links resolve. All four archived source files match base commit `10361e8` byte-for-byte. Checked 12 generated/secret path scenarios are ignored and 14 source/metadata/preset path scenarios remain trackable. Gameplay sections and public-slice requirements match the base, except the intended browser-engine wording. `git diff --check` passed. Independent read-only review found no correctness or scope issues. No Godot installation/export or gameplay validation applies to this documentation-only change. The previously downloaded ZIP is a historical snapshot; use GitHub for current documentation after this change is committed and pushed.

## Next tasks

1. Use the latest GitHub checkout in the next session; read `AGENTS.md`, the handoff, and maintained docs, and inspect its actual path/branch/status. Verify a fresh task from the published cloud configuration separately if using it.
2. Local Godot 4.7.2 standard editor and matching web templates are installed and launch-verified; follow Godot-Setup.md. Install/verify separately in any cloud environment used for engine work.
3. Have the owner play the private 0.0.1 build and record actual feel feedback; tune only the approved movement/strike experiment from that feedback. No detailed numbered roadmap is approved.
4. Export/test the browser version early; include an audio/music/slowdown timing experiment for MONEY SHOT before substantial content work. Keep target browser/hardware and 60 FPS measurements explicit.
5. Pull before work and commit/push before switching between cloud and `/home/klaus/Documents/BrawlAndChain`. GitHub backup is configured; automatic sync is not.

## Build log

| Version | Date | Primary goal | Changes | Owner test notes | Other tester notes | Verification / bugs | Next step |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0.0.1 private experiment | 2026-11-16 | Basic movement, one-hit feel and visible hero animation; now comparing a Mystara Fighter candidate | Provisional WASD movement, idle/walk animation, one-shot J sword attack, contact-frame hit/miss resolution, goblin flash/nudge; active hero is Ax Battler | Ax walk review remains open; comparison scene is available but not visually reviewed | No external tester | Ax Battler passes native Compatibility render and synthetic-input runtime checks. Supplied MAME graphics chips pass CRC checks and decode to tiles, but MAME cannot start without the key and QSound HLE file. Optional comparison scene passes a 480×270 headless Godot run; no native screenshot was possible in this managed shell. See Visual-Preview.md and feasibility note above. | Open the comparison scene locally; decide whether the preserved Fighter atlas is a useful candidate |

Use sequential 0.0.x playable prototypes; public slice is 0.1.0. Every build gets one primary proof, actual test results, known bugs, and next step. Iterate on poor feel rather than advancing an assumed roadmap. No specific feature-to-build numbering is approved.

## Session handoff

Do not make the owner recount missing rules again: the PDF source now includes them. Read relevant pages when in doubt. Update this file and the design records after substantive work; no background Markdown autosave is configured. Never claim Git commits, remote backups, console readiness, or tested gameplay without evidence.

## Approval and default activation — 2026-11-16

Owner reviewed the armed Fighter candidate and replied “perfect.” The candidate is now the default scene (`scenes/fighter_candidate.tscn`); Ax Battler source and earlier preview assets remain preserved. Re-ran the default scene locally with Godot 4.7.2 Compatibility on RTX 3080: `COMBAT_CAPTURE result=0 size=(480, 270)`, and launched the refreshed single-threaded WebGL 2 Compatibility export in the browser. Browser returns to the same village/arena framing with the original armed Fighter and goblin; no browser warnings/errors were reported. Project export preset now writes the ignored `exports/fighter_candidate/` path. Export/editor emitted sandbox socket/editor-settings diagnostics on the headless export process, but the export completed and loaded in browser; native run had only the known X11 input-method warning. Native automated checks remain green as listed above. Build backup pending the final repository scan and push verification.

## Browser build checked into private Git — 2026-11-16

At the owner's request, added the Godot Web export to web-preview/ so the private build can be cloned and served on other computers. It includes the generated HTML, JavaScript, WebAssembly, PCK, icon and audio worklets (about 39 MB before Git compression). web-preview/README.md gives the local HTTP server steps and same-network testing option. This is a downloadable/cloneable build; the commit does not itself host a public playable URL. The repository remains private.


## Attack input adjustment — 2026-11-16

Changed J from per-frame held polling to fresh key-down input, ignoring OS/browser echo events. A held attack button can no longer trigger additional swings; distinct fast taps remain subject to the current swing lock and 0.32-second minimum delay. Per owner feel feedback, animation speed remains unchanged. Runtime recheck and refreshed browser export are pending. See D-066.

## Hold-versus-tap verification — 2026-11-16

PASS: Native Godot synthetic input held J across 70 frames and injected repeated echo key-down events; only one attack was accepted. After release, a distinct press after the attack lock and delay started exactly one more swing. All candidate checks passed (failures=[]), including original movement/facing/range/contact checks. Browser WebGL2 Compatibility: held J for 1.8 seconds produced one STRIKE_RESULT; a separate tap after release produced the second result. Renderer initialized at 480×270 with no browser warning/error logs. The browser check used the real input path; both strikes were misses from the starting distance, as expected. This verifies repeat behavior, not hit feel.

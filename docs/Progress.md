# Development Progress and Build Log

Updated 2026-11-16 (Australia/Melbourne).

## Current state — private visual study

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
3. Agree one focused 0.0.1 playable question and acceptance criteria, then implement only the required systems. No numbered feature roadmap or gameplay implementation is authorized by this documentation update.
4. Export/test the browser version early; include an audio/music/slowdown timing experiment for MONEY SHOT before substantial content work. Keep target browser/hardware and 60 FPS measurements explicit.
5. Pull before work and commit/push before switching between cloud and `/home/klaus/Documents/BrawlAndChain`. GitHub backup is configured; automatic sync is not.

## Build log template — no playable builds yet

| Version | Date | Primary goal | Changes | Owner test notes | Other tester notes | Verification / bugs | Next step |
| --- | --- | --- | --- | --- | --- | --- | --- |
| — | — | No playable build created | — | Not tested | Not tested | Technical launch verified; no gameplay | Agree first playable goal |

Use sequential 0.0.x playable prototypes; public slice is 0.1.0. Every build gets one primary proof, actual test results, known bugs, and next step. Iterate on poor feel rather than advancing an assumed roadmap. No specific feature-to-build numbering is approved.

## Session handoff

Do not make the owner recount missing rules again: the PDF source now includes them. Read relevant pages when in doubt. Update this file and the design records after substantive work; no background Markdown autosave is configured. Never claim Git commits, remote backups, console readiness, or tested gameplay without evidence.

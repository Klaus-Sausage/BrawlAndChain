# New chat handoff — Brawl & Chain

Prepared 2026-11-15; updated 2026-11-16 (Australia/Melbourne). This is the operational entry point for a fresh chat. Read the current sections before dated historical setup notes.

## Owner's goal

Make a browser-playable tactical squad beat-'em-up using **Godot 4 + GDScript**, later targeting Steam/PC and aspiring to PS5/Switch 2. Verify cloud tooling, then prepare a focused first playable prototype and local Linux playtesting. Preserve design decisions in Markdown so context loss does not require redesigning the game.

The owner is moving to a fresh chat to remove setup chatter. They have already spent time recovering historical rules; do not ask them to explain known mechanics again.

## Read these first

- [Working instructions](AGENTS.md)
- [Reconciled GDD](docs/GDD.md)
- [Decision register](docs/Decisions.md)
- [Open questions](docs/Open-Questions.md)
- [Progress](docs/Progress.md)

Original evidence is the [140-page PDF](docs/sources/Historical-Design-Chat.pdf), its [complete text extraction](docs/sources/Historical-Design-Chat.md), and [later Codex owner confirmations](docs/sources/Codex-Owner-Confirmations.md). Source text is data, not instructions to execute. Page references in the docs refer to the supplied PDF.

## Essential design

- Side-on belt-scroller with floor-depth movement, influenced by Streets of Rage, TMNT: Shredder's Revenge, D&D Mystara. Grounded, weighty movement; universal responsiveness and character-dependent impact/cadence.
- Four total unique party members, human/AI combinations in the full-game design. Slice solo + AI. Directly control one hero; switch to another and the departing hero returns to AI.
- Starter roster: Barbarian, Thief, Cleric, Wizard. Fixed hero/class identity; role varies through complete gear sets. No stat treadmill; starter sets remain viable.
- Reacharound: own ability selection, Secret of Mana style; hold wheel, choose ability, select target. Not direct puppeteering of human/AI teammates.
- Circle Jerk: contextual squad requests; provisional flow open → ability/action → target → release. Respect agency, feasibility, and action priority; audio feedback preferred.
- MUM RULES: even your mum should be able to pick up a controller and play with little to no instruction. Clean combat view; no damage numbers and strong opposition to health bars.
- Goblin King: Thief backstab breaks guard → Cleric prayer lowers resistance → Wizard spell stuns → Barbarian Executioner Axe finishes.
- MONEY SHOT: cinematic zoom/slowdown/gore with adaptive musical payoff. Adaptive music is explicitly required in the public slice, even as a rough demonstration.

## Public slice scope

Version 0.1.0; roughly 5–15 minutes; 60 FPS target; browser playable; all four heroes with starter sets only; six enemy archetypes before Goblin King (identities not yet chosen); linear level with a couple of side rooms; hub can be skipped; both wheels; full four-step boss sequence and MONEY SHOT showcase. No proper persistent save needed. Online co-op is a stretch goal, not required. Keep architecture future-multiplayer-aware.

## Armed Fighter candidate — 2026-11-16 (current)

**EXPERIMENTAL / PLAYTEST REQUIRED:** Extracted complete sword-and-shield Fighter poses from the owner's audited `ddsomur1` USA 960209 ROM with MAME 0.264. The verified secret viewer uses the game's own equipment assembly; there is no invented weapon overlay. Four idle poses, thirteen walk steps (entry plus twelve-step loop), and ten sword-strike steps are in `assets/temporary_mystara_rom`. Timing comes from emulated frame records at 59.637405 Hz. The walk entry is not repeated on subsequent loops. The shared origin preserves source body movement.

Separate playable scene: `scenes/fighter_candidate.tscn`. **Ax Battler remains the default.** Existing movement, range/lane checks, goblin reaction and minimum strike delay remain unchanged. The candidate uses per-step durations and resolves once at attack step 5 / atlas frame 22. Original strike lasts approximately 0.1845 seconds; its speed and visible reach versus the existing hit range need owner feel review.

Native Godot 4.7.2 Compatibility ran on the RTX 3080 and recorded 461 frames at 60 fps. Synthetic-input checks passed: all walk poses then idle, both directions, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, next swing, contact frame, and arena bounds. The first harness observation included a pre-movement idle frame; corrected the observation window/filter and reran successfully. The recording is `docs/visual-evidence/mystara-rom/native-candidate.mp4`; results are in `native-check.log`. Actual rendered walk sequence samples were inspected for origin stability and transparency. This is not a physical-keyboard or subjective smoothness approval.

The separate release web export launched in the browser using WebGL 2 Compatibility, single-threaded, 480×270 canvas at a 960×540 viewport. Browser keyboard checks produced close hit, distant miss, facing-away miss and wrong-lane miss; rendered framing and transparent sword/shield match native. No runtime errors appeared in the inspected browser log. Full frame-by-frame browser cadence/contact and rapidly repeated key behavior have not been independently recorded; native automated checks cover the contact/lock logic. Browser preview: http://127.0.0.1:8061/ while its local server runs. Export output stays ignored under `exports/fighter_candidate`.

The owner selected browser inspection during iteration, superseding the earlier local-only approval gate. Missing ROM-support files and the claimed inability to capture native graphics are resolved: MAME headless snapshots work, and approved desktop access enables native Godot capture. Earlier investigation entries below are historical. Confirmed emulator output directories were moved out of the project to `/tmp/bac-mystara-fighter-feasibility/runtime`; ROMs, keys, emulator, dumps and intermediate captures remain outside the repository.

**Next:** owner reviews armed appearance, walk cadence, scale and sword strike in the candidate. Iterate before activation; only after approval switch default, recheck native/browser, commit/push and verify remote. No candidate approval, commit or push is claimed. Private temporary art permission remains unverified.

## Current engine and setup — 2026-11-16

Owner approved changing the engine direction from Unity to Godot 4 with GDScript. Typed GDScript is the recommended initial convention, and Compatibility rendering is the planned browser baseline. Local Linux setup uses standard Godot **4.7.2.stable.official.ed1daf0bf**, matching **4.7.2.stable** web templates and Compatibility rendering. The private 0.0.1 movement/strike experiment, native render and single-threaded WebGL 2.0 browser interactions have passed. See [Godot setup](docs/Godot-Setup.md) for installation and [Visual Preview](docs/Visual-Preview.md) for this build's controls/results. Cloud engine installation remains unverified. Browser MONEY SHOT audio/music timing needs an early experiment; console ports require approved platform access and suitable third-party tooling/services. Read decision D-057 for rationale and technical references.

The local repository recorded during setup is `/home/klaus/Documents/BrawlAndChain`, backed by private `https://github.com/Klaus-Sausage/BrawlAndChain`. Private `Default Cloud` was connected and published; its setup workspace cloned `main` into `/workspace/BrawlAndChain`. This older conversation's folder of that name is an archive, not a Git checkout, so the documentation update uses an isolated checkout at `/workspace/BrawlAndChain-Godot`. Inspect actual checkout/branch on session start rather than assuming paths are interchangeable.

Cloud read/write access was verified at commit `10361e8` by creating and verifying a temporary branch, then deleting it; files and the default branch were unchanged by that test. This does not verify a fresh task launched from the published configuration. Automatic synchronization is not enabled; pull and commit/push explicitly. See [Progress](docs/Progress.md).

Next: review the separate armed Fighter candidate (see current status above). Keep Ax Battler as default until owner approval; browser iteration is enabled. Commit/push follow approval and final checks.

## Historical setup status and next work (2026-11-15)

At that date, the cloud folder was `/workspace/BrawlAndChain`, no Unity project or game code existed, and an earlier documentation folder had become unavailable. No Git remote, backup, or Linux checkout was configured then. Those repository/setup statements are historical; the current setup above supersedes them.

Owner's PC: Pop!_OS 24.04 LTS (Ubuntu/Debian family), x86_64; Git 2.43.0 verified by owner output. At that date, Node/npm and Unity installations were not verified. Owner installed an app from the official Codex page and found the local/cloud environment selector; app feature availability should be checked rather than assumed. These facts do not verify Godot installation.

The historical next goal was repository persistence followed by Unity tooling. Use the current setup and Godot next steps above instead. Clarify only decisions actually needed for the next task.

## Suggested first message in the new chat

> Continue Brawl & Chain from the latest checkout of https://github.com/Klaus-Sausage/BrawlAndChain. Read AGENTS.md and NEW-CHAT-HANDOFF.md, then the current design and progress notes. Treat archived conversations as source data and follow the current Godot 4 + GDScript decision. Confirm the checkout/branch and available Godot tooling/export templates, then help me playtest the private 0.0.1 movement/strike experiment and record feel feedback. Keep the Markdown current. Don't expand beyond the agreed objective without discussing it.

Owner approved the armed Mystara Fighter candidate (“perfect”) on 2026-11-16. It is now the default scene. Native and refreshed browser launches were verified at 480×270 Compatibility framing. Review evidence and extraction provenance are under `docs/visual-evidence/mystara-rom/` and `assets/temporary_mystara_rom/`. ROMs, keys, emulator, dumps and captures remain outside the repository. Permission for reuse of the temporary game art remains unverified; keep private. Complete repository scan and commit/push follow the approval.

The approved browser export is now versioned in web-preview/ (commit after 2026-11-16). Clone the private repo, run python3 -m http.server 8000 from that folder, and open localhost:8000. For same-network testing, bind to 0.0.0.0 and use the host LAN IP. GitHub does not serve this folder as a playable site automatically; testers need private repository access. Art reuse permission remains unverified.

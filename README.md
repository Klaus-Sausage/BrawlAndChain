# Brawl & Chain

**Public PC test:** the owner requested GitHub Pages (D-076). The exported build is prepared on `gh-pages`; repository visibility and Pages settings are blocked by the integration's administration permissions. See [GitHub Pages setup/status](docs/GitHub-Pages.md). A pushed branch is not yet a live play link.

## Start here

- **Fresh chat:** read [NEW-CHAT-HANDOFF.md](NEW-CHAT-HANDOFF.md).
- **Design baseline:** [GDD](docs/GDD.md), [decisions](docs/Decisions.md), [open questions](docs/Open-Questions.md), and [progress](docs/Progress.md).
- **Roadmap:** [14-step private full-slice delivery plan](docs/Roadmap.md). Prove the established slice gameplay with rough readable stand-ins; public assets and release follow separately.
- **Original evidence:** [source index](docs/sources/README.md), [historical transcript](docs/sources/Historical-Design-Chat.md), and [original PDF](docs/sources/Historical-Design-Chat.pdf).
- **Working rules:** [AGENTS.md](AGENTS.md).

Brawl & Chain is a co-op tactical beat-'em-up. The GDD records the recovered design and distinguishes established rules from open questions and small playable experiments.

## Engine and backup

The project uses Godot 4 with GDScript and Compatibility rendering. Local Godot 4.7.2 and matching web templates are installed; see [Godot Setup](docs/Godot-Setup.md). The repository is private at https://github.com/Klaus-Sausage/BrawlAndChain. Cloud and PC checkouts are separate; pull before switching and push completed changes.

## Current private build

The default scene, scenes/visual_preview.tscn, is the approved 0.0.1 Mystara Fighter movement-and-strike preview. It uses a ROM-derived sword-and-shield Fighter, Mystara goblin and Trintan village. Press F5 to run; use WASD to move, J for a single press-triggered strike, and F2 to show/hide the strike range/lane diagnostics. Current range is 95 px and lane tolerance is 18 px. The canvas is 480×270 with a 960×540 local window.

The matching Web export is checked into web-preview/. Serve that folder over HTTP as described in its README. Temporary Mystara art reuse permission is unverified; keep the repository and preview private. This is a focused 0.0.1 experiment, not the 0.1.0 public slice.

## Current development

The owner accepted the first exchange's feel (D-073) and placeholder lab rhythm/resolution (D-074). A separate [Light/Heavy combo experiment](docs/Combo-Experiment.md) now follows the selected knockback finisher (D-075): J–J–J pressure or J–J–L knockback, with Heavy commitment and a one-input buffer. Five pinned headless harnesses and four-scene browser checks pass; the new combo still needs owner feel review. The accepted preview remains the default; routes are `?lab=combat-exchange`, `?lab=money-shot` and `?lab=combos`. See [Progress](docs/Progress.md) for evidence. Later class/roster/wheel gates remain unimplemented.

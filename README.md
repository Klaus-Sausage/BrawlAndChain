# Brawl & Chain

## Start here

- **Fresh chat:** read [NEW-CHAT-HANDOFF.md](NEW-CHAT-HANDOFF.md).
- **Design baseline:** [GDD](docs/GDD.md), [decisions](docs/Decisions.md), [open questions](docs/Open-Questions.md), and [progress](docs/Progress.md).
- **Original evidence:** [source index](docs/sources/README.md), [historical transcript](docs/sources/Historical-Design-Chat.md), and [original PDF](docs/sources/Historical-Design-Chat.pdf).
- **Working rules:** [AGENTS.md](AGENTS.md).

Brawl & Chain is a co-op tactical beat-'em-up. The GDD records the recovered design and distinguishes established rules from open questions and small playable experiments.

## Engine and backup

The project uses Godot 4 with GDScript and Compatibility rendering. Local Godot 4.7.2 and matching web templates are installed; see [Godot Setup](docs/Godot-Setup.md). The repository is private at https://github.com/Klaus-Sausage/BrawlAndChain. Cloud and PC checkouts are separate; pull before switching and push completed changes.

## Current private build

The default scene, scenes/visual_preview.tscn, is the approved 0.0.1 Mystara Fighter movement-and-strike preview. It uses a ROM-derived sword-and-shield Fighter, Mystara goblin and Trintan village. Press F5 to run; use WASD to move, J for a single press-triggered strike, and F2 to show/hide the strike range/lane diagnostics. Current range is 95 px and lane tolerance is 18 px. The canvas is 480×270 with a 960×540 local window.

The matching Web export is checked into web-preview/. Serve that folder over HTTP as described in its README. Temporary Mystara art reuse permission is unverified; keep the repository and preview private. This is a focused 0.0.1 experiment, not the 0.1.0 public slice.

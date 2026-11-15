# Brawl & Chain

Portable project documentation — prepared 2026-11-15; updated 2026-11-16 (Australia/Melbourne).

> Brawl & Chain is a hard-hitting co-op beat-’em-up with real-time tactical squad control, set in an over-the-top sword-and-sandal fantasy world of huge muscles, deadly curves, savage monsters and brutal team synergies.

## Start here

- **Starting a fresh Codex chat:** use the latest GitHub checkout and read [NEW-CHAT-HANDOFF.md](NEW-CHAT-HANDOFF.md). A folder/ZIP is an offline handoff alternative; older downloads are snapshots, not the latest repository state.
- **Current game design:** [GDD](docs/GDD.md).
- **Decisions and changes:** [decision register](docs/Decisions.md).
- **Unresolved items:** [open questions](docs/Open-Questions.md).
- **Actual development state:** [progress and build log](docs/Progress.md).
- **Original evidence:** [source index](docs/sources/README.md), [full Markdown transcript](docs/sources/Historical-Design-Chat.md), and [original PDF](docs/sources/Historical-Design-Chat.pdf).
- **Assistant working rules:** [AGENTS.md](AGENTS.md).

## What this package contains

The previous summaries omitted agreed rules because they did not have the original conversation. This package was rebuilt from the owner's 140-page Historical Design Chat PDF and later direct confirmations in the Codex setup conversation. It recovers the rules for Reacharound, Circle Jerk, MUM RULES, the Goblin King sequence, gear sets, presentation, and vertical-slice scope. The full extracted source remains available when a summary needs checking.

The GDD is a maintained working baseline, not a claim that balance, timing, class kits, or every edge case is specified. It distinguishes full-game ambitions from the first public slice and smaller prototypes. Earlier incomplete documents are not archived here: their original uploaded files are absent from the current environment. The PDF is the stronger source for recovered historical decisions.

## Cloud and Linux workflow

Local repository recorded during setup: `/home/klaus/Documents/BrawlAndChain`. Private GitHub repository: `https://github.com/Klaus-Sausage/BrawlAndChain`. The private `Default Cloud` configuration is published with this repository attached; its setup clone used `/workspace/BrawlAndChain`. Cloud read and write access were subsequently verified by creating, checking, and deleting a temporary branch without changing the default branch. A fresh task launched from the published configuration is still untested. See [Progress](docs/Progress.md) for evidence and current work locations.

Pull before working and commit/push before switching environments. Automatic synchronization is not configured. Cloud and PC copies are separate, not a live shared folder. Inspect the actual checkout and branch in each session; a folder named BrawlAndChain is not proof it is a Git checkout.

## Engine direction

**Godot 4 + GDScript**, replacing the earlier Unity choice by owner-approved decision on 2026-11-16. Typed GDScript is the recommended initial convention; Compatibility rendering is the planned browser baseline. Local Godot 4.7.2 stable and matching web templates are verified; other machines need their own installation. The game design, browser-first slice, Steam/PC direction, and eventual PS5/Switch 2 aspirations remain in place. Godot console work requires approved platform access and suitable third-party tooling or porting services.

## Current implementation status

A minimal Godot 4.7.2 Compatibility project now includes the private 0.0.1 WASD movement and single-strike experiment. Native rendering and browser movement/hit/miss behavior were verified; owner feel review remains pending. Production assets, full-slice gameplay, and console developer access/platform builds have not been verified. Historical Unity references remain in the source archive and dated records.

## Local technical launch test — 2026-11-16

Standard Godot **4.7.2 stable**, GDScript and matching web templates are installed locally. Compatibility rendering is configured; native/editor launch and browser movement/hit checks passed for the initial private 0.0.1 experiment. Read [Godot setup](docs/Godot-Setup.md) and [the Visual Preview notes](docs/Visual-Preview.md) for exact setup, controls, repeatable commands, evidence and limitations. Open `project.godot` with Godot or run `godot --editor --path .`. Owner feel review remains pending; this is not the public 0.1.0 slice.

## Private visual study

The default scene now shows a static fantasy sprite composition using temporary Mystara artwork, with no HUD or gameplay. Run `godot --path .`; see [Visual Preview](docs/Visual-Preview.md) for screenshots, source credits, reproduction commands and limitations. The existing launch-check scene can be run explicitly. Keep these temporary assets and builds private; replace before public distribution.

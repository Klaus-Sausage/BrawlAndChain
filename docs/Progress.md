# Development Progress and Build Log

Updated 2026-11-16 (Australia/Melbourne).

## Current build — private 0.0.1 Mystara Fighter preview

The approved default scene is scenes/visual_preview.tscn. It shows the ROM-derived armed Fighter with sword and shield, the Mystara goblin, and Village of Trintan. Ax Battler and its comparison scene/assets have been retired from the active project; the dated decision history records that experiment.

The prototype has provisional WASD floor movement, idle/walk and one sword attack. J triggers once per fresh press; holding does not repeat. Movement remains available during a swing. Contact resolves at attack step 5 / atlas frame 22. The original strike cadence is about 0.1845 seconds and the owner likes its speed and on-screen appearance. The owner set strike_range to 95 px after using the F2 overlay; lane_tolerance is 18 px. F2 shows the exact front-facing range/lane zone and separate FRONT/RANGE/LANE checks. These are experimental values, not final balance.

## Verification completed

- MAME 0.264 audited the supplied ddsomur1 USA 960209 ROM. The game's viewer assembled the original sword and shield; timing and frame origin were derived from emulated frames. ROMs, keys, emulator, dumps and intermediate captures remain outside the repository. Asset reuse permission is unverified; the project stays private.
- Native Godot 4.7.2 Compatibility on RTX 3080 rendered the 480×270 preview at 60 fps. Synthetic checks passed all walk poses, idle return, facing, hit/miss conditions, contact timing, moving attack/facing lock, hold-repeat suppression, distinct follow-up tap, and arena bounds.
- Browser WebGL 2 Compatibility loaded the 480×270 canvas. Close hit and distant/facing-away/wrong-lane misses were observed. Holding J for 1.8 seconds yielded one strike; a separate tap yielded the next. F2 overlay rendered and reported FRONT=YES, RANGE=NO, LANE=YES at the original 200 px gap.
- The owner reviewed the armed Fighter appearance and walk and said it looked and felt great. Native and browser previews use the same framing. The 95 px range and updated Web build are checked in.
- The browser export is versioned under web-preview/ and can be served locally as documented there. GitHub does not host it as a playable site; the repository is private.

## Current next action

The owner confirmed satisfaction with the current 95 px strike range/hit positions and requested no further tuning. The next step is to choose one focused proof question for the next private 0.0.x build using the proposed [0.1.0 roadmap](Roadmap.md).

## Roadmap planning — 2026-11-16

At the owner's request, added [Roadmap](Roadmap.md), a proposed full delivery sequence for 0.1.0. It uses the slice requirements already in the GDD, keeps open mechanics and content decisions as gates, and assigns no dates or 0.0.x build numbers. Linked it from the README, handoff, GDD, decision register, and open questions. This was documentation work only; no game code or build was changed and no gameplay verification was run.

The owner then confirmed satisfaction with the current 95 px strike range/hit positions and requested no further tuning. Marked the 0.0.1 hit-position check complete in the roadmap, GDD, Open Questions, Visual Preview, and handoff. No specific overlay diagnostic readings or new gameplay test were reported; the approval records the owner's feel judgment only.

## Superseded art experiment and extraction history

The first downloaded Mystara Fighter sheet was followed by an Ax Battler / Golden Axe II experiment. The owner disliked the walk feel, then chose the armed Mystara Fighter extracted from the supplied MAME ROM. The Ax-only art, scene, scripts, screenshots, and preparation branch were removed from the current tree in the 2026-11-16 cleanup. Historical approvals and reversals remain in docs/Decisions.md; archived source conversations remain unchanged.

The supplied ROM support files resolved the earlier MAME blockers. The verified secret viewer and palette capture produced idle, full walk, and sword attack frames with original equipment assembly. See assets/temporary_mystara_rom/README.md for technical provenance and reproducible external capture details. Emulator outputs and ROM data were kept outside the repository.

## Earlier setup and repository history

- Godot 4.7.2 stable, GDScript and matching web templates are installed locally; Compatibility rendering and minimal native/browser launch were verified. Cloud Godot setup is unverified. See docs/Godot-Setup.md.
- The repository is private at https://github.com/Klaus-Sausage/BrawlAndChain. Push/pull are explicit; cloud and PC checkouts do not sync automatically.
- The initial visual study established the provisional 480×270 canvas, 960×540 window, nearest filtering and Trintan arena. These settings remain provisional.
- Public milestone is 0.1.0. A proposed full delivery sequence is now recorded in [Roadmap](Roadmap.md); its milestones and order are adjustable, and each 0.0.x build should still answer one primary playtest question.

## Build log

| Build | Primary question | Current result | Next |
| --- | --- | --- | --- |
| 0.0.1 private preview | Do basic movement and one satisfying strike work with readable original Mystara Fighter animation? | Owner approves the armed look, cadence, speed, and current 95 px range/hit positions. Native/browser checks pass. | Choose the next focused prototype question using Roadmap.md. |


## Cleanup and final verification — 2026-11-16

Retired the Golden Axe/Ax Battler files and comparison experiment from the current tree, removed its branch from the visual asset-preparation tool, and renamed the approved scene, animation and check tool to stable preview names. The default scene remains the ROM-derived Mystara Fighter at 95 px strike range with F2 diagnostics and fresh-press J input. Dated decision history and archived source transcripts are preserved.

Native Godot 4.7.2 Compatibility rerun on RTX 3080 passed the full preview harness after the rename: all 13 walk poses, both facings, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, follow-up tap, contact frame 22, arena bounds, and one swing from a held/repeating J key (failures=[]). Browser WebGL2 Compatibility loaded the renamed default at 480×270; F2 displayed the 95 px zone and FRONT/RANGE/LANE status. No browser console errors were reported. The regenerated web-preview export matches the active project. Export/editor printed restricted socket/editor-settings messages after the pack was written; browser launch confirmed the export works.

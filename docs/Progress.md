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

Continue owner playtesting the 95 px strike range with F2 at positions that were previously missing. Check which of FRONT/RANGE/LANE fails and tune only from observed feel. No further feature queue is approved; after this basic hit test feels right, choose the next prototype question with the owner.

## Superseded art experiment and extraction history

The first downloaded Mystara Fighter sheet was followed by an Ax Battler / Golden Axe II experiment. The owner disliked the walk feel, then chose the armed Mystara Fighter extracted from the supplied MAME ROM. The Ax-only art, scene, scripts, screenshots, and preparation branch were removed from the current tree in the 2026-11-16 cleanup. Historical approvals and reversals remain in docs/Decisions.md; archived source conversations remain unchanged.

The supplied ROM support files resolved the earlier MAME blockers. The verified secret viewer and palette capture produced idle, full walk, and sword attack frames with original equipment assembly. See assets/temporary_mystara_rom/README.md for technical provenance and reproducible external capture details. Emulator outputs and ROM data were kept outside the repository.

## Earlier setup and repository history

- Godot 4.7.2 stable, GDScript and matching web templates are installed locally; Compatibility rendering and minimal native/browser launch were verified. Cloud Godot setup is unverified. See docs/Godot-Setup.md.
- The repository is private at https://github.com/Klaus-Sausage/BrawlAndChain. Push/pull are explicit; cloud and PC checkouts do not sync automatically.
- The initial visual study established the provisional 480×270 canvas, 960×540 window, nearest filtering and Trintan arena. These settings remain provisional.
- Public milestone is 0.1.0. The project has no approved detailed feature roadmap. Each 0.0.x build should answer one primary playtest question.

## Build log

| Build | Primary question | Current result | Next |
| --- | --- | --- | --- |
| 0.0.1 private preview | Do basic movement and one satisfying strike work with readable original Mystara Fighter animation? | Owner approves the armed look, cadence and speed. Native/browser checks pass. Strike range is currently 95 px; owner is checking positions with F2. | Finish range/hit-position playtest, then agree the next prototype question. |


## Cleanup and final verification — 2026-11-16

Retired the Golden Axe/Ax Battler files and comparison experiment from the current tree, removed its branch from the visual asset-preparation tool, and renamed the approved scene, animation and check tool to stable preview names. The default scene remains the ROM-derived Mystara Fighter at 95 px strike range with F2 diagnostics and fresh-press J input. Dated decision history and archived source transcripts are preserved.

Native Godot 4.7.2 Compatibility rerun on RTX 3080 passed the full preview harness after the rename: all 13 walk poses, both facings, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, follow-up tap, contact frame 22, arena bounds, and one swing from a held/repeating J key (failures=[]). Browser WebGL2 Compatibility loaded the renamed default at 480×270; F2 displayed the 95 px zone and FRONT/RANGE/LANE status. No browser console errors were reported. The regenerated web-preview export matches the active project. Export/editor printed restricted socket/editor-settings messages after the pack was written; browser launch confirmed the export works.

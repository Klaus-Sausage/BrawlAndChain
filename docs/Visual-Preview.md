# Private visual and combat preview

## Current approved build

The default scene is scenes/visual_preview.tscn. It uses the original sword-and-shield Mystara Fighter assembled from the owner's supplied MAME ROM, the Mystara goblin, and Village of Trintan. The owner reviewed the art and walk cadence and said it looks and feels great. Keep this ROM-derived art private; reuse permission is unverified. Extraction and source details are in assets/temporary_mystara_rom/README.md.

The provisional canvas is 480×270, shown in a 960×540 local window with nearest filtering and integer scaling. The scene uses a fixed camera, hero at (140,226), goblin at (340,226), and shared floor depth. It remains a framing/game-feel experiment, not a final resolution or production-art decision.

## Controls and strike checks

- WASD moves horizontally and along the floor; the hero is clamped to the arena and faces horizontal movement.
- J starts one directional sword strike on a fresh key press. Holding J does not repeat. A new press is accepted after the gameplay action lock and minimum delay.
- F2 toggles the debug overlay. It draws the exact front-facing range zone from the hero origin and displays FRONT/RANGE/LANE for the goblin origin. This is a point-to-point rule visualization, not a body-shaped collision volume.
- Current tuning: strike_range 95 px; lane_tolerance 18 px; strike_repeat_delay 0.32 s. Movement speed is 90 px/s; horizontal margin 24 px; floor depth 185–246 px. Values are experimental.

Attack timing follows MAME emulated frames (59.637405 Hz). The sword clip has ten steps, lasts about 0.1845 s, and resolves one contact at step 5 / atlas frame 22. The owner likes this speed. WASD movement continues during the animation while facing stays locked to the accepted attack direction.

## Actual results

- Native Godot 4.7.2 Compatibility on RTX 3080: scene rendered at 480×270; synthetic checks passed idle/walk poses, both facings, close hit, distant/facing-away/wrong-lane misses, contact frame, moving swing/facing lock, hold-repeat suppression, follow-up tap, and arena bounds. Recording and output: docs/visual-evidence/mystara-rom/native-preview.mp4 and native-check.log.
- Browser: single-threaded WebGL 2 Compatibility loaded at 480×270. Hit and miss checks were observed. A 1.8-second held J press produced one strike result; a separate tap produced the next. F2 showed the range zone/readout. The browser build in web-preview/ matches the current 95 px range.
- The owner reports the armed Fighter looks and feels right, and confirmed satisfaction with the current 95 px strike range/hit positions (“happy with all that”). The owner requested no further tuning. This confirms the current private preview feel; it does not lock production combat balance.
- This prototype has no enemy AI or attacks, combos, health UI, damage numbers, abilities, audio, or networking.

## New separate foundation experiments — 2026-11-16

The accepted preview remains the default. Its combat outcomes now come from shared authoritative state, independent of visible sprite playback. Four pinned Godot 4.7.2 headless harnesses pass, including original regressions, 15/30/60/144 presentation-rate comparisons, absent/disabled presentation, audio scheduling and all 22 reciprocal-exchange checks.

The foundation checkpoint added two scenes:

- scenes/combat_exchange.tscn: one stationary goblin, hidden health, telegraphed melee, temporary owner-selected hold-guard and defeat/reset. K held guards/stands still; R resets. Guard covers the front, prevents a new strike and does not cancel an active strike. See [Combat Experiment](Combat-Experiment.md) for provisional values and behavior.
- scenes/money_shot_lab.tscn: generated original placeholder music, Stream playback, music-clock crescendo/resolution while simulation slows, and camera/time restoration. Click Start audio, then Test finish; Reset interrupts and Preview returns to the default.

The export helper includes experiment routes ?lab=combat-exchange and ?lab=money-shot while retaining the original default. Headless Chromium 156.0.8078.79 software WebGL 2 passed real-input preview and exchange checks, including guard/no damage, defeat, reset, three-hit victory and reset. The lab produced nonzero Web Audio output (peak approximately 0.2095), repeated resolution events and reset/return behavior. No Godot/JavaScript/HTTP errors were reported. [Preview frame](foundation-evidence/preview.png), [guard frame](foundation-evidence/exchange-guard.png), [lab frame](foundation-evidence/money-shot-active.png), [browser results](foundation-evidence/browser-results.json).

The owner accepted first-exchange feel (D-073), then confirmed steady placeholder music rhythm during slowdown and smooth resolution into the loop (D-074). D-075 selects knockback for the separate [combo experiment](Combo-Experiment.md): J–J–J pressure versus J–J–L knockback. The new combo's feel remains pending; final kits/balance, Thief comparison, soundtrack and boss integration remain open. Gamepad, FPS and actual browser focus loss remain unverified. Shared visible Chrome lacked WebGL 2 and native capture could not access the managed display. See [Progress](Progress.md) for current checks and repeatable commands; steps 5–14 are unimplemented.

The later scenes/combo_experiment.tscn adds temporary J Light/L Heavy controls, one queued follow-up and a committed persistent knockback finish at ?lab=combos. Five headless harnesses and four-scene browser checks pass. [Heavy frame](combo-evidence/combo-heavy.png) and [browser evidence](combo-evidence/browser-results.json). The accepted preview/exchange visuals are preserved; reused frames and Heavy cues are rough stand-ins.

## Preserved launch test

Run the original technical launch check explicitly with godot --path . res://scenes/launch_test.tscn. Its script restores the 960×540 content scale.

## Retired art exploration

A temporary downloaded hero sheet and comparison scene were used before extracting the armed Mystara Fighter from the supplied ROM. The owner selected the ROM-derived version and approved it. Ax Battler files and comparison code have been removed from the active project; D-062 through D-065 preserve the dated decision history.

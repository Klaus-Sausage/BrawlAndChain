# First private visual preview

## Armed Fighter candidate — 2026-11-16 (current)

**EXPERIMENTAL / PLAYTEST REQUIRED:** Extracted complete sword-and-shield Fighter poses from the owner's audited `ddsomur1` USA 960209 ROM with MAME 0.264. The verified secret viewer uses the game's own equipment assembly; there is no invented weapon overlay. Four idle poses, thirteen walk steps (entry plus twelve-step loop), and ten sword-strike steps are in `assets/temporary_mystara_rom`. Timing comes from emulated frame records at 59.637405 Hz. The walk entry is not repeated on subsequent loops. The shared origin preserves source body movement.

Separate playable scene: `scenes/fighter_candidate.tscn`. **Ax Battler remains the default.** Existing movement, range/lane checks, goblin reaction and minimum strike delay remain unchanged. The candidate uses per-step durations and resolves once at attack step 5 / atlas frame 22. Original strike lasts approximately 0.1845 seconds; its speed and visible reach versus the existing hit range need owner feel review.

Native Godot 4.7.2 Compatibility ran on the RTX 3080 and recorded 461 frames at 60 fps. Synthetic-input checks passed: all walk poses then idle, both directions, close hit, distant/facing-away/wrong-lane misses, moving attack/facing lock, next swing, contact frame, and arena bounds. The first harness observation included a pre-movement idle frame; corrected the observation window/filter and reran successfully. The recording is `docs/visual-evidence/mystara-rom/native-candidate.mp4`; results are in `native-check.log`. Actual rendered walk sequence samples were inspected for origin stability and transparency. This is not a physical-keyboard or subjective smoothness approval.

The separate release web export launched in the browser using WebGL 2 Compatibility, single-threaded, 480×270 canvas at a 960×540 viewport. Browser keyboard checks produced close hit, distant miss, facing-away miss and wrong-lane miss; rendered framing and transparent sword/shield match native. No runtime errors appeared in the inspected browser log. Full frame-by-frame browser cadence/contact has not been independently recorded. The owner reports fast separate taps feel right; holding J repeated too quickly, which is corrected to ignore key autorepeat. Runtime recheck of this final input adjustment is pending. Browser preview: http://127.0.0.1:8061/ while its local server runs. Export output stays ignored under `exports/fighter_candidate`.

The owner selected browser inspection during iteration, superseding the earlier local-only approval gate. Missing ROM-support files and the claimed inability to capture native graphics are resolved: MAME headless snapshots work, and approved desktop access enables native Godot capture. Earlier investigation entries below are historical. Confirmed emulator output directories were moved out of the project to `/tmp/bac-mystara-fighter-feasibility/runtime`; ROMs, keys, emulator, dumps and intermediate captures remain outside the repository.

**Next:** owner reviews armed appearance, walk cadence, scale and sword strike in the candidate. Iterate before activation; only after approval switch default, recheck native/browser, commit/push and verify remote. No candidate approval, commit or push is claimed. Private temporary art permission remains unverified.


2026-11-16. The preview began with a temporary Mystara Fighter/Barbarian stand-in, goblin and Village of Trintan. On 2026-11-16 the owner approved replacing only the hero art with Ax Battler from Golden Axe II; the Mystara goblin and setting remain. The composition is an approved starting point, while canvas/display resolution, sprite scale and animation timing remain experimental.

## Layout and operation

Default scene: `scenes/visual_preview.tscn`. Run `godot --path .` or open the project and press F5. It contains a fixed Camera2D at (240,135), hero at (140,226), goblin at (340,226), village backdrop and a separate foreground floor crop. The figures have replaceable `Visual` child nodes and share a foot baseline. The hero has the temporary walk and attack animation described below; there is no audio.

Provisional 480×270 internal canvas, 960×540 desktop window, viewport stretch with integer scaling/letterboxing and nearest-neighbour texture filtering. Sprites use source pixel proportions at 1× internally. This is an experiment in composition and scale, not a locked production resolution or final Barbarian design. Scene scripts handle movement, animation, hit checks and presentation; the root scene script logs readiness and supports optional verification capture.

Original launch-check scene is preserved. Run it explicitly with `godot --path . res://scenes/launch_test.tscn`; its script restores its 960×540 content scale so the existing controls remain visible.

## 0.0.1 — Basic movement and hit feel

Owner-approved 2026-11-16. This private experiment asks whether floor-depth movement and one clear strike feel like a sound starting point. The code is deliberately small and replaceable: `hero_intent.gd` converts provisional WASD/J input to movement/strike intent, `combat_resolver.gd` checks front/range/lane and reports a hit or miss, `goblin_reaction.gd` presents hit flash/knockback, and `visual_preview.gd` presents short HIT/MISS text. Input/origin, hit decision and sprite response remain separate. The goblin has no AI or attacks.

- **WASD:** A/D across the arena, W/S along the floor; movement is clamped to scene bounds. Horizontal movement changes facing. The active Ax Battler frames are flipped according to their source orientation.
- **J:** one strike in the current facing direction. A miss shows MISS but does not flash or move the goblin. A hit briefly colors and nudges the goblin, then it settles back to its starting point.
- **Editable tuning:** `movement_speed` (90 px/s), horizontal margin (24 px), floor range (185–246 px), strike range (95 px), lane tolerance (18 px), strike repeat delay (0.32 s), flash (0.12 s), knockback (12 px), settle speed (90 px/s) and feedback duration (0.45 s). These are test values, not game-design commitments.
- **Not included:** combos, enemy AI/attacks or animation, health display, damage numbers, abilities, networking, production art, or audio.

### Previous hero animation pass — Mystara Fighter (superseded)

The owner approved a walk loop and basic attack using the temporary Fighter sheet. Its atlas, frames and checks below describe the superseded hero-art version; the original, derivatives and their notes remain preserved. The current animation mapping is recorded next.

`hero_intent.gd` owns movement and accepted input; `hero_animation.gd` owns playback and sends a contact signal; `combat_resolver.gd` checks the current positions/facing at contact. WASD selects walk or idle. A fresh J key-down starts the one-shot attack, including a miss; holding J does not repeat it. A later separate tap is accepted after the current attack finishes and the 0.32-second minimum delay expires. Facing is held from acceptance while movement continues. Provisional, editable animation settings are 8 walk frames per second, 16 attack frames per second, and contact on attack frame 8 of 9. Goblin behavior remains the existing flash and displacement only.

### Previous Fighter verification — 2026-11-16

- Godot 4.7.2 stable import and Compatibility runtime pass. Native non-headless run on NVIDIA RTX 3080 logged `COMBAT_TEST_READY platform=Linux renderer=gl_compatibility viewport=(480.0, 270.0) controls=WASD+J`; frame capture returned `COMBAT_CAPTURE result=0 size=(480, 270)`. Existing X11 input-method warning remains; the game rendered successfully.
- Release Web export completed with the matching standard 4.7.2 template. Localhost in-app Chromium loaded WebGL 2.0/Compatibility and logged `COMBAT_TEST_READY platform=Web renderer=gl_compatibility viewport=(480.0, 270.0) controls=WASD+J`. Browser console errors/warnings: none.
- Browser interaction: long D movement approached the goblin and J logged `STRIKE_RESULT hit=true`; visible HIT text appeared, and the goblin remained visible after its reaction. An isolated J from the starting distance logged `hit=false`. Moving briefly left while in close range, then pressing J, logged `hit=false` while facing away. W movement changed floor position; long D and S movement held the hero at the right/bottom arena bounds. Pixel edges stayed crisp and the scene framing remained fixed.
- Animation pass on the old Fighter art: the browser walk loop alternated steps with feet on the floor line. Stationary and moving attacks, contact hits, distance/facing misses, repeated-input lock, both orientations, transparency, crisp scaling and framing were checked. These observations do not verify the Ax Battler version.
- These checks verify code response and browser execution, not whether the movement, range, impact, or timing feels good to the owner. Controls and values are provisional. No gameplay owner playtest or external playtest has occurred.

Reproduce: `godot --headless --editor --path . --import`; `godot --path .`; `godot --headless --path . --export-release Web exports/web/index.html`; `python3 tools/serve_web.py`; open `http://127.0.0.1:8060/`. Keep exported files private with the Mystara and Golden Axe II assets.

Current hero-art provenance and replacement notes: [temporary Golden Axe artwork](../assets/temporary_golden_axe/README.md); retained Mystara assets: [temporary Mystara artwork](../assets/temporary_mystara/README.md). The new Ax Battler original is ignored by Godot import; its derivative atlas is imported for the scene. No browser export/test has been run for the Ax Battler swap yet.

### Ax Battler art swap — 2026-11-16

Owner approved the exact Golden Axe II Ax Battler source after asking to locate the original weapon-bearing sprite, then explicitly requested implementation. Source page: <https://www.spriters-resource.com/sega_genesis/goldenaxe2/asset/36388/>; displayed uploader/contributor Yawackhary. The source PNG is preserved with its sheet footer credit and its source page, original image URL, dimensions and SHA-256 in the [asset notes](../assets/temporary_golden_axe/README.md) and manifest. Reuse permission is unverified; the preview/repository remain private. No weapon overlay is used.

Following owner feedback that the walk seemed to cycle through idle, the repeated source pose was removed from the walk range. The atlas now has idle frame 0, three distinct walk frames 1–3 and four sword frames 4–7, in transparent 96×96 cells with feet aligned at y=80. Attack contact remains frame 2 of the attack (atlas frame 6), where the sword slash/trail is visible. Movement, hit/range/lane/facing logic and goblin reaction are unchanged. The previous Mystara sources and derivatives are preserved. **This corrected walk mapping needs local verification and owner review; web export remains gated on approval.**

### Ax Battler native verification — 2026-11-16

- Godot 4.7.2 stable imported the corrected 768×96 RGBA atlas. The original sheet remains 496×544 and its SHA-256 is `1fade009c887160a535f2e4b9bb8d9b0260e7026152c0d70e3a2e0dc64f036fb`; the corrected atlas SHA-256 is `9e2ff683344767cf150c8ffa21cca6b9fb28875b8b78cf8f6839d0ffb5f51021`. All eight frames have transparent backgrounds and the same y=80 footline. The original source and earlier Mystara files are unchanged.
- Native non-headless Compatibility run on NVIDIA RTX 3080 logged `COMBAT_TEST_READY platform=Linux renderer=gl_compatibility viewport=(480.0, 270.0) controls=WASD+J`; its frame capture returned `COMBAT_CAPTURE result=0 size=(480, 270)`. Godot printed the existing X11 input-method (`wd.xic`) warning, then rendered successfully. [Native Ax Battler frame](visual-evidence/ax-battler-native.png).
- A temporary input-driven GDScript runtime check verified D movement; sampled walk frames `[1, 2, 3, 1, 2]` (never idle frame 0); stopping to frame 0; left/right art orientation; still and moving successful attacks; hit resolution on atlas frame 6 (the visible slash); goblin displacement; repeated-J lock; facing-away miss; and wrong-lane miss. Results: `[true, true, false, false]` for the two hits and two misses. This harness used Godot input event injection in headless mode; keyboard delivery through the visible native window was not separately checked.
- A separate `--capture-walk-sequence` non-headless Godot Compatibility run captured the actual scene at walk frames `[1, 2, 3]` on the RTX 3080. [Native walk-pose sequence](visual-evidence/ax-battler-native-walk-poses.png). This verifies those rendered poses and their order; it is a sequence capture, not a live user-input recording.
- The visible native capture shows the Ax Battler on the unchanged shared floor with clear transparency and nearest-neighbour pixel rendering. The hero is slightly taller than the previous Fighter; this is the replacement scale to review, not a new approval of composition. Camera, backdrop, goblin placement and viewport remain unchanged. Browser export and checks are intentionally pending the owner's approval of the local version.
- Owner feedback after trying the revised cycle in Godot: it still looks “all janky.” The duplicate-idle issue is removed, but the walk has **not** passed feel review; do not proceed to web export until the native walk is resolved and approved.

### Optional Fighter comparison scene — 2026-11-16

The owner supplied a local `ddsomur1` MAME ROM directory to look for the original Fighter animation. All eight graphics ROM chips passed their MAME CRCs, and decoded 16×16 tiles match the preserved Fighter reference sheet. This verifies that the ROM includes the same art, but the game-specific frame assembly and palette are still unrecovered. MAME cannot launch without `ddsomu.key` and `qsound_hle/dl-1425.bin`; the owner does not have those files.

For a reversible review, `scenes/hero_art_comparison.tscn` places the existing Fighter atlas beside Ax Battler; press 1/2/3 for idle/walk/attack. It is not extracted ROM art, does not change the default scene or gameplay and leaves Ax active. Godot 4.7.2 Compatibility headless launch passed at 480×270. No visual capture was produced because this managed shell has no working X11/Wayland display. Review the scene in the owner's local Godot window before deciding whether to develop this candidate further. ROM chips, decoded tiles and MAME binaries stay outside the repository.

The walk frames are visible together in the [Ax Battler atlas](../assets/temporary_golden_axe/display/ax_battler_animations.png): idle frame 0; walk frames 1–3; sword attack frames 4–7.

## Actual verification

- Godot 4.7.2 stable: import and release web export exited successfully with no logged errors.
- Native non-headless Compatibility run on RTX 3080: logged a 480×270 viewport and captured that framebuffer successfully (result 0). [Native frame](visual-evidence/native.png), [2× view](visual-evidence/native-2x.png), [log](visual-evidence/native.log).
- Browser: served only on `127.0.0.1:8060` with `python3 tools/serve_web.py`; in-app Chromium/WebGL 2.0 loaded the single-threaded release export. Same 480×270 framing and facing, clear transparency and pixel scaling observed. [Browser screenshot](visual-evidence/browser.jpg), [console](visual-evidence/browser-console.json). No browser warnings/errors returned.
- Native retains the previously observed X11 input-method warning; static rendering succeeded. No gameplay, audio, performance or other-browser claims follow from this check.
- Preserved launch-check regression: non-headless explicit scene run returned `LAUNCH_READY`, captured 960×540 with result 0 and exited successfully after restoring its content scale.
- Source image bytes preserved with hashes; original historical design archives unchanged. No public hosting or sharing created.

Repeat export: `godot --headless --path . --export-release Web exports/web/index.html`. Native evidence capture: `godot --path . -- --capture-preview` writes `/tmp/brawl-visual-native.png` then exits. Build output is ignored.

## Owner review

2026-11-16: Owner reviewed the native/browser composition and confirmed “yeah thats perfect”. **CURRENT for this private visual study:** approved character scale, camera distance and composition as shown. The 480×270 canvas and 960×540 display remain provisional framing values, not a locked production resolution. The animation rates and contact frame are also provisional and need owner feel review. Final artwork and animation production remain future work.

Owner reviewed the armed Fighter preview and replied “perfect” on 2026-11-16. It is now the default. Native and refreshed browser default launches both show the same armed character, goblin and approved framing. The browser canvas is 480×270 and uses WebGL2 Compatibility; its in-app tab was left as a deliverable at localhost during review. See `docs/visual-evidence/mystara-rom/native-candidate.mp4` for the native sequence and `native-check.log` for the synthetic checks.

**D-066 result:** Verified in native and browser. Held J plus simulated native echo events produced one swing; releasing and pressing again after the lock/delay produced one more. In browser, a 1.8-second held press produced one result and a new tap after release produced the second. The test started out of range, so both recorded outcomes were misses. Original animation speed was unchanged.

### Debugging strike positions

Press **F2** to toggle a live hit-check overlay in the default scene. The green outlined rectangle shows where the goblin origin must be: in front of the hero, within 95 horizontal pixels and within 18 vertical pixels of the hero origin. The line/dot turns green only when all checks pass; the upper-left readout reports FRONT, RANGE and LANE separately. This visualizes the resolver's current point-to-point checks; it is not a character-body collision shape. Press F2 again to hide it. Verified in the browser: at the initial positions, FRONT=YES, RANGE=NO, LANE=YES.

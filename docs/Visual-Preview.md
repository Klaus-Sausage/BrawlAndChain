# First private visual preview

2026-11-16. Owner approved the initial visual-test plan: eventual 80s/90s fantasy sprite art, temporary Mystara Fighter/Barbarian stand-in, goblin and Village of Trintan. The composition was later extended into the private 0.0.1 movement-and-strike experiment below.

## Layout and operation

Default scene: `scenes/visual_preview.tscn`. Run `godot --path .` or open the project and press F5. It contains a fixed Camera2D at (240,135), hero at (140,226), goblin at (340,226), village backdrop and a separate foreground floor crop. The figures have replaceable `Visual` child nodes and share a foot baseline. The hero has the temporary walk and attack animation described below; there is no audio.

Provisional 480×270 internal canvas, 960×540 desktop window, viewport stretch with integer scaling/letterboxing and nearest-neighbour texture filtering. Sprites use source pixel proportions at 1× internally. This is an experiment in composition and scale, not a locked production resolution or final Barbarian design. Scene scripts handle movement, animation, hit checks and presentation; the root scene script logs readiness and supports optional verification capture.

Original launch-check scene is preserved. Run it explicitly with `godot --path . res://scenes/launch_test.tscn`; its script restores its 960×540 content scale so the existing controls remain visible.

## 0.0.1 — Basic movement and hit feel

Owner-approved 2026-11-16. This private experiment asks whether floor-depth movement and one clear strike feel like a sound starting point. The code is deliberately small and replaceable: `hero_intent.gd` converts provisional WASD/J input to movement/strike intent, `combat_resolver.gd` checks front/range/lane and reports a hit or miss, `goblin_reaction.gd` presents hit flash/knockback, and `visual_preview.gd` presents short HIT/MISS text. Input/origin, hit decision and sprite response remain separate. The goblin has no AI or attacks.

- **WASD:** A/D across the arena, W/S along the floor; movement is clamped to scene bounds. Horizontal movement changes facing. The Fighter art is flipped according to its left-facing source orientation.
- **J:** one strike in the current facing direction. A miss shows MISS but does not flash or move the goblin. A hit briefly colors and nudges the goblin, then it settles back to its starting point.
- **Editable tuning:** `movement_speed` (90 px/s), horizontal margin (24 px), floor range (185–246 px), strike range (78 px), lane tolerance (18 px), strike repeat delay (0.32 s), flash (0.12 s), knockback (12 px), settle speed (90 px/s) and feedback duration (0.45 s). These are test values, not game-design commitments.
- **Not included:** combos, enemy AI/attacks or animation, health display, damage numbers, abilities, networking, production art, or audio.

### 0.0.1 animation pass — 2026-11-16

The owner approved adding one visible walk loop and one basic attack using the existing temporary Fighter sheet. `tools/prepare_visual_assets.py` builds `display/fighter_animations.png` from source cells on the preserved sheet; it keys the magenta background to transparency, trims each frame and aligns the feet at y=160 in 192×192 cells. Source cells: idle (0,448), walk row y=640, columns 0–11, attack row y=1024, columns 0–8. Atlas frames are idle 0, walk 1–12 and attack 13–21. Original sheets and credits remain intact.

`hero_intent.gd` owns movement and accepted input; `hero_animation.gd` owns playback and sends a contact signal; `combat_resolver.gd` checks the current positions/facing at contact. WASD selects walk or idle. Each accepted J starts the one-shot attack, including a miss; facing is held from acceptance, while movement continues. Another J cannot start until the current attack finishes. The 0.32-second strike delay remains a minimum. Provisional, editable animation settings are 8 walk frames per second, 16 attack frames per second, and contact on attack frame 8 of 9. Goblin behavior remains the existing flash and displacement only.

### Actual verification — 2026-11-16

- Godot 4.7.2 stable import and Compatibility runtime pass. Native non-headless run on NVIDIA RTX 3080 logged `COMBAT_TEST_READY platform=Linux renderer=gl_compatibility viewport=(480.0, 270.0) controls=WASD+J`; frame capture returned `COMBAT_CAPTURE result=0 size=(480, 270)`. Existing X11 input-method warning remains; the game rendered successfully.
- Release Web export completed with the matching standard 4.7.2 template. Localhost in-app Chromium loaded WebGL 2.0/Compatibility and logged `COMBAT_TEST_READY platform=Web renderer=gl_compatibility viewport=(480.0, 270.0) controls=WASD+J`. Browser console errors/warnings: none.
- Browser interaction: long D movement approached the goblin and J logged `STRIKE_RESULT hit=true`; visible HIT text appeared, and the goblin remained visible after its reaction. An isolated J from the starting distance logged `hit=false`. Moving briefly left while in close range, then pressing J, logged `hit=false` while facing away. W movement changed floor position; long D and S movement held the hero at the right/bottom arena bounds. Pixel edges stayed crisp and the scene framing remained fixed.
- Animation pass: the browser walk loop visibly alternated steps with feet staying on the floor line. A close attack while stationary logged a hit at its contact frame with the goblin’s visible response; a distant attack, facing-away attack and rapid four-tap J sequence each produced a miss or only one accepted attack as expected. An attack started while D movement was held showed the swing while the hero continued moving, then returned to the appropriate movement state. Both character orientations, transparent edges, nearest-neighbour scaling and fixed framing remained intact. Browser console returned no warnings/errors.
- These checks verify code response and browser execution, not whether the movement, range, impact, or timing feels good to the owner. Controls and values are provisional. No gameplay owner playtest or external playtest has occurred.

Reproduce: `godot --headless --editor --path . --import`; `godot --path .`; `godot --headless --path . --export-release Web exports/web/index.html`; `python3 tools/serve_web.py`; open `http://127.0.0.1:8060/`. Keep exported files private with the Mystara assets.

Asset provenance and replacement notes: [temporary artwork](../assets/temporary_mystara/README.md). Original sheets remain unchanged and are excluded from engine import/export; display crops and the derived transparent animation atlas enter the web pack. To reproduce them, run `python3 tools/prepare_visual_assets.py` with Pillow installed.

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

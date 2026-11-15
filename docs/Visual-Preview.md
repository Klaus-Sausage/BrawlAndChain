# First private visual preview

2026-11-16. Owner approved implementing the static visual-test plan: eventual 80s/90s fantasy sprite art, temporary Mystara Fighter/Barbarian stand-in, goblin and Village of Trintan. This records a visual study, not playable 0.0.1.

## Layout and operation

Default scene: `scenes/visual_preview.tscn`. Run `godot --path .` or open the project and press F5. It contains a fixed Camera2D at (240,135), static hero at (140,226), goblin at (340,226), village backdrop and a separate foreground floor crop. The two figures face each other, have replaceable `Visual` child nodes and share a foot baseline. No HUD, movement, combat, animation loops or audio.

Provisional 480×270 internal canvas, 960×540 desktop window, viewport stretch with integer scaling/letterboxing and nearest-neighbour texture filtering. Sprites use source pixel proportions at 1× internally. This is an experiment in composition and scale, not a locked production resolution or final Barbarian design. The scene's only script logs readiness and supports optional verification capture.

Original launch-check scene is preserved. Run it explicitly with `godot --path . res://scenes/launch_test.tscn`; its script restores its 960×540 content scale so the existing controls remain visible.

Asset provenance and replacement notes: [temporary artwork](../assets/temporary_mystara/README.md). Original sheets remain unchanged and are excluded from engine import/export; only display crops enter the web pack. To reproduce the crops, run `python3 tools/prepare_visual_assets.py` with Pillow installed.

## Actual verification

- Godot 4.7.2 stable: import and release web export exited successfully with no logged errors.
- Native non-headless Compatibility run on RTX 3080: logged a 480×270 viewport and captured that framebuffer successfully (result 0). [Native frame](visual-evidence/native.png), [2× view](visual-evidence/native-2x.png), [log](visual-evidence/native.log).
- Browser: served only on `127.0.0.1:8060` with `python3 tools/serve_web.py`; in-app Chromium/WebGL 2.0 loaded the single-threaded release export. Same 480×270 framing and facing, clear transparency and pixel scaling observed. [Browser screenshot](visual-evidence/browser.jpg), [console](visual-evidence/browser-console.json). No browser warnings/errors returned.
- Native retains the previously observed X11 input-method warning; static rendering succeeded. No gameplay, audio, performance or other-browser claims follow from this check.
- Preserved launch-check regression: non-headless explicit scene run returned `LAUNCH_READY`, captured 960×540 with result 0 and exited successfully after restoring its content scale.
- Source image bytes preserved with hashes; original historical design archives unchanged. No public hosting or sharing created.

Repeat export: `godot --headless --path . --export-release Web exports/web/index.html`. Native evidence capture: `godot --path . -- --capture-preview` writes `/tmp/brawl-visual-native.png` then exits. Build output is ignored.

Next: owner reviews character size, camera distance and composition. Then agree the focused first-combat objective. Final artwork and animation production remain future work.

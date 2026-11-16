# Temporary armed Mystara Fighter — private preview

Original artwork: Capcom, Dungeons & Dragons: Shadow over Mystara (1996). Source is the owner's local `ddsomur1` USA 960209 ROM set, audited successfully with MAME 0.264. This is a separate ROM-derived extraction, **not** the downloaded Fighter sheet credited elsewhere. No sheet uploader is credited for these captures. Reuse permission is unverified; keep this project and preview private. ROM chips, keys and emulator binaries are not included. `provenance.json` records local source filenames and SHA-256 values.

## Extraction and repeatability

Working files remain outside the project at `/tmp/bac-mystara-fighter-feasibility`. The user originals are in `/home/klaus/Downloads/ddsomur1/`, with the supplied key and QSound archive in Downloads. All MAME cfg/nvram/snapshot/state/input/diff output paths must point outside the repository. The preserved runner there (`run.sh`) configures those paths, `-video none -sound none -nothrottle`, and the extracted MAME library path.

Reference investigation: [secret menu analysis](https://sudden-desu.net/entry/secret-menu-dungeons-dragons-shadow-over-mystara/). Published offsets differ from this USA revision. Verified decrypted instructions: `0x2905c: tst.w $c0.l`, `0x2906c: jmp $ecf68.l`. The capture script asserts these signatures before enabling the existing debug flag at ROM address 0xc0 in emulator memory only. No supplied ROM is modified. The menu state byte is 0xff1d56; Fighter object is 0xff85de. Char animations 0/2 are idle/walk; Atck animation 0 is the first sword strike.

The viewer's equipment flag is object+0x8b; front gear 0 is sword, back gear 40 is shield. Original attachment records drive the game's own renderer. Viewer initialization omits the shield palette; capture the real gameplay bank at 0x91c200..0x91c21f, then restore it in the viewer and trigger palette transfer. `tools/capture_mystara_palette.lua` captures that 32-byte bank from normal gameplay, outside the repository.

Run the palette capture for 57 emulated seconds using the external runner with `BAC_CAPTURE_DIR` set to an existing external directory. Then run `tools/capture_mystara_fighter.lua` for 27 seconds with `BAC_CAPTURE_DIR` pointing to the frame directory and `BAC_SHIELD_PALETTE` pointing to the captured bank. Prepare assets with:

```sh
python3 tools/prepare_mystara_rom_assets.py /tmp/bac-mystara-fighter-feasibility/final-capture assets/temporary_mystara_rom/display
```

The script records every emulated frame (240 per clip), screen-frame counter, animation pointer, timing counter and character origin in an external CSV. Background layers are cleared to verified RGB(68,170,102); only this exact colour becomes transparent. Palette and dark outlines remain intact. The full equipment pose is captured, not reconstructed with a custom overlay. Screen rendering lags the memory state by approximately two frames; frame selection uses ordered visual runs and timing comes from verified animation records, not screenshot wall-clock times.

## Timing and origin

`display/animations.json` is authoritative. Refresh 59.637405 Hz; 27 atlas cells, each 256×192, origin (128,160), source crop (64,0) to (320,192). Original facing is left. No per-pose lowest-pixel alignment. One source pixel equals one preview canvas pixel.

- Idle: four steps, ticks 32/10/32/10, loop at step 0.
- Walk: entry 5 ticks, then twelve steps of 3 ticks each. Subsequent loops begin at step 1. Capture covers more than two complete loops.
- Sword: ten steps, nine of 1 tick and the final 2 ticks. One-shot duration ~0.1845 seconds. Contact step 5, atlas 22; original active flag appears in steps 5–7. Existing gameplay emits only one contact.

Animation records start at 0x122526 (idle), 0x1225ee (walk; loop target 0x122606), and 0x1244a2 (attack); records are 24 bytes. Only derived images and numeric timing metadata are included, not decrypted code dumps.

GIF previews round to GIF's 10 ms time unit and are approximate; the Godot preview uses exact tick durations. The walk GIF shows only the repeating cycle; the labelled contact sheet includes the entry pose and every sword pose without cropping the weapon. This is the active preview art. See `docs/Progress.md` for actual checks and known limitations.

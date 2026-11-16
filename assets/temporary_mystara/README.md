# Temporary Mystara artwork — PRIVATE PREVIEW ONLY

Downloaded 2026-11-16 at the owner's explicit request for the first private visual build. These are existing Dungeons & Dragons: Shadow over Mystara graphics, not original Brawl & Chain art. Reuse permission from the rights holders is **unverified**; source-site availability and attribution do not establish a licence. Replace before any public demo/release. This private Git repository includes the originals and derivatives; making the repository/history public would also expose these assets.

Original game art: Capcom; Dungeons & Dragons associated rights belong to their respective holders. Retain all embedded source credits. Source pages, download URLs, contributors, dimensions and original SHA-256 hashes are in [sources.json](sources.json).

- Fighter: Sprite Database, contributed by **romab**. Temporary Barbarian visual only; no Fighter mechanics adopted.
- Goblins: The Spriters Resource, **T0misaurus**. Sheet also credits grod99 for fire sprites, unused here.
- Village of Trintan: The Spriters Resource, uploader displayed as Deleted User; embedded credit explicitly says **Ripped by Omega**.

`originals/` contains unchanged downloads, excluded from Godot import and export. `display/` contains deterministic crops and the derived hero animation atlas, with the exact sheet background colour made transparent. No generative redrawing or colour changes. `tools/prepare_visual_assets.py` reproduces them using Pillow; crop and frame coordinates are recorded there. The idle crop is 37×78; the atlas uses 192×192 cells with trimmed artwork centered horizontally and feet aligned to y=160. Its selected source cells are the idle at (0,448), walk columns 0–11 on row y=640, and attack columns 0–8 on row y=1024. The goblin is 65×46. Floor and village are separate 480×224 crops from the same sheet.

The Mystara Fighter is no longer the active hero visual. Its originals and derivatives remain preserved for provenance; the active private preview uses the Ax Battler sheet documented in [temporary Golden Axe artwork](../temporary_golden_axe/README.md). The goblin and Village of Trintan remain active. The Mystara permission note continues to apply to those assets.

# Temporary Golden Axe II artwork — PRIVATE PREVIEW ONLY

Downloaded 2026-11-16 for the owner-approved private hero-art experiment. This is existing SEGA Golden Axe II artwork, not original Brawl & Chain art. Reuse permission from the rights holders is **unverified**. Keep the repository and builds private; replace this art before any public demo or release. Repository history also retains the source, so making it public would expose it.

- Asset: Ax Battler (sword-bearing hero sheet), Golden Axe II, Sega Genesis.
- Source page: <https://www.spriters-resource.com/sega_genesis/goldenaxe2/asset/36388/>
- Original image URL: <https://www.spriters-resource.com/media/assets/34/36388.png?updated=1755472730>
- Contributor shown on the page: **Yawackhary**. The sheet footer reads “Ripped by Yawackhary, no credit needed but don't steal.” This attribution is retained here; it does not establish a licence.
- Original PNG: 496×544, indexed PNG, SHA-256 `1fade009c887160a535f2e4b9bb8d9b0260e7026152c0d70e3a2e0dc64f036fb`.
- SEGA and Golden Axe rights remain with their respective owners.

`originals/ax_battler.png` is the preserved source and is ignored by Godot import via `.gdignore`. `display/ax_battler_animations.png` is a separate derivative: only the exact flat sheet background color is made transparent; source pixels are not redrawn or recolored. Eight 96×96 cells have a shared footline at y=80: idle at atlas frame 0 from source box `(8,19,35,80)`; three distinct walk poses at frames 1–3 from `(48,15,77,80)`, `(88,16,115,80)`, `(129,18,158,80)`; sword attack frames 4–7 from `(9,97,51,168)`, `(65,96,103,168)`, `(113,104,172,168)`, `(187,112,223,168)`. The visible slash/trail is attack frame 2 / atlas frame 6; this is the provisional hit-contact frame. Idle is not part of the walk loop.

Rebuild the derived atlas without touching the existing Mystara derivatives: `python3 tools/prepare_visual_assets.py --ax-battler-only` (Pillow required). Original downloads and generated display assets are listed in [sources.json](sources.json). The hero remains a replaceable `Visual` child; scene foot origin, enemy, setting, and gameplay stay independent of this sheet.

# Temporary Mystara artwork — PRIVATE PREVIEW ONLY

Downloaded 2026-11-16 at the owner's explicit request for the first private visual build. These are existing Dungeons & Dragons: Shadow over Mystara graphics, not original Brawl & Chain art. Reuse permission from the rights holders is **unverified**; source-site availability and attribution do not establish a licence. Replace before any public demo/release. This private Git repository includes the originals and derivatives; making the repository/history public would also expose these assets.

Original game art: Capcom; Dungeons & Dragons associated rights belong to their respective holders. Retain all embedded source credits. Source pages, download URLs, contributors, dimensions and original SHA-256 hashes are in [sources.json](sources.json).

- Fighter: Sprite Database, contributed by **romab**. Temporary Barbarian visual only; no Fighter mechanics adopted.
- Goblins: The Spriters Resource, **T0misaurus**. Sheet also credits grod99 for fire sprites, unused here.
- Village of Trintan: The Spriters Resource, uploader displayed as Deleted User; embedded credit explicitly says **Ripped by Omega**.

`originals/` contains unchanged downloads, excluded from Godot import and export. `display/` contains deterministic crops, with only the exact sheet background colour made transparent. No generative redrawing or colour changes. `tools/prepare_visual_assets.py` reproduces the crops using Pillow; bounding boxes are recorded there. Character crops are trimmed, keep native proportions and are 37×78 (hero) and 65×46 (goblin). Floor and village are separate 480×224 crops from the same sheet.

Sprite2D visual children can be replaced without moving their parent foot origins. Both parents sit at y=226; transparent margins are trimmed and each sprite extends upward from its foot origin. Horizontal flipping makes the hero look right and the goblin left. Idle poses are static frames, not animation loops. No gameplay timing or hitbox is inferred from these images.

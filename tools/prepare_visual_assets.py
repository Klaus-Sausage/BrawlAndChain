#!/usr/bin/env python3
"""Reproduce private preview crops; requires Pillow. Originals remain unchanged."""
from pathlib import Path
from PIL import Image
ROOT = Path(__file__).resolve().parents[1] / 'assets/temporary_mystara'
FRAME_SIZE = 192

def keyed_crop(name, box, output, trim=False):
    source = Image.open(ROOT / 'originals' / name).convert('RGBA')
    key = source.getpixel((0, 0))[:3]
    image = source.crop(box)
    image.putdata([(r,g,b,0 if (r,g,b)==key else a) for r,g,b,a in image.getdata()])
    if trim:
        image = image.crop(image.getbbox())
    image.save(ROOT / 'display' / output)
    print(output, image.size)

def keyed_fighter_cell(source, x, y):
    """Return one keyed 192px cell, aligned to a shared center and foot line."""
    key = source.getpixel((0, 0))[:3]
    frame = source.crop((x, y, x + FRAME_SIZE, y + FRAME_SIZE)).convert('RGBA')
    frame.putdata([(r, g, b, 0 if (r, g, b) == key else a) for r, g, b, a in frame.getdata()])
    bounds = frame.getbbox()
    aligned = Image.new('RGBA', (FRAME_SIZE, FRAME_SIZE), (0, 0, 0, 0))
    if bounds:
        sprite = frame.crop(bounds)
        x_offset = (FRAME_SIZE - sprite.width) // 2
        y_offset = 160 - sprite.height
        aligned.alpha_composite(sprite, (x_offset, y_offset))
    return aligned

def fighter_animation_atlas(output):
    """Pack idle, walk, and a single lunge strike into fixed, aligned cells."""
    source = Image.open(ROOT / 'originals' / 'fighter.png').convert('RGBA')
    cells = [keyed_fighter_cell(source, 0, 448)]
    cells.extend(keyed_fighter_cell(source, index * FRAME_SIZE, 640) for index in range(12))
    cells.extend(keyed_fighter_cell(source, index * FRAME_SIZE, 1024) for index in range(9))
    cells.extend(Image.new('RGBA', (FRAME_SIZE, FRAME_SIZE), (0, 0, 0, 0)) for _ in range(2))
    atlas = Image.new('RGBA', (FRAME_SIZE * len(cells), FRAME_SIZE), (0, 0, 0, 0))
    for index, cell in enumerate(cells):
        atlas.alpha_composite(cell, (index * FRAME_SIZE, 0))
    atlas.save(ROOT / 'display' / output)
    print(output, atlas.size)

keyed_crop('fighter.png', (90,460,140,550), 'fighter_idle.png', True)
keyed_crop('goblins.png', (0,0,80,55), 'goblin_idle.png', True)
keyed_crop('trintan.png', (260,25,740,249), 'village.png')
keyed_crop('trintan.png', (1000,25,1480,249), 'floor.png')
fighter_animation_atlas('fighter_animations.png')

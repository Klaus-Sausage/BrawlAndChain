#!/usr/bin/env python3
"""Reproduce private preview crops; requires Pillow. Originals remain unchanged."""
from pathlib import Path
from PIL import Image
ROOT = Path(__file__).resolve().parents[1] / 'assets/temporary_mystara'

def keyed_crop(name, box, output, trim=False):
    source = Image.open(ROOT / 'originals' / name).convert('RGBA')
    key = source.getpixel((0, 0))[:3]
    image = source.crop(box)
    image.putdata([(r,g,b,0 if (r,g,b)==key else a) for r,g,b,a in image.getdata()])
    if trim:
        image = image.crop(image.getbbox())
    image.save(ROOT / 'display' / output)
    print(output, image.size)

keyed_crop('fighter.png', (90,460,140,550), 'fighter_idle.png', True)
keyed_crop('goblins.png', (0,0,80,55), 'goblin_idle.png', True)
keyed_crop('trintan.png', (260,25,740,249), 'village.png')
keyed_crop('trintan.png', (1000,25,1480,249), 'floor.png')

"""Prepare only the verified MAME viewer captures; never accepts the old sheet."""
import argparse, hashlib, json
from pathlib import Path
from PIL import Image, ImageDraw

FPS = 59.637405
CLIPS = {'idle': ([32,10,32,10], 0), 'walk': ([5]+[3]*12, 1), 'attack': ([1]*9+[2], -1)}
p = argparse.ArgumentParser()
p.add_argument('captures', type=Path)
p.add_argument('output', type=Path)
a = p.parse_args()
a.output.mkdir(parents=True, exist_ok=True)
frames=[]; manifest={'source':'MAME 0.264 ddsomur1 USA 960209 character viewer', 'capture_fps':FPS,'cell_size':[256,192],'origin':[128,160],'source_crop':[64,0,320,192],'source_facing':'left','equipment':{'front':0,'back':40},'permission':'unverified; private review only','clips':{}}
contact=Image.new('RGB',(13*256,3*212),'#29262f'); draw=ImageDraw.Draw(contact)
for row,(name,(ticks,loop_start)) in enumerate(CLIPS.items()):
 runs=[]
 for f in sorted(a.captures.glob(name+'-*.png')):
  im=Image.open(f).convert('RGBA').crop((64,0,320,192)); key=im.tobytes()
  if not runs or runs[-1][0]!=key:runs.append((key,im,f))
 assert len(runs)>=len(ticks),(name,len(runs))
 chosen=runs[:len(ticks)]; ids=[]; previews=[]
 for i,(_,im,f) in enumerate(chosen):
  bg=im.getpixel((0,0)); assert bg[:3]==(68,170,102),bg
  im.putdata([(0,0,0,0) if v==bg else v for v in im.getdata()])
  assert im.getbbox() and im.getbbox()[0]>0 and im.getbbox()[2]<256,(name,i,'clipping')
  ids.append(len(frames));frames.append(im)
  sample=Image.new('RGBA',(256,192),'#514c59');sample.alpha_composite(im);previews.append(sample.convert('RGB').resize((512,384),Image.Resampling.NEAREST))
  contact.paste(sample.convert('RGB'),(i*256,row*212+20));draw.text((i*256+4,row*212+3),f'{name} {i}: {ticks[i]} ticks',fill='white')
  im.save(a.output/f'{name}-{i:02d}.png')
 manifest['clips'][name]={'frames':ids,'ticks':ticks,'loop_start':loop_start,'capture_files':[f.name for _,_,f in chosen]}
 if name=='attack':manifest['clips'][name]['contact_step']=5
 start = max(loop_start, 0)
 previews[start].save(a.output/f'{name}.gif',save_all=True,append_images=previews[start+1:],duration=[max(10,round(t*1000/FPS/10)*10) for t in ticks[start:]],loop=0)
atlas=Image.new('RGBA',(256*len(frames),192))
for i,im in enumerate(frames):atlas.paste(im,(i*256,0))
atlas.save(a.output/'fighter_armed.png');contact.save(a.output/'contact-sheet.png')
manifest['atlas_sha256']=hashlib.sha256((a.output/'fighter_armed.png').read_bytes()).hexdigest()
(a.output/'animations.json').write_text(json.dumps(manifest,indent=2)+'\n')
print('Prepared',len(frames),'frames',manifest['atlas_sha256'])

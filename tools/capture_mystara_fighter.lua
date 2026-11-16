-- MAME 0.264 / ddsomur1 USA 960209. Run with all output paths outside the repo.
-- Verified against the supplied ROM; no on-disk ROM changes.
local m=manager.machine
local p=m.devices[':maincpu'].spaces.program
local op=m.devices[':maincpu'].spaces.opcodes
assert(op:read_u16(0x2905c)==0x4a79 and op:read_u32(0x2905e)==0xc0)
assert(op:read_u16(0x2906c)==0x4ef9 and op:read_u32(0x2906e)==0xecf68)
p:write_direct_u16(0xc0,1)
local output=os.getenv('BAC_CAPTURE_DIR')
assert(output, 'Set BAC_CAPTURE_DIR to an existing directory outside the repository')
local palette_path=assert(os.getenv('BAC_SHIELD_PALETTE'), 'Set BAC_SHIELD_PALETTE to the gameplay-captured palette bank')
local pf=assert(io.open(palette_path,'rb'));local palette=pf:read('*a');pf:close();assert(#palette==32)
local log=assert(io.open(output..'/frames.csv','w'))
log:write('clip,tick,screen_frame,record_next,counter,marker,x,y,z\n')
local n=0
local events={
 {420,':IN2','Service Mode'}, {550,':IN0','P1 Down'}, {560,':IN0','P1 Button 1'},
 {950,':IN0','P1 Right'}, {960,':IN0','P1 Right'},
 {1220,':IN0','P1 Down'}, {1230,':IN2','1 Player Start'},
 {1240,':IN0','P1 Right'}, {1250,':IN2','1 Player Start'}
}
local windows={{'idle',700,940},{'walk',970,1210},{'attack',1260,1500}}
emu.register_frame_done(function()
 n=n+1
 for _,e in ipairs(events) do
  if n==e[1] then m.ioport.ports[e[2]].fields[e[3]]:set_value(1) end
  if n==e[1]+2 then m.ioport.ports[e[2]].fields[e[3]]:set_value(0) end
 end
 if n>420 and p:read_u8(0xff1d56)==0 then p:write_u8(0xff1d56,1) end
 if n==540 then m.screens[':screen']:snapshot(output..'/secret-menu.png') end
 if n==650 then
  local b=0xff85de
  p:write_u8(b+0x8b,1) -- original viewer weapon renderer enabled
  p:write_u8(b+0x10d,0) -- normal sword
  p:write_u8(b+0x10e,40) -- shield
  p:write_u16(b+8,192) -- centre the original sprite origin to avoid sword clipping
  for addr=0x918000,0x91bffc,4 do p:write_u16(addr,0x1f1f);p:write_u16(addr+2,0) end
  for i=1,32,2 do p:write_u16(0x91c200+i-1,palette:byte(i)*256+palette:byte(i+1)) end
  p:write_u16(0x80410a,0x91c0)
  -- Hide the viewer's text tilemap; CPS2 object sprites are a separate layer.
  for addr=0x912000,0x913ffc,4 do p:write_u16(addr,0x20);p:write_u16(addr+2,0) end
  _G.bac_text_tap=p:install_write_tap(0x912000,0x913fff,'hide_viewer_text',function(addr,data,mask)
   if addr%4==0 then return 0x20 else return 0 end
  end)
  local ptr=p:read_u32(b+0x20)
  p:write_u32(b+0x40,p:read_u32(ptr-8));p:write_u32(b+0x44,p:read_u32(ptr-4))
 end
 for _,w in ipairs(windows) do
  if n==w[2] then m.ioport.ports[':IN0'].fields['P1 Button 1']:set_value(1) end
  if n==w[3] then m.ioport.ports[':IN0'].fields['P1 Button 1']:set_value(0);log:flush() end
  if n>=w[2] and n<w[3] then
   local b=0xff85de;local sc=m.screens[':screen']
   sc:snapshot(string.format('%s/%s-%03d.png',output,w[1],n-w[2]))
   log:write(string.format('%s,%d,%d,%x,%d,%x,%d,%d,%d\n',w[1],n-w[2],sc:frame_number(),p:read_u32(b+0x20),p:read_u16(b+0x30),p:read_u16(b+0x32),p:read_u16(b+8),p:read_u16(b+0x10),p:read_u16(b+0xc)))
  end
 end
end,'frame')

-- MAME 0.264 ddsomur1; normal-gameplay shield palette capture.
-- Use external cfg/nvram/snapshot/state/input/diff paths and a clean boot.
local m=manager.machine
local p=m.devices[':maincpu'].spaces.program
local output=assert(os.getenv('BAC_CAPTURE_DIR'), 'Set an external output directory')
local n=0
emu.register_frame_done(function()
 n=n+1
 for _,e in ipairs({{500,':IN2','Coin 1'},{1900,':IN2','1 Player Start'},{2100,':IN0','P1 Button 1'},{2400,':IN0','P1 Button 1'},{2700,':IN0','P1 Button 1'}}) do
  if n==e[1] then m.ioport.ports[e[2]].fields[e[3]]:set_value(1) end
  if n==e[1]+2 then m.ioport.ports[e[2]].fields[e[3]]:set_value(0) end
 end
 if n==3300 then
  local f=assert(io.open(output..'/shield-palette.bin','wb'))
  f:write(p:read_range(0x91c200,0x91c21f,8));f:close()
  m.screens[':screen']:snapshot(output..'/gameplay-palette-proof.png')
 end
end,'frame')

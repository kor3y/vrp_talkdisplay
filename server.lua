local Tunnel = module('vrp', 'lib/Tunnel')
local Proxy = module('vrp', 'lib/Proxy')

vRP = Proxy.getInterface('vRP')
vRPStd = Tunnel.getInterface("vrp_talkdisplay","vrp_talkdisplay")

function refresh()
  for user_id, player in pairs(vRP.getUsers({})) do 
    vRPStd.newUser(-1,{user_id,player})
  end 
end

RegisterCommand("r",function()refresh()end)
AddEventHandler("vRP:playerSpawn",function()refresh()end)
AddEventHandler("vRP:playerLeave",function(user_id)vRPStd.delUser(-1,{user_id})end)
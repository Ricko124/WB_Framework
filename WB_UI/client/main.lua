local phoneOpen=false; local dead=false
local function nui(page, show, data) SetNuiFocus(show,show); SendNUIMessage({action=show and page or 'close', data=data or {}}) end
RegisterCommand(Config.Phone.command, function() ESX.TriggerServerCallback('WB_UI:getMessages', function(msgs) phoneOpen=true; nui('phone',true,{messages=msgs}) end) end)
RegisterKeyMapping(Config.Phone.command,'Telefon öffnen','keyboard',Config.Phone.key)
RegisterNUICallback('sendMessage', function(d,cb) TriggerServerEvent('WB_UI:sendMessage',d.to,d.message); cb({ok=true}) end)
RegisterNUICallback('close', function(_,cb) SetNuiFocus(false,false); SendNUIMessage({action='close'}); cb({ok=true}) end)
AddEventHandler('esx:onPlayerDeath', function() dead=true; nui('hospital',true,{seconds=Config.Hospital.bleedoutSeconds, price=Config.Hospital.price}) end)
RegisterNUICallback('respawn', function(_,cb)
 ESX.TriggerServerCallback('WB_UI:payHospital', function(ok)
  if ok or dead then local c=Config.Hospital.respawn; DoScreenFadeOut(500); Wait(600); NetworkResurrectLocalPlayer(c.x,c.y,c.z,c.w,true,false); ClearPedBloodDamage(PlayerPedId()); TriggerEvent('esx_ambulancejob:revive'); SetEntityCoords(PlayerPedId(),c.x,c.y,c.z); DoScreenFadeIn(800); dead=false; SetNuiFocus(false,false); SendNUIMessage({action='close'}) else ESX.ShowNotification('Nicht genug Geld') end
 end); cb({ok=true})
end)
RegisterCommand('hospital', function() nui('hospital',true,{seconds=0, price=Config.Hospital.price}) end)

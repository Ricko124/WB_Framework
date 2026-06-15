local open=false; local currentGarage='legion'
local function notify(s) ESX.ShowNotification(s) end
local function setNui(show,data) open=show; SetNuiFocus(show,show); SendNUIMessage({action=show and 'open' or 'close', data=data or {}}) end
local function props(veh) return ESX.Game.GetVehicleProperties(veh) end
function OpenGarage(name)
 currentGarage=name or 'legion'; ESX.TriggerServerCallback('WB_Garages:getVehicles', function(list) setNui(true,{garage=currentGarage,vehicles=list}) end,currentGarage)
end
CreateThread(function()
 while true do local wait=1000; local ped=PlayerPedId(); local pc=GetEntityCoords(ped)
  for name,g in pairs(Config.Garages) do local d= #(pc-g.store); if d<20 then wait=0; DrawMarker(1,g.store.x,g.store.y,g.store.z-1,0,0,0,0,0,0,2.0,2.0,.5,0,120,255,120,false,true,2); if d<2 and IsControlJustReleased(0,38) then OpenGarage(name) end end end
  local i=Config.Impound; local d=#(pc-i.pos); if d<20 then wait=0; DrawMarker(1,i.pos.x,i.pos.y,i.pos.z-1,0,0,0,0,0,0,2.0,2.0,.5,255,120,0,120,false,true,2); if d<2 and IsControlJustReleased(0,38) then OpenGarage('impound') end end
  Wait(wait)
 end
end)
RegisterCommand('garage', function(_,a) OpenGarage(a[1] or 'legion') end)
RegisterCommand('storecar', function() local veh=GetVehiclePedIsIn(PlayerPedId(),false); if veh==0 then return notify('Du sitzt in keinem Fahrzeug') end; local p=props(veh); TriggerServerEvent('WB_Garages:storeVehicle',p.plate,p,currentGarage); DeleteVehicle(veh) end)
RegisterNUICallback('spawn', function(d,cb)
 local v=d.vehicle and json.decode(d.vehicle) or {}; local garage=Config.Garages[currentGarage] or Config.Garages.legion; local sp=garage.spawn
 ESX.Game.SpawnVehicle(v.model or 'adder', vector3(sp.x,sp.y,sp.z), sp.w, function(veh) ESX.Game.SetVehicleProperties(veh,v); TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1); TriggerServerEvent('WB_Garages:setStored',v.plate or d.plate,false,currentGarage) end); setNui(false); cb({ok=true})
end)
RegisterNUICallback('impound', function(d,cb)
 ESX.TriggerServerCallback('WB_Garages:payImpound', function(ok) if ok then local sp=Config.Impound.spawn; local v=json.decode(d.vehicle or '{}'); ESX.Game.SpawnVehicle(v.model or 'adder', vector3(sp.x,sp.y,sp.z), sp.w, function(veh) ESX.Game.SetVehicleProperties(veh,v); TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1) end); setNui(false) else notify('Nicht genug Geld') end end,d.plate); cb({ok=true})
end)
RegisterNUICallback('close', function(_,cb) setNui(false); cb({ok=true}) end)
RegisterNetEvent('WB_Garages:adminGiveCar', function(model) ESX.Game.SpawnVehicle(model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(veh) TaskWarpPedIntoVehicle(PlayerPedId(),veh,-1) end) end)

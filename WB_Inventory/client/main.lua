local open=false; local context={kind='player',id=''}
local function openInv(kind,id) context={kind=kind or 'player',id=id or ''}; ESX.TriggerServerCallback('WB_Inventory:getInventory', function(data) SetNuiFocus(true,true); SendNUIMessage({action='open',data=data}) end,context.kind,context.id) end
RegisterCommand('inventory', function() openInv('player','') end); RegisterKeyMapping('inventory','Inventar öffnen','keyboard',Config.OpenKey)
RegisterCommand('stash', function(_,a) openInv('stash',a[1] or 'public') end)
RegisterCommand('trunk', function() local veh=GetVehiclePedIsIn(PlayerPedId(),false); if veh==0 then veh=ESX.Game.GetClosestVehicle() end; if veh and veh~=0 then openInv('trunk',GetVehicleNumberPlateText(veh)) end end)
RegisterCommand('glovebox', function() local veh=GetVehiclePedIsIn(PlayerPedId(),false); if veh~=0 then openInv('glovebox',GetVehicleNumberPlateText(veh)) end end)
RegisterCommand('shop', function(_,a) openInv('shop',a[1] or 'twentyfourseven') end)
RegisterNUICallback('use', function(d,cb) TriggerServerEvent('WB_Inventory:useItem',d.item); cb({ok=true}) end)
RegisterNUICallback('buy', function(d,cb) TriggerServerEvent('WB_Inventory:buyItem',d.shop,d.item,d.count); cb({ok=true}) end)
RegisterNUICallback('deposit', function(d,cb) TriggerServerEvent('WB_Inventory:moveToStash',context.kind,context.id,d.item,d.count); cb({ok=true}) end)
RegisterNUICallback('withdraw', function(d,cb) TriggerServerEvent('WB_Inventory:takeFromStash',context.kind,context.id,d.item,d.count); cb({ok=true}) end)
RegisterNUICallback('close', function(_,cb) SetNuiFocus(false,false); SendNUIMessage({action='close'}); cb({ok=true}) end)

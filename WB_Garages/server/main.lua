local ESX=exports['es_extended']:getSharedObject()
local function identifier(src) local x=ESX.GetPlayerFromId(src); return x and x.identifier or tostring(src) end
ESX.RegisterServerCallback('WB_Garages:getVehicles', function(src, cb, garage)
 local rows=MySQL.query.await('SELECT plate, vehicle, garage, stored FROM wb_garage_vehicles WHERE owner=?', {identifier(src)}) or {}; cb(rows)
end)
RegisterNetEvent('WB_Garages:storeVehicle', function(plate, props, garage)
 local src=source; plate=tostring(plate or ''):upper(); if plate=='' then return end
 MySQL.insert.await('INSERT INTO wb_garage_vehicles (plate,owner,vehicle,garage,stored) VALUES (?,?,?,?,1) ON DUPLICATE KEY UPDATE vehicle=VALUES(vehicle),garage=VALUES(garage),stored=1', {plate,identifier(src),json.encode(props or {}),garage or 'legion'})
 TriggerClientEvent('esx:showNotification',src,'Fahrzeug eingeparkt')
end)
RegisterNetEvent('WB_Garages:setStored', function(plate, stored, garage)
 local src=source; MySQL.update.await('UPDATE wb_garage_vehicles SET stored=?, garage=? WHERE plate=? AND owner=?',{stored and 1 or 0, garage or 'legion', tostring(plate):upper(), identifier(src)})
end)
ESX.RegisterServerCallback('WB_Garages:payImpound', function(src, cb, plate)
 local x=ESX.GetPlayerFromId(src); local price=Config.Impound.price
 if x.getMoney()>=price then x.removeMoney(price); MySQL.update.await('UPDATE wb_garage_vehicles SET stored=0 WHERE plate=? AND owner=?',{tostring(plate):upper(),identifier(src)}); cb(true) else cb(false) end
end)
RegisterCommand('givecar', function(src,args)
 local x=ESX.GetPlayerFromId(src); if not x or (x.getGroup()~='admin' and x.getGroup()~='superadmin') then return end
 local target=tonumber(args[1] or src); local model=args[2] or 'adder'; TriggerClientEvent('WB_Garages:adminGiveCar', target, model)
end)

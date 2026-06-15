local ESX=exports['es_extended']:getSharedObject()
local function identifier(src) local x=ESX.GetPlayerFromId(src); return x and x.identifier or tostring(src) end
ESX.RegisterServerCallback('WB_UI:getMessages', function(src, cb) cb(MySQL.query.await('SELECT * FROM wb_phone_logs WHERE from_number=? OR to_number=? ORDER BY id DESC LIMIT 50',{identifier(src),identifier(src)}) or {}) end)
RegisterNetEvent('WB_UI:sendMessage', function(to,msg) local src=source; MySQL.insert.await('INSERT INTO wb_phone_logs (from_number,to_number,message) VALUES (?,?,?)',{identifier(src),tostring(to or ''),tostring(msg or '')}); TriggerClientEvent('esx:showNotification',src,'Nachricht gesendet') end)

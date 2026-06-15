local ESX=exports['es_extended']:getSharedObject()
local function allowed(src) local x=ESX.GetPlayerFromId(src); return x and Config.AllowedGroups[x.getGroup()] end
ESX.RegisterServerCallback('WB_Admin:getPlayers', function(src,cb) if not allowed(src) then cb({}) return end; local ps={}; for _,id in ipairs(GetPlayers()) do local x=ESX.GetPlayerFromId(tonumber(id)); if x then ps[#ps+1]={id=tonumber(id),name=GetPlayerName(id),identifier=x.identifier,group=x.getGroup(),job=x.job and x.job.name or 'n/a'} end end; cb(ps) end)
RegisterNetEvent('WB_Admin:kick', function(id, reason) if allowed(source) then DropPlayer(tonumber(id), reason or 'Kick') end end)
RegisterNetEvent('WB_Admin:ban', function(id, reason) local src=source; if not allowed(src) then return end; local t=tonumber(id); local ids=GetPlayerIdentifiers(t); MySQL.insert.await('INSERT INTO wb_bans (identifier,reason,banned_by) VALUES (?,?,?)',{ids[1] or tostring(t),reason or Config.DefaultBanReason,GetPlayerName(src)}); DropPlayer(t, reason or Config.DefaultBanReason) end)
RegisterNetEvent('WB_Admin:revive', function(id) if allowed(source) then TriggerClientEvent('WB_Admin:revivePlayer', tonumber(id)) end end)
RegisterNetEvent('WB_Admin:goto', function(id) if allowed(source) then TriggerClientEvent('WB_Admin:gotoPlayer', source, tonumber(id)) end end)
RegisterNetEvent('WB_Admin:bring', function(id) if allowed(source) then TriggerClientEvent('WB_Admin:bringPlayer', tonumber(id), source) end end)
AddEventHandler('playerConnecting', function(_,_,def) local src=source; local ids=GetPlayerIdentifiers(src); if #ids>0 then local ban=MySQL.single.await('SELECT * FROM wb_bans WHERE identifier=? AND active=1 LIMIT 1',{ids[1]}); if ban then def.done('Gebannt: '..(ban.reason or '')) end end end)

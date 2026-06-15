local ESX = exports['es_extended']:getSharedObject()
local function license(src)
  for _,id in ipairs(GetPlayerIdentifiers(src)) do if id:sub(1,8)=='license:' then return id end end
  return ('source:%s'):format(src)
end
local function ident(lic, slot) return ('char%s:%s'):format(slot, lic:gsub('license:','')) end

ESX.RegisterServerCallback('WB_Multichar:getCharacters', function(src, cb)
  local lic = license(src)
  local rows = MySQL.query.await('SELECT * FROM wb_characters WHERE license=? ORDER BY id ASC', {lic}) or {}
  cb({characters=rows, max=Config.MaxCharacters})
end)

RegisterNetEvent('WB_Multichar:createCharacter', function(data)
  local src=source; local lic=license(src)
  local count = MySQL.scalar.await('SELECT COUNT(*) FROM wb_characters WHERE license=?', {lic}) or 0
  if count >= Config.MaxCharacters then TriggerClientEvent('esx:showNotification',src,'Maximale Charakteranzahl erreicht'); return end
  data=data or {}; local fn=tostring(data.firstname or 'Max'):sub(1,50); local ln=tostring(data.lastname or 'Mustermann'):sub(1,50)
  local dob=tostring(data.dateofbirth or '2000-01-01'):sub(1,10); local sex=tostring(data.sex or 'm'):sub(1,10); local h=tonumber(data.height) or 180
  local id = MySQL.insert.await('INSERT INTO wb_characters (license, firstname, lastname, dateofbirth, sex, height, skin) VALUES (?,?,?,?,?,?,?)', {lic,fn,ln,dob,sex,h,json.encode(data.skin or {})})
  TriggerClientEvent('WB_Multichar:created', src, id)
end)

RegisterNetEvent('WB_Multichar:deleteCharacter', function(id)
  local src=source; local lic=license(src); id=tonumber(id)
  if id then MySQL.update.await('DELETE FROM wb_characters WHERE id=? AND license=?', {id, lic}) end
  TriggerClientEvent('WB_Multichar:refresh', src)
end)

RegisterNetEvent('WB_Multichar:selectCharacter', function(id)
  local src=source; local lic=license(src); id=tonumber(id)
  local char = id and MySQL.single.await('SELECT * FROM wb_characters WHERE id=? AND license=?', {id, lic})
  if not char then TriggerClientEvent('esx:showNotification', src, 'Charakter nicht gefunden'); return end
  local slot = 1
  local all = MySQL.query.await('SELECT id FROM wb_characters WHERE license=? ORDER BY id ASC', {lic}) or {}
  for i,r in ipairs(all) do if tonumber(r.id)==id then slot=i break end end
  MySQL.update.await('UPDATE wb_characters SET last_login=NOW(), spawned=1 WHERE id=?', {id})
  TriggerEvent('esx:onPlayerJoined', src, ident(lic, slot), char.skin and json.decode(char.skin) or {})
  TriggerClientEvent('WB_Multichar:spawnCharacter', src, char)
end)

RegisterCommand('logoutchar', function(src)
  DropPlayer(src, 'Bitte neu verbinden, um Charakter zu wechseln.')
end, false)

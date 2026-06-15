local Core = exports['WB_Core']:GetCoreObject()
local function charId(src) return exports['WB_Core']:GetCharacterId(src) end
RegisterNetEvent('WB_Identity:sv:saveCustomization', function(customData)
  local src=source; local id=charId(src); if not id then return end
  MySQL.update.await('UPDATE wb_characters SET skin=? WHERE id=?', {json.encode(customData or {}), id})
  Core.Notify(src, 'Aussehen gespeichert', 'success')
end)
RegisterNetEvent('WB_Identity:sv:getCustomization', function()
  local src=source; local id=charId(src); if not id then return end
  local row=MySQL.single.await('SELECT skin FROM wb_characters WHERE id=?', {id})
  TriggerClientEvent('WB_Identity:cl:loadCustomization', src, row and row.skin and json.decode(row.skin) or {})
end)

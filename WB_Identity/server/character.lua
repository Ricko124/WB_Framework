local Core = exports['WB_Core']:GetCoreObject()
RegisterNetEvent('WB_Identity:sv:selectCharacter', function(charData)
  local src=source; local identifier=Core.Identifier(src); local id=charData and tonumber(charData.id)
  if not identifier or not id then return end
  local char=MySQL.single.await('SELECT * FROM wb_characters WHERE id=? AND license=?', {id, identifier})
  if char then
    MySQL.update.await('UPDATE wb_characters SET last_login=NOW(), spawned=1 WHERE id=?', {id})
    TriggerClientEvent('WB_Identity:cl:loadCharacter', src, char)
    Core.Notify(src, 'Charakter geladen', 'success')
  end
end)

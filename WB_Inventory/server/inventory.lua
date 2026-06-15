-- Compatibility aliases for older WB_Inventory event names.
RegisterNetEvent('WB_Inventory:sv:getInventory', function() TriggerEvent('WB_Inventory:getInventory') end)
RegisterNetEvent('WB_Inventory:sv:useItem', function(itemId) TriggerEvent('WB_Inventory:useItem', itemId) end)
RegisterNetEvent('WB_Inventory:sv:dropItem', function(itemId, count)
  local src=source; local xPlayer=exports['WB_Core']:GetCoreObject().GetPlayer(src)
  if xPlayer and itemId then xPlayer.removeInventoryItem(itemId, tonumber(count) or 1) end
end)

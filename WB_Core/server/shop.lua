local Core = exports['WB_Core']:GetCoreObject()
local Shops = {
  general = {name='24/7 Shop', items={{id='water',label='Wasser',price=15},{id='burger',label='Burger',price=25}}},
  ammo = {name='Ammu-Nation', items={{id='ammo_pistol',label='Pistolen Munition',price=100},{id='ammo_rifle',label='Gewehr Munition',price=150}}}
}
RegisterNetEvent('wb-shop:sv:getShop', function(shopType)
  TriggerClientEvent('wb-shop:cl:loadShop', source, Shops[shopType] or Shops.general)
end)
RegisterNetEvent('wb-shop:sv:buyItem', function(itemId, count, price)
  local src=source; count=tonumber(count) or 1; price=tonumber(price) or 0
  if not itemId or count<1 then return end
  if Core.RemoveMoney(src, price*count, 'cash') then
    local xPlayer=Core.GetPlayer(src); if xPlayer then xPlayer.addInventoryItem(itemId, count) end
    Core.Notify(src, 'Kauf erfolgreich', 'success')
  else Core.Notify(src, 'Nicht genug Bargeld', 'error') end
end)

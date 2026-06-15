local Core = exports['WB_Core']:GetCoreObject()
local function bank(src) local xPlayer=Core.GetPlayer(src); local acc=xPlayer and xPlayer.getAccount('bank'); return acc and acc.money or 0 end
local function cash(src) local xPlayer=Core.GetPlayer(src); return xPlayer and xPlayer.getMoney() or 0 end
exports('GetBank', bank)
exports('Deposit', function(src, amount)
  amount=tonumber(amount); if not amount or amount<=0 then return false end
  if not Core.RemoveMoney(src, amount, 'cash') then return false end
  Core.AddMoney(src, amount, 'bank'); Core.Log('money','Einzahlung',{source=src,amount=amount}); return true
end)
exports('Withdraw', function(src, amount)
  amount=tonumber(amount); if not amount or amount<=0 then return false end
  if not Core.RemoveMoney(src, amount, 'bank') then return false end
  Core.AddMoney(src, amount, 'cash'); Core.Log('money','Auszahlung',{source=src,amount=amount}); return true
end)
RegisterNetEvent('WB_Banking:getData', function() local src=source; TriggerClientEvent('WB_Banking:setData', src, {action='open', balance=bank(src), cash=cash(src)}) end)
RegisterNetEvent('WB_Banking:deposit', function(amount) if exports['WB_Banking']:Deposit(source, amount) then Core.Notify(source,'Einzahlung erfolgreich','success') else Core.Notify(source,'Einzahlung fehlgeschlagen','error') end; TriggerEvent('WB_Banking:getData') end)
RegisterNetEvent('WB_Banking:withdraw', function(amount) if exports['WB_Banking']:Withdraw(source, amount) then Core.Notify(source,'Auszahlung erfolgreich','success') else Core.Notify(source,'Auszahlung fehlgeschlagen','error') end; TriggerEvent('WB_Banking:getData') end)
RegisterCommand(WBBanking.OpenCommand or 'bank', function(source) Core.Notify(source, 'Bank: $' .. bank(source) .. ' | Cash: $' .. cash(source)) end)

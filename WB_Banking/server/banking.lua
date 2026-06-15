-- Compatibility aliases for older WB_Banking event names.
RegisterNetEvent('WB_Banking:sv:getBalance', function() TriggerEvent('WB_Banking:getData') end)
RegisterNetEvent('WB_Banking:sv:withdraw', function(amount) TriggerEvent('WB_Banking:withdraw', amount) end)
RegisterNetEvent('WB_Banking:sv:deposit', function(amount) TriggerEvent('WB_Banking:deposit', amount) end)

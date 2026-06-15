WB = WB or { Player = {}, Callbacks = {}, RequestId = 0 }

RegisterNetEvent('WB_Core:notify', function(msg, type)
  if ESX and ESX.ShowNotification then ESX.ShowNotification(msg) else print('[WB Notify]', type or 'info', msg) end
end)

RegisterNetEvent('WB_Core:client:ready', function(data) WB.Player = data or {} end)
RegisterNetEvent('WB_Core:callbackResult', function(requestId, result)
  if WB.Callbacks[requestId] then WB.Callbacks[requestId](result); WB.Callbacks[requestId] = nil end
end)

function WB.TriggerCallback(name, cb, ...)
  WB.RequestId = WB.RequestId + 1
  WB.Callbacks[WB.RequestId] = cb
  TriggerServerEvent('WB_Core:triggerCallback', name, WB.RequestId, ...)
end

CreateThread(function() Wait(1500); TriggerServerEvent('WB_Core:server:ready') end)
exports('GetPlayerData', function() return WB.Player end)
exports('TriggerCallback', function(name, cb, ...) WB.TriggerCallback(name, cb, ...) end)

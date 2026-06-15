local open = false
local function toggle(state)
  open = state
  SetNuiFocus(open, open)
  SendNUIMessage({action = open and 'open' or 'close'})
  if open then TriggerServerEvent('WB_Banking:getData') end
end
RegisterCommand(WBBanking.OpenCommand or 'bank', function() toggle(true) end)
RegisterNUICallback('close', function(_, cb) toggle(false); cb(true) end)
RegisterNUICallback('deposit', function(data, cb) TriggerServerEvent('WB_Banking:deposit', tonumber(data.amount)); cb(true) end)
RegisterNUICallback('withdraw', function(data, cb) TriggerServerEvent('WB_Banking:withdraw', tonumber(data.amount)); cb(true) end)
RegisterNetEvent('WB_Banking:setData', function(data) SendNUIMessage(data or {}) end)

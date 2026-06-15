RegisterNetEvent('WB_UI:server:log', function(message)
  TriggerEvent('WB_Discord:log', 'ui', tostring(message or ''), {source = source})
end)

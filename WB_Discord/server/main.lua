local function send(webhook, title, msg)
  if not webhook or webhook == '' then return end
  PerformHttpRequest(webhook, function() end, 'POST', json.encode({
    username = 'WB_Scripts',
    embeds = {{ title = title, description = msg, color = 3447003 }}
  }), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('WB_Discord:log', function(category, message, data)
  local webhook = WBDiscord.Webhooks[category] or WBDiscord.Webhooks.default
  local extra = data and ('\n```json\n' .. json.encode(data) .. '\n```') or ''
  send(webhook, category, tostring(message) .. extra)
end)

exports('Log', function(category, message, data)
  TriggerEvent('WB_Discord:log', category, message, data)
end)

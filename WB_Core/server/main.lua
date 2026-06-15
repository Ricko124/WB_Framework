local ESX = exports['es_extended']:getSharedObject()
local Core = {Callbacks = {}}

local function safeJson(data) return data and json.encode(data) or nil end
local function isAdmin(xPlayer)
  if not xPlayer then return false end
  local group = xPlayer.getGroup and xPlayer.getGroup() or 'user'
  for _, g in ipairs(WBConfig.AdminGroups or {}) do if group == g then return true end end
  return false
end

function Core.GetESX() return ESX end
function Core.GetPlayer(source) return ESX.GetPlayerFromId(source) end
function Core.IsAdmin(source) return isAdmin(Core.GetPlayer(source)) end
function Core.Identifier(source)
  local xPlayer = Core.GetPlayer(source)
  return xPlayer and xPlayer.identifier or nil
end
function Core.Notify(source, msg, type)
  TriggerClientEvent('WB_Core:notify', source, tostring(msg or ''), type or 'info')
end
function Core.AddMoney(source, amount, account)
  local xPlayer = Core.GetPlayer(source); amount = tonumber(amount)
  if not xPlayer or not amount or amount <= 0 then return false end
  if account and account ~= 'money' and account ~= 'cash' then xPlayer.addAccountMoney(account, amount) else xPlayer.addMoney(amount) end
  return true
end
function Core.RemoveMoney(source, amount, account)
  local xPlayer = Core.GetPlayer(source); amount = tonumber(amount)
  if not xPlayer or not amount or amount <= 0 then return false end
  if account and account ~= 'money' and account ~= 'cash' then
    local acc = xPlayer.getAccount(account); if not acc or acc.money < amount then return false end
    xPlayer.removeAccountMoney(account, amount)
  else
    if xPlayer.getMoney() < amount then return false end
    xPlayer.removeMoney(amount)
  end
  return true
end
function Core.GetJob(source)
  local xPlayer = Core.GetPlayer(source); return xPlayer and xPlayer.job or nil
end
function Core.SetJob(source, job, grade)
  local xPlayer = Core.GetPlayer(source); if not xPlayer then return false end
  xPlayer.setJob(job, tonumber(grade) or 0); return true
end
function Core.Log(category, message, data)
  if MySQL then MySQL.insert('INSERT INTO wb_logs (category, message, data) VALUES (?, ?, ?)', {category or 'system', tostring(message or ''), safeJson(data)}) end
  TriggerEvent('WB_Discord:log', category or 'system', tostring(message or ''), data)
end
function Core.RegisterCallback(name, cb) Core.Callbacks[name] = cb end

exports('GetCoreObject', function() return Core end)
_G.WBCore = Core

RegisterNetEvent('WB_Core:triggerCallback', function(name, requestId, ...)
  local src = source
  local cb = Core.Callbacks[name]
  if not cb then
    TriggerClientEvent('WB_Core:callbackResult', src, requestId, nil)
    return
  end
  cb(src, function(result) TriggerClientEvent('WB_Core:callbackResult', src, requestId, result) end, ...)
end)

RegisterNetEvent('WB_Core:server:ready', function()
  local src = source
  TriggerClientEvent('WB_Core:client:ready', src, { identifier = Core.Identifier(src), job = Core.GetJob(src) })
end)

RegisterNetEvent('WB_Core:sv:getCharacterId', function()
  local src = source
  local identifier = Core.Identifier(src)
  if not identifier then return nil end
  local row = MySQL.single.await('SELECT id FROM wb_characters WHERE license = ? ORDER BY last_login DESC, id DESC LIMIT 1', {identifier})
  return row and row.id or nil
end)

exports('GetCharacterId', function(src)
  local identifier = Core.Identifier(src); if not identifier then return nil end
  local row = MySQL.single.await('SELECT id FROM wb_characters WHERE license = ? ORDER BY last_login DESC, id DESC LIMIT 1', {identifier})
  return row and row.id or nil
end)

RegisterCommand('wbdebug', function(source)
  if source ~= 0 and not Core.IsAdmin(source) then return end
  print('[WB] Core läuft. ESX=' .. tostring(ESX ~= nil))
end)

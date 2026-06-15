local Core = exports['WB_Core']:GetCoreObject()
local function getJobs()
  return MySQL.query.await('SELECT id, label, description, type FROM wb_jobs ORDER BY label ASC') or {}
end
exports('GetJobs', getJobs)
RegisterNetEvent('WB_Jobs:getJobs', function() local src=source; TriggerClientEvent('WB_Jobs:setJobs', src, getJobs(), Core.GetJob(src)) end)
RegisterNetEvent('WB_Jobs:setJob', function(job, grade)
  local src=source; if not job then return end
  if Core.SetJob(src, job, tonumber(grade) or 0) then Core.Notify(src, 'Job gesetzt: '..job, 'success'); Core.Log('jobs','Job gesetzt',{source=src,job=job,grade=grade}) end
end)
RegisterCommand('setjobwb', function(source,args) if source~=0 and not Core.IsAdmin(source) then return end; local target=tonumber(args[1]); if target then Core.SetJob(target,args[2] or 'unemployed', tonumber(args[3]) or 0) end end)

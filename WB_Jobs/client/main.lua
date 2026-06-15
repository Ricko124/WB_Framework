local open=false
local function toggle(state)
  open=state; SetNuiFocus(open, open); SendNUIMessage({action=open and 'open' or 'close'})
  if open then TriggerServerEvent('WB_Jobs:getJobs') end
end
RegisterCommand(WBJobs.OpenCommand or 'jobcenter', function() toggle(true) end)
RegisterNUICallback('close', function(_, cb) toggle(false); cb(true) end)
RegisterNUICallback('setJob', function(data, cb) TriggerServerEvent('WB_Jobs:setJob', data.job, data.grade or 0); cb(true) end)
RegisterNetEvent('WB_Jobs:setJobs', function(jobs, current) SendNUIMessage({action='open',jobs=jobs or {},job=current}) end)

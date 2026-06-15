-- Compatibility aliases for older WB_Jobs event names.
RegisterNetEvent('WB_Jobs:sv:getJobs', function() TriggerEvent('WB_Jobs:getJobs') end)
RegisterNetEvent('WB_Jobs:sv:joinJob', function(jobId) TriggerEvent('WB_Jobs:setJob', jobId, 0) end)
RegisterNetEvent('WB_Jobs:sv:leaveJob', function() TriggerEvent('WB_Jobs:setJob', 'unemployed', 0) end)

local ESX=exports['es_extended']:getSharedObject()
ESX.RegisterServerCallback('WB_UI:payHospital', function(src, cb) local x=ESX.GetPlayerFromId(src); local p=Config.Hospital.price; if x.getAccount and x.getAccount('bank').money>=p then x.removeAccountMoney('bank',p); cb(true) elseif x.getMoney()>=p then x.removeMoney(p); cb(true) else cb(false) end end)

local ESX=exports['es_extended']:getSharedObject()
local function inv(x) local items={}; for _,it in pairs(x.getInventory() or {}) do if (it.count or 0)>0 then items[#items+1]={name=it.name,label=it.label,count=it.count,weight=it.weight or 0} end end; return items end
ESX.RegisterServerCallback('WB_Inventory:getInventory', function(src, cb, kind, id)
 local x=ESX.GetPlayerFromId(src); local data={player=inv(x), other={}, kind=kind, id=id}
 if kind=='stash' then data.other=MySQL.query.await('SELECT item as name,item as label,count FROM wb_stashes WHERE stash=?',{id or 'public'}) or {}
 elseif kind=='shop' then data.shop=Config.Shops[id or 'twentyfourseven'] or Config.Shops.twentyfourseven
 elseif kind=='trunk' or kind=='glovebox' then local stash=(kind..':'..tostring(id or 'unknown')); data.other=MySQL.query.await('SELECT item as name,item as label,count FROM wb_stashes WHERE stash=?',{stash}) or {} end
 cb(data)
end)
RegisterNetEvent('WB_Inventory:useItem', function(item) local x=ESX.GetPlayerFromId(source); if x then x.useItem(item) end end)
RegisterNetEvent('WB_Inventory:buyItem', function(shop,item,count)
 local src=source; local x=ESX.GetPlayerFromId(src); count=tonumber(count) or 1; local cfg=Config.Shops[shop or 'twentyfourseven']; if not cfg then return end
 for _,i in ipairs(cfg.items) do if i.item==item then local price=i.price*count; if x.getMoney()>=price then x.removeMoney(price); x.addInventoryItem(item,count); TriggerClientEvent('esx:showNotification',src,'Gekauft: '..count..'x '..(i.label or item)) else TriggerClientEvent('esx:showNotification',src,'Nicht genug Geld') end end end
end)
local function addStash(stash,item,count) MySQL.insert.await('INSERT INTO wb_stashes (stash,item,count) VALUES (?,?,?) ON DUPLICATE KEY UPDATE count=count+VALUES(count)',{stash,item,count}) end
RegisterNetEvent('WB_Inventory:moveToStash', function(kind,id,item,count) local src=source; local x=ESX.GetPlayerFromId(src); count=tonumber(count) or 1; local have=x.getInventoryItem(item); if have and have.count>=count then x.removeInventoryItem(item,count); addStash((kind or 'stash')..':'..tostring(id or 'public'),item,count) end end)
RegisterNetEvent('WB_Inventory:takeFromStash', function(kind,id,item,count) local src=source; local x=ESX.GetPlayerFromId(src); count=tonumber(count) or 1; local stash=(kind or 'stash')..':'..tostring(id or 'public'); local row=MySQL.single.await('SELECT count FROM wb_stashes WHERE stash=? AND item=?',{stash,item}); if row and row.count>=count then MySQL.update.await('UPDATE wb_stashes SET count=count-? WHERE stash=? AND item=?',{count,stash,item}); x.addInventoryItem(item,count) end end)

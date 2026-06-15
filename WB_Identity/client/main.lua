local currentChar=nil; local currentSkin={}
RegisterNetEvent('WB_Identity:characterLoaded', function(char) currentChar=char end)
RegisterNetEvent('skinchanger:modelLoaded', function() if currentSkin then TriggerEvent('skinchanger:loadSkin', currentSkin) end end)
RegisterCommand('identity', function()
  if not currentChar then return ESX.ShowNotification('Kein Charakter geladen') end
  SetNuiFocus(true,true); SendNUIMessage({action='openIdentity', data=currentChar})
end)
RegisterCommand('skinmenu', function()
  if not currentChar then return ESX.ShowNotification('Kein Charakter geladen') end
  TriggerEvent('esx_skin:openSaveableMenu', function(skin)
    currentSkin=skin; TriggerServerEvent('WB_Identity:saveSkin', currentChar.id, skin)
  end, function() end)
end)
RegisterNUICallback('saveIdentity', function(d,cb) TriggerServerEvent('WB_Identity:saveIdentity', d); SetNuiFocus(false,false); cb({ok=true}) end)
RegisterNUICallback('close', function(_,cb) SetNuiFocus(false,false); SendNUIMessage({action='close'}); cb({ok=true}) end)

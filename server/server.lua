ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Sotek:pay')
AddEventHandler('Sotek:pay',function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeMoney(20)
end)
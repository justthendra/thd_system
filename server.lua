ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('thdsystem:shareDisplay')
AddEventHandler('thdsystem:shareDisplay', function(text,name, message)
    TriggerClientEvent('thdsystem:triggerDisplay', -1, text, source)
end)
RegisterServerEvent('thdsystem:chat')
AddEventHandler('thdsystem:chat', function(text,name, message)
    TriggerClientEvent('thdsystem:chatyaz', -1, text, source)
end)


 ESX.RegisterServerCallback('jeux:sex', function(playerId, data) -- super
    local Identifier = ESX.GetPlayerFromId(playerId).identifier

    MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

        data(result[1].firstname, result[1].lastname)
    end)
end)
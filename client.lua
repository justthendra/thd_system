ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)
Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/system', 'Duyuru yaparsınız')
end)

local nbrDisplaying = 1

RegisterCommand('system', function(source, args, raw)
    local text = string.sub(raw, 7)
    TriggerServerEvent('thdsystem:shareDisplay', text)
    ESX.TriggerServerCallback('jeux:sex', function(firstname,lastname)
        text = '<b style="color: white;">SYSTEM: </b>' .. text 
        TriggerServerEvent('thdsystem:chat',text)
    end)
end)

RegisterNetEvent('thdsystem:triggerDisplay')
AddEventHandler('thdsystem:triggerDisplay', function(text, source)
    local offset = 1 + (nbrDisplaying*0.22)
    Display(GetPlayerFromServerId(source), text, offset)
end)
RegisterNetEvent('thdsystem:chatyaz')
AddEventHandler('thdsystem:chatyaz', function(text, source)
    chat(GetPlayerFromServerId(source), text)
end)
function Display(mePlayer, text, offset)
    local displaying = true
    Citizen.CreateThread(function()
        Wait(8000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        nbrDisplaying = nbrDisplaying + 1

        while displaying do
            Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 500 then
                 DrawText3D(coordsMe['x'], coordsMe['y'], coordsMe['z']+offset-1.250, text)
            end
        end
        nbrDisplaying = nbrDisplaying - 1
    end)
end
function chat(mePlayer, text)
    local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
    local coords = GetEntityCoords(PlayerPedId(), false)
    local jeux = Vdist2(coordsMe, coords)

    if jeux < 505 then

        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message success" style="background-color: rgb(255, 0, 0, 0.6);">' .. text .. '</div>',
            multiline = true,
            args = { text}
        })
 
    end
end
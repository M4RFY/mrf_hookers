local QBCore = exports['qb-core']:GetCoreObject()
local interactTick = 0
local interactCheck = false
local interactText = nil
local time = 1000

function loadModel(model) 
	if not HasModelLoaded(model) then
		if Config.Debug then 
			print("^5Debug^7: ^2Loading Model^7: '^6"..model.."^7'") 
		end
		while not HasModelLoaded(model) do
			if time > 0 then 
				time -= 1 
				RequestModel(model)
			else 
				time = 1000 
				print("^5Debug^7: ^3LoadModel^7: ^2Timed out loading model ^7'^6"..model.."^7'") break
			end
			Wait(10)
		end
	end 
end

function unloadModel(model) 
	if Config.Debug then 
		print("^5Debug^7: ^2Removing Model^7: '^6"..model.."^7'") 
	end 
	SetModelAsNoLongerNeeded(model)
	DeleteEntity(model)
end


function PedFlee(ped)
    SetPedFleeAttributes(ped, 0, 0)
    TaskReactAndFleePed(ped, PlayerPedId())
end

-- Loads Animation Dict
function loadAnimDict(dict)	
	if not HasAnimDictLoaded(dict) then 
		if Config.Debug then 
			print("^5Debug^7: ^2Loading Anim Dictionary^7: '^6"..dict.."^7'") 
		end 
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict) 
			Wait(5) 
		end
	end 
end

-- Unloads Animation Dict
function unloadAnimDict(dict) 
	if Config.Debug then 
		print("^5Debug^7: ^2Removing Anim Dictionary^7: '^6"..dict.."^7'") 
	end
	RemoveAnimDict(dict) 
end

-- Animation on Hooker
function hookerAnim(Hooker, animDictionary, animationName, time)
    if (DoesEntityExist(Hooker) and not IsEntityDead(Hooker)) then
        loadAnimDict(animDictionary)
        TaskPlayAnim(Hooker, animDictionary, animationName, 1.0, -1.0, -1, 1, 1, true, true, true)
    end
end

-- Animation on player
function playerAnim(ped, animDictionary, animationName, time)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        loadAnimDict(animDictionary)
        TaskPlayAnim(ped, animDictionary, animationName, 1.0, -1.0, -1, 1, 1, true, true, true)
    end
end

-- Disables Control
function DisableControls()
    DisableAllControlActions(0)
    EnableControlAction(0, 1, true)
    EnableControlAction(0, 2, true)
    EnableControlAction(0, 245, true)
    EnableControlAction(0, 38, true)
    EnableControlAction(0, 0, true)
    EnableControlAction(0, 322, true)
    EnableControlAction(0, 288, true)
    EnableControlAction(0, 213, true)
    EnableControlAction(0, 249, true)
    EnableControlAction(0, 20, true)
    EnableControlAction(0, 46, true)
    EnableControlAction(0, 47, true)
    EnableControlAction(0, 200, true)
    EnableControlAction(0, 303, true)
end

-- Create Hooker, Setwaypoint and Blip
function CreateHooker(model, spawn)
    loadModel(model)
    loadAnimDict("switch@michael@parkbench_smoke_ranger")

    Hooker = CreatePed("PED_TYPE_PROSTITUTE", model, Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z, Config.Hookerspawns[spawn].w, true, true)
    FreezeEntityPosition(Hooker, true)
    SetEntityInvincible(Hooker, true)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskStartScenarioInPlace(Hooker, "WORLD_HUMAN_SMOKING", 0, false)

    HookerBlip = AddBlipForCoord(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z)
    SetBlipSprite(HookerBlip, 280)
    SetNewWaypoint(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y)
	return Hooker
end

-- ox_lib Show Text UI
function InteractText(text)
    local timer = GetGameTimer()
    interactTick = timer
    if interactText == nil or interactText ~= text then 
        interactText = text
        lib.showTextUI(text)
    end
    if interactCheck then return end
    interactCheck = true
    CreateThread(function()
        Wait(150)
        local timer = GetGameTimer()
        interactCheck = false
        if timer ~= interactTick then 
            lib.hideTextUI()
            interactText = nil
            interactTick = 0
        end
    end)
end

-- Look to the pimp
function lookEnt(entity)
	if type(entity) == "vector3" then
		if not IsPedHeadingTowardsPosition(PlayerPedId(), entity, 10.0) then
			TaskTurnPedToFaceCoord(PlayerPedId(), entity, 1500)
			if Config.Debug then print("^5Debug^7: ^3lookEnt^7(): ^2Turning Player to^7: '^6"..json.encode(entity).."^7'") end
			Wait(1500)
		end
	else
		if DoesEntityExist(entity) then
			if not IsPedHeadingTowardsPosition(PlayerPedId(), GetEntityCoords(entity), 30.0) then
				TaskTurnPedToFaceCoord(PlayerPedId(), GetEntityCoords(entity), 1500)
				if Config.Debug then print("^5Debug^7: ^3lookEnt^7(): ^2Turning Player to^7: '^6"..entity.."^7'") end
				Wait(1500)
			end
		end
	end
end

-- Send Hooker Home
function hookerGoHome(Hooker, vehicle)
    TaskLeaveVehicle(Hooker, vehicle, 0)
    PedFlee(Hooker)
    Wait(10000)
    unloadModel(Hooker)
    HookerSpawned = false
end

-- Signal Hooker to Enter Vehicle 
function signalHooker(Hooker)
    local ped = PlayerPedId()
    FreezeEntityPosition(Hooker, false)
    SetEntityInvincible(Hooker, false)
    SetEntityAsMissionEntity(Hooker)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskEnterVehicle(Hooker, GetVehiclePedIsIn(ped, false), -1, 0, 1.0, 1, 0)
end

-- Triggers Notification
function triggerNotify(title, message, type, src)
	if Config.Notify == "okok" then
		if not src then	exports['okokNotify']:Alert(title, message, 6000, type or 'info')
		else TriggerClientEvent('okokNotify:Alert', src, title, message, 6000, type or 'info') end
	elseif Config.Notify == "qb" then
		if not src then	TriggerEvent("QBCore:Notify", message, "primary")
		else TriggerClientEvent("QBCore:Notify", src, message, "primary") end
	end
end
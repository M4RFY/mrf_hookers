local interactTick = 0
local interactCheck = false
local interactText = nil
local time = 1000

function loadModel(model)
	if not HasModelLoaded(model) then
		while not HasModelLoaded(model) do
			if time > 0 then
				time -= 1
				RequestModel(model)
			else
				time = 1000
				break
			end
			Wait(10)
		end
	end
end

function unloadModel(model)
	SetModelAsNoLongerNeeded(model)
	DeleteEntity(model)
end

function PedFlee(ped)
    SetPedFleeAttributes(ped, 0, 0)
    TaskReactAndFleePed(ped, cache.ped)
end

function loadAnimDict(dict)
	if not HasAnimDictLoaded(dict) then
		while not HasAnimDictLoaded(dict) do
			RequestAnimDict(dict)
			Wait(5)
		end
	end
end

function unloadAnimDict(dict)
	RemoveAnimDict(dict)
end

function hookerAnim(Hooker, animDictionary, animationName)
    if (DoesEntityExist(Hooker) and not IsEntityDead(Hooker)) then
        loadAnimDict(animDictionary)
        TaskPlayAnim(Hooker, animDictionary, animationName, 1.0, -1.0, -1, 1, 1, true, true, true)
    end
end

function playerAnim(ped, animDictionary, animationName)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
        loadAnimDict(animDictionary)
        TaskPlayAnim(ped, animDictionary, animationName, 1.0, -1.0, -1, 1, 1, true, true, true)
    end
end

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

function CreateHooker(model, spawn)
    loadModel(model)
    loadAnimDict('switch@michael@parkbench_smoke_ranger')

    Hooker = CreatePed('PED_TYPE_PROSTITUTE', model, Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z, Config.Hookerspawns[spawn].w, true, true)
    FreezeEntityPosition(Hooker, true)
    SetEntityInvincible(Hooker, true)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskStartScenarioInPlace(Hooker, 'WORLD_HUMAN_SMOKING', 0, false)

    HookerBlip = AddBlipForCoord(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z)
    SetBlipSprite(HookerBlip, 280)
    SetNewWaypoint(Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y)
	return Hooker
end

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

function hookerGoHome(Hooker, vehicle)
    TaskLeaveVehicle(Hooker, vehicle, 0)
    PedFlee(Hooker)
    Wait(10000)
    unloadModel(Hooker)
    HookerSpawned = false
end

function signalHooker(Hooker)
    FreezeEntityPosition(Hooker, false)
    SetEntityInvincible(Hooker, false)
    SetEntityAsMissionEntity(Hooker)
    SetBlockingOfNonTemporaryEvents(Hooker, true)
    TaskEnterVehicle(Hooker, GetVehiclePedIsIn(cache.ped, false), -1, 0, 1.0, 1, 0)
end

function Notify(message, type, src)
	if Config.Notify == 'qb' then
		if not src then
            TriggerEvent('QBCore:Notify', message, type)
		else
            TriggerClientEvent('QBCore:Notify', src, message, type)
        end
    elseif Config.Notify == 'ox' then
		if not src then
            lib.notify({ description = message, type = type})
        else
            lib.notify(src, { description = message, type = type})
        end
	end
end
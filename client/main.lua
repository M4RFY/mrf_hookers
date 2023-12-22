local Targets = {}
local HookerSpawned = false
local OnRouteToHooker = false
local HookerInCar = false

-- NUI EVENTS
RegisterNetEvent("mrf_hookers:OpenPimpMenu", function()
    SetNuiFocus(true, true)
    lookEnt(pimp)
    Wait(100)
    SendNUIMessage({
        type = "openPimpMenu",
    })
end)

RegisterNetEvent("mrf_hookers:OpenHookerMenu", function()
    SetNuiFocus(true, true)
    Wait(100)
    SendNUIMessage({
        type    = "openHookerMenu",
        blowjob = Config.BlowJobPrice,
        sex     = Config.SexPrice,
    })
end)

-- NUI CALLBACKS
RegisterNUICallback("CloseMenu", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

RegisterNUICallback("ChooseMolly", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    if HookerSpawned then
        triggerNotify('You have already choose a hooker!', 'error')
    else
        TriggerEvent("mrf_hookers:ChooseHooker", "csb_stripper_01")
        triggerNotify('Molly Is Marked On Your GPS, Go & Fuck Her!', 'success')
    end
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseLiza", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    if HookerSpawned then
        triggerNotify('You have already choose a hooker!', 'error')
    else
        TriggerEvent("mrf_hookers:ChooseHooker", "csb_stripper_02")
        triggerNotify('Liza Is Marked On Your GPS, Go & Fuck Her!', 'success')
    end
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseJessica", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    if HookerSpawned then
        triggerNotify('You have already choose a hooker!', 'error')
    else
        TriggerEvent("mrf_hookers:ChooseHooker", "s_f_y_stripper_01")
        triggerNotify('Jessica Is Marked On Your GPS, Go & Fuck Her!', 'success')
    end
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseKara", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    if HookerSpawned then
        triggerNotify('You have already choose a hooker!', 'error')
    else
        TriggerEvent("mrf_hookers:ChooseHooker", "s_f_y_stripper_02")
        triggerNotify('Kara Is Marked On Your GPS, Go & Fuck Her!', 'success')
    end
    OnRouteToHooker = true
end)

RegisterNUICallback("ChooseBlowjob", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    HookerInCar = false
    TriggerServerEvent("mrf_hookers:startBlowjob")
    if Config.Dispatch.Enable then
        if math.random(1, 100) >= 10 then
            exports[Config.Dispatch.Resource]:SuspiciousActivity()
        end
    end
end)

RegisterNUICallback("ChooseSex", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    HookerInCar = false
    TriggerServerEvent("mrf_hookers:startSex")
    if Config.Dispatch.Enable then
        if math.random(1, 100) >= 10 then
            exports[Config.Dispatch.Resource]:SuspiciousActivity()
        end
    end
end)

RegisterNUICallback("CloseServiceMenu", function(data, cb)
    SetNuiFocus(false, false)
    cb("ok")
    HookerInCar = true
end)

-- No Money 
RegisterNetEvent("mrf_hookers:noMoney", function()
    HookerInCar = true
end)

CreateThread(function()
    for _,v in pairs(Config.PimpGuy) do
        loadModel("s_m_m_bouncer_01")
        pimp =  CreatePed(1, v.model, v.coords.x, v.coords.y, v.coords.z, v.coords.w, false, true)
        SetEntityAsMissionEntity(pimp)
        SetPedFleeAttributes(pimp, 0, 0)
        SetBlockingOfNonTemporaryEvents(pimp, true)
        SetEntityInvincible(pimp, true)
        FreezeEntityPosition(pimp, true)
        loadAnimDict("mini@strip_club@idles@bouncer@base")
        TaskPlayAnim(pimp, "mini@strip_club@idles@bouncer@base", "base", 8.0, 1.0, -1, 01, 0, 0, 0, 0)
        Targets["pimpguy"] =
        exports[Config.Target]:AddTargetEntity(pimp, {
            options = {
                {
                    type = "client",
                    event = "mrf_hookers:OpenPimpMenu",
                	icon = "fa-solid fa-money-bill",
                	label = "Talk to Pimp",
                },
            },
            distance = 2.0,
        })
    end
end)

-- Thread after ordered hooker 
RegisterNetEvent("mrf_hookers:ChooseHooker", function(model)
    HookerSpawned = true
    spawn = math.random(1, 12)
    CreateHooker(model, spawn)
    CreateThread(function()
        while true do
            Wait(5)
            local ped = cache.ped
            local vehicle = cache.vehicle
            local Coords, letSleep  = GetEntityCoords(ped), true
                if OnRouteToHooker then
                    if GetDistanceBetweenCoords(Coords, Config.Hookerspawns[spawn].x, Config.Hookerspawns[spawn].y, Config.Hookerspawns[spawn].z, true) < 5 then
                        letSleep = false
                        if GetPedInVehicleSeat(vehicle, -1) and IsPedInVehicle(ped, vehicle, true) and IsVehicleSeatFree(vehicle, 0) and not IsVehicleSeatFree(vehicle, -1) then
                            InteractText('[E] To Signal Hooker')
                            if IsControlJustPressed(0, 38) then
                                TriggerEvent('animations:client:EmoteCommandStart', {"whistle"})
                                RemoveBlip(HookerBlip)
                                signalHooker(Hooker)
                                PlayAmbientSpeech1(Hooker, "Generic_Hows_It_Going", "Speech_Params_Force")
                                HookerInCar = true
                                OnRouteToHooker = false
                                if Config.Dispatch.Enable then
                                    if math.random(1, 100) >= 10 then
                                        exports[Config.Dispatch.Resource]:SuspiciousActivity()
                                    end
                                end
                            end
                        end
                    end
                end
                if HookerInCar then
                    if GetPedInVehicleSeat(vehicle, -1) and IsPedInVehicle(ped, vehicle, true) and not IsVehicleSeatFree(vehicle, 0) and not IsVehicleSeatFree(vehicle, -1) then
                        letSleep = false
                        if IsVehicleStopped(vehicle) then
                            InteractText('[E] To Open Services | [H] Tell Hooker To Leave')
                            if IsControlJustPressed(0, 38) then
                                PlayAmbientSpeech1(Hooker, "Hooker_Offer_Service", "Speech_Params_Force_Shouted_Clear")
                                TriggerEvent("mrf_hookers:OpenHookerMenu")
                            end
                            if IsControlJustPressed(0, 74) then
                                HookerInCar = false
                                PlayAmbientSpeech1(Hooker, "Hooker_Had_Enough", "Speech_Params_Force_Shouted_Clear")
                                hookerGoHome(Hooker, vehicle)
                            end
                        else
                            InteractText('Drive to a safe spot')
                        end
                    end
                end
                if IsPedDeadOrDying(Hooker) or IsPedDeadOrDying(ped) then
                    HookerSpawned = false
                    if OnRouteToHooker then
                        RemoveBlip(HookerBlip)
                    end
                    OnRouteToHooker = false
                    HookerInCar = false
                    Wait(5000)
                    PedFlee(Hooker)
                    Wait(10000)
                    unloadModel(Hooker)
                end
            if letSleep then
                Wait(1000)
            end
        end
    end)
end)

RegisterNetEvent("mrf_hookers:startBlowjobAnim", function()
    local ped = cache.ped
    local vehicle = cache.vehicle
    hookerAnim(Hooker, "oddjobs@towing", "f_blow_job_loop")
    playerAnim(ped, "oddjobs@towing", "m_blow_job_loop")
    DisableControls()
    SetVehicleEngineOn(vehicle, false, false, true)
    Wait(2000)
    PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Sex_Oral", "Speech_Params_Force_Shouted_Clear")
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Sex_Oral_Fem", "Speech_Params_Force_Shouted_Clear")
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Sex_Oral_Fem", "Speech_Params_Force_Shouted_Clear")
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Sex_Finished", "Speech_Params_Force_Shouted_Clear")
    ClearPedTasks(ped)
    ClearPedTasks(Hooker)
    EnableAllControlActions(0)
    Wait(5000)
    PlayAmbientSpeech1(Hooker, "Hooker_Offer_Again", "Speech_Params_Force_Shouted_Clear")
    HookerInCar = true
end)

-- Sex Animation and Speech
RegisterNetEvent("mrf_hookers:startSexAnim", function()
    local ped = cache.ped
    hookerAnim(Hooker, "mini@prostitutes@sexlow_veh", "low_car_sex_loop_female")
    playerAnim(ped, "mini@prostitutes@sexlow_veh", "low_car_sex_loop_player")

    local speechArray = {
        "Sex_Generic",
        "Sex_Generic",
        "Sex_Generic",
        "Sex_Generic_Fem",
        "Sex_Generic_Fem",
        "Sex_Finished",
        "Hooker_Offer_Again"
    }

    for i=1, #speechArray do
        local speech = speechArray[i]
        local speechParam = "Speech_Params_Force_Normal_Clear"
        if i >= 4 then
            speechParam = "Speech_Params_Force_Shouted_Clear"
        end

        PlayAmbientSpeech1(Hooker, speech, speechParam)
        Wait(5000)
    end

    HookerInCar = true
    ClearPedTasks(ped)
    ClearPedTasks(Hooker)
end)

AddEventHandler('onResourceStop', function(r)
    if r ~= GetCurrentResourceName() then
        return
    end
	for k in pairs(Targets) do
        exports[Config.Target]:RemoveZone(k)
    end
    unloadModel(Hooker)
end)
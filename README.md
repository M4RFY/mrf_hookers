# Mrf_Hookers
* Compatible with QBCore Framework
* Preview [https://youtu.be/XhoWGgdGgrk](https://youtu.be/XhoWGgdGgrk).

# Dependencies
* [ps-dispatch](https://github.com/Project-Sloth/ps-dispatch)
* [ox_lib](https://github.com/overextended/ox_lib)

# Add to ps-dispatch

* Add to ps-dispatch/client/cl_events.lua

```
local function SuspiciousActivity2(vehicle)
    local vehdata = vehicleData(vehicle)
    local currentPos = GetEntityCoords(PlayerPedId())
    local locationInfo = getStreetandZone(currentPos)
    local heading = getCardinalDirectionFromHeading()
    TriggerServerEvent("dispatch:server:notify", {
        dispatchcodename = "susactivity2", -- has to match the codes in sv_dispatchcodes.lua so that it generates the right blip
        dispatchCode = "10-66",
        firstStreet = locationInfo,
        model = vehdata.name, -- vehicle name
        plate = vehdata.plate, -- vehicle plate
        priority = 2,
        firstColor = vehdata.colour, -- vehicle color
        heading = heading,
        automaticGunfire = false,
        origin = {
            x = currentPos.x,
            y = currentPos.y,
            z = currentPos.z
        },
        dispatchMessage = _U('susactivity2'),
        job = { "police" }
    })
end

exports('SuspiciousActivity2', SuspiciousActivity2)
```
* Add to ps-dispatch/server/sv_dispatchcodes.lua

```
["susactivity2"] =  {displayCode = '10-66', description = "Solicitation", radius = 0, recipientList = {'police'}, blipSprite = 279, blipColour = 48, blipScale = 1.0, blipLength = 0.75, sound = "Lose_1st", sound2 = "GTAO_FM_Events_Soundset", offset = "false", blipflash = "false"},
```
* Add to ps-dispatch/locales/locales.lua

```
['susactivity2'] = "Solicitation in Progress",
```

# Original
* [sawu_hookers](https://github.com/stianhje/sawu_hookers)

# Credit
* [GLDNRMZ](https://github.com/GLDNRMZ)
* [AnishBplayz](https://github.com/AnishBplayz)

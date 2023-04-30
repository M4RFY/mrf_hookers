local QBCore = exports['qb-core']:GetCoreObject()

local function RelieveStress(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    local Stress = Player.PlayerData.metadata['stress']
    if not Stress then
        Player.PlayerData.metadata['stress'] = 0
        Stress = Player.PlayerData.metadata['stress']
    end

    if Stress - amount < 0 then
        Stress = 0
    else
        Stress = Player.PlayerData.metadata['stress'] - amount
    end

    Player.Functions.SetMetaData('stress', Stress)
    TriggerClientEvent('hud:client:UpdateStress', src, Stress)
    triggerNotify(src, 'You feel more relaxed', 4500, 'success')
end

RegisterServerEvent('mrf_hookers:startBlowjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Cash = Player.PlayerData.money.cash
    local Price = Config.BlowjobPrice

    if Cash >= Price then
        Player.Functions.RemoveMoney('cash', Price)
        TriggerClientEvent('mrf_hookers:startBlowjobAnim', source)
        RelieveStress(src, math.random(50, 100))
    else
        triggerNotify(src, 'Hooker', 'You do not have enough money', 'error')
        TriggerClientEvent('mrf_hookers:noMoney', src)
    end
end)

RegisterServerEvent('mrf_hookers:startSex', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Cash = Player.PlayerData.money.cash
    local Price = Config.SexPrice

    if Cash >= Price then
        Player.Functions.RemoveMoney('cash', Price)
        TriggerClientEvent('mrf_hookers:startSexAnim', source)
        RelieveStress(src, math.random(50, 100))
    else
        triggerNotify(src, 'Hooker', 'You do not have enough money', 'error')
        TriggerClientEvent('mrf_hookers:noMoney', src)
    end
end)

print("^2Hooker Script by ^1MARFY^7")
local QBCore = exports[Config.Core]:GetCoreObject()

local function RelieveStress(src, amount)
    local Player = QBCore.Functions.GetPlayer(src)
    local Stress = Player.PlayerData.metadata.stress
    if not Stress then
        Player.PlayerData.metadata.stress = 0
        Stress = Player.PlayerData.metadata.stress
    end

    if Stress - amount < 0 then
        Stress = 0
    else
        Stress = Player.PlayerData.metadata.stress - amount
    end

    Player.Functions.SetMetaData('stress', Stress)
    TriggerClientEvent('hud:client:UpdateStress', src, Stress)
    Notify('You feel more relaxed', 'success', src)
end

RegisterServerEvent('mrf_hookers:server:startBlowjob', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Bank = Player.PlayerData.money.bank
    local Price = Config.BlowJobPrice

    if Bank >= Price then
        Player.Functions.RemoveMoney('bank', Price)
        TriggerClientEvent('mrf_hookers:client:startBlowjobAnim', src)
        RelieveStress(src, 30)
    else
        TriggerClientEvent('mrf_hookers:client:noMoney', src)
        Notify('You do not have enough money', 'error', src)
    end
end)

RegisterServerEvent('mrf_hookers:server:startSex', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Bank = Player.PlayerData.money.bank
    local Price = Config.SexPrice

    if Bank >= Price then
        Player.Functions.RemoveMoney('bank', Price)
        TriggerClientEvent('mrf_hookers:client:startSexAnim', src)
        RelieveStress(src, 50)
    else
        TriggerClientEvent('mrf_hookers:client:noMoney', src)
        Notify('You do not have enough money', 'error', src)
    end
end)

print('^3Hookers^7 - ^1Made by^7 ^4MARFY^7')
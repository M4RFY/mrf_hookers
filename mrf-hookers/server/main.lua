--ESX = nil
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local QBCore = exports['qb-core']:GetCoreObject()
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

-------------------------------------------------------------------------------
-- Get Money / Remove money
-------------------------------------------------------------------------------
RegisterServerEvent('mrf-hookers:pay')
AddEventHandler('mrf-hookers:pay', function(boolean)
--    local _source   = source
--    local xPlayer   = ESX.GetPlayerFromId(_source)
--    local xPlayers  = ESX.GetPlayers()
    local src       = source
    local Player    = QBCore.Functions.GetPlayer(src)
    local check     = Player.PlayerData.money.cash

    if (boolean == true) then
--        if xPlayer.getMoney() >= Config.BlowjobPrice then
        if check >= Config.BlowjobPrice then
--            xPlayer.removeMoney(Config.BlowjobPrice)
            Player.Functions.RemoveMoney('cash', Config.BlowjobPrice)
            TriggerClientEvent('mrf-hookers:startBlowjob', src)
--            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You payed: ' .. Config.BlowjobPrice ..' $' })
            --QBCore.Functions.Notify('You Paid', 'success')
            TriggerClientEvent('QBCore:Notify', src, 'You Paid!', 'success')
            -- this adds money to society_nightclub
--            if Config.SocietyNightclub then
--                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
--                   account.addMoney(Config.BlowjobPrice)
--                end)
--            end
        else
--            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You do not have enough money' })
            --QBCore.Functions.Notify('You do not have enough money', 'error')
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
            TriggerClientEvent('mrf-hookers:noMoney', src)
        end  
    else
--        if xPlayer.getMoney() >= Config.SexPrice then
        if check >= Config.SexPrice then
--            xPlayer.removeMoney(Config.SexPrice)
            Player.Functions.RemoveMoney('cash', Config.SexPrice)
            TriggerClientEvent('mrf-hookers:startSex', src)
--            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You payed: ' .. Config.SexPrice ..' $' })
            --QBCore.Functions.Notify('You Paid', 'success')
            TriggerClientEvent('QBCore:Notify', src, 'You Paid!', 'success')
            -- this adds money to society_nightclub
--            if Config.SocietyNightclub then
--                TriggerEvent('esx_addonaccount:getSharedAccount', 'society_nightclub', function(account)
--                    account.addMoney(Config.SexPrice)
--                end)
--            end
        else
--            TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You do not have enough money' })
            --QBCore.Functions.Notify('You do not have enough money', 'error')
            TriggerClientEvent('QBCore:Notify', src, 'You do not have enough money', 'error')
            TriggerClientEvent('mrf-hookers:noMoney', src)
        end 
    end
end)


print('Developed By Marfy')
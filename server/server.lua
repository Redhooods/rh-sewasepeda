local QBCore = exports['qb-core']:GetCoreObject()
local SewaAktif = false

RegisterNetEvent('rh:server:validasi', function (args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local money = Player.Functions.GetMoney("cash")
    local bikeData = args.vehicle

    if SewaAktif then
        TriggerClientEvent('okokNotify:Alert', src, "SYSTEM", "" .. Config.Locales['check_sepeda'], 5000, 'error')
    else
        SewaAktif = true
        TriggerClientEvent('rh:client:ambilSepeda', src, bikeData)
        TriggerClientEvent('okokNotify:Alert', src, "SYSTEM", "" .. Config.Locales['info'] , 5000, 'success')
        for k, v in pairs(Config.dataSepeda) do
            if money >= args.description then
                Player.Functions.RemoveMoney("cash", args.description)
                
                break
            end
        end

        if money < args.description then
            TriggerClientEvent('okokNotify:Alert', src, "SYSTEM", "" .. Config.Locales['uang_tidak_cukup'], 5000, 'error')
        end
        Wait(Config.JedaWaktu)
        SewaAktif = false
    end
end)

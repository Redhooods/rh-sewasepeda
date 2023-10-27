local QBCore = exports['qb-core']:GetCoreObject()



CreateThread (function ()
    
    local data = Config.PedLocation
    local model = data.ped

    lib.requestModel(model, timeout)
    lib.requestAnimDict('mini@strip_club@idles@bouncer@base', 10)
    ped = CreatePed(4, model,data.coords.x,data.coords.y,data.coords.z - 1.0, data.heading, false, true)
    SetEntityHeading(ped, data.heading)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                type = "client",
                event = 'rh:client:pilihSepeda',
                icon = "fa-solid fa-bicycle",
                label = "Sewa Sepeda",
            }
        },
        distance = 2.0
    })
    PedSpawner =  true
end)


RegisterNetEvent('rh:client:pilihSepeda', function()
  local options = {}
  for k, v in pairs(Config.dataSepeda) do
    options[#options + 1] = {
      title = v.namaSepeda,
      description = v.labelHarga,
      image = v.img,
      serverEvent = "rh:server:validasi",
      args = {
        vehicle = v.namaSepeda,
        description = v.harga,
      }
    }
  end
  lib.registerContext({
    id = 'some_menu',
    title = '',
    options = options
  })
  lib.showContext('some_menu')
end)



RegisterNetEvent('rh:client:ambilSepeda', function(bikedata)
  local vehicle = bikedata
  print(vehicle)
  local player = PlayerPedId()
  local coords = QBCore.Functions.GetCoords(PlayerPedId())
  QBCore.Functions.SpawnVehicle(vehicle, function(veh)
    SetEntityHeading(veh, 50.29)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
    SetVehicleEngineOn(veh, true, true)
  end, Config.sepedaLokasi, true)
end)

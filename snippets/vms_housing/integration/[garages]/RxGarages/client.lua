if Config.Garages ~= 'RxGarages' then
    return
end

local function GetVehicleType(vehicle)
    if IsThisModelABoat(GetEntityModel(vehicle)) then
        return 'boat'
    elseif IsThisModelAHeli(GetEntityModel(vehicle)) or IsThisModelAPlane(GetEntityModel(vehicle)) then
        return 'air'
    else
        return 'car'
    end
end

function OpenGarage(propertyId, propertyData)
    local myPed = PlayerPedId()
    local myVehicle = GetVehiclePedIsIn(myPed, false)
    local isInVehicle = myVehicle and myVehicle ~= 0 and GetPedInVehicleSeat(myVehicle, -1) == myPed
    if isInVehicle then
        local vehicleType = GetVehicleType(myVehicle)
        exports['RxGarages']:ParkVehicle('property_' .. propertyId, 'garage', vehicleType)
        DeleteVehicle(myVehicle)
    else
        local myCoords = GetEntityCoords(myPed)
        exports['RxGarages']:OpenGarage('property_' .. propertyId, 'garage', 'car', myCoords)
    end
end

-- -- Hide garage blip when entering property zone
-- AddEventHandler('vms_housing:cl:enteredPropertyZone', function(propertyId, propertyData)
--     Citizen.Wait(1000) -- Wait a bit for blips to load
--     for i = 1, 1000 do
--         local blip = i
--         if DoesBlipExist(blip) then
--             local label = GetLabelText(GetBlipInfoIdLabel(blip))
--             if label == ('property_' .. propertyId) then
--                 SetBlipAsShortRange(blip, true)
--                 SetBlipAlpha(blip, 0)
--                 break
--             end
--         end
--     end
-- end)
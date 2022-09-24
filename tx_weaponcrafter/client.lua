ESX = nil 

local display = false 

local isComponent = false 

Citizen.CreateThread(function()
    while ESX == nil do 
        Citizen.Wait(0)
        TriggerEvent("esx:getSharedObject", function(obj) 
            ESX = obj
        end)
    end
end)


Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        DrawMarker(1, naim.marker.x, naim.marker.y, naim.marker.z -1, 0, 0, 0, 0, 0, 0, 1.1, 1.1, 1.1, 225, 137, 0, 145, false, true, 2, false, nil, nil, false)

        if GetDistanceBetweenCoords(pedCoords, naim.marker, true) <= 0.75 then 
            ESX.ShowHelpNotification(naim.text)
            if IsControlJustPressed(0, 38) then 
                SetDisplay(not display)
                open()
            end
        end
    end
        
end)


function open()
    SendNUIMessage({action = "open"})
end

RegisterNUICallback("show", function(data)
    for i=1, #naim.weapons, 1 do 
        addWeapons(naim.weapons[i].name, naim.weapons[i].weapon)
    end

end)

function addWeapons(wepname, weapon)
    SendNUIMessage({
        action = "wep",
        name = wepname ,
        weapon = weapon
    })
end 

RegisterNUICallback("addWeapon", function(data, cb) 

    TriggerServerEvent("naim:giveWeapon", data.weapon)

end)

RegisterNUICallback("addSilencer", function(data, cb)

    TriggerServerEvent("naim:addSilencer", data.weaponname)

end)

RegisterNUICallback("addVisor", function(data, cb)

    local weaponHash = GetHashKey(data.wep)

    if DoesWeaponTakeWeaponComponent(weaponHash, naim.hash[1].hashKey) then 

        for k,v in pairs(naim.hash) do 
            TriggerServerEvent("naim:addVisor", data.wep)
        end
     
    else 
        print("nein")
    end


end)


RegisterNUICallback("close", function(data)
    SetDisplay(false) 
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        
        for k, v in pairs(naim.farming) do 
            if GetDistanceBetweenCoords(pedCoords, v.coords, true) <= 5.0 then 
                ESX.ShowHelpNotification(naim.text) 
                if IsControlJustPressed(0, 38) then 
                    animation()
                    Wait(2500)
                    TriggerServerEvent("naim:farming") 
                    ClearPedTasksImmediately(ped)
                end 
            end
        end         

    end
    
end)


function animation()
    local ped = PlayerPedId()
    local lib, anim = "anim@mp_snowball", "pickup_snowball"

    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(ped, lib, anim, 8.0, -8.0, 6000, 0, 0, false, false, false)
    end)
end



function SetDisplay(bool)
    display = bool 
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool
    })
end



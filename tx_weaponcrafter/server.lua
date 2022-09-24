ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) 
    ESX = obj
end)


RegisterNetEvent("naim:giveWeapon")
AddEventHandler("naim:giveWeapon", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('eisen').count 
    weapon = tostring(weapon)
    if xPlayer.hasWeapon(weapon) then 
        print("du hast diese waffe")
        TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU BESITZT DIESE WAFFE !")
    else 
        if item >= 250 then 
            xPlayer.addWeapon(weapon, 0)
            
            xPlayer.removeInventoryItem('eisen', 250)

            TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST " .. weapon .. " GEKAUFT")
        else 
        
            TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST NICHT GENUG EISEN !")
 
        end
    end
end)


RegisterNetEvent("naim:addSilencer")
AddEventHandler("naim:addSilencer", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount('black_money').money 

    if money >= 5000 then 
        if xPlayer.hasWeapon(weapon) then 
            if xPlayer.hasWeaponComponent(weapon, 'suppressor') then 
                TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST DIESEN AUFSATZ  !")
            else 
                xPlayer.addWeaponComponent(weapon, 'suppressor') 
                xPlayer.removeAccountMoney('black_money', 5000)
            end
        else 
            TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST DIESE WAFFE NICHT !") 
        end 
    else 
        TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST NICHT GENUG GELD !") 
    end 

end)


RegisterNetEvent("naim:addVisor")
AddEventHandler("naim:addVisor", function(weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    local money = xPlayer.getAccount('black_money').money 

    if money >= 5000 then 
        if xPlayer.hasWeapon(weapon) then 
            if xPlayer.hasWeaponComponent(weapon, 'scope') then 
                
                TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST DIESEN AUFSATZ  !")
            else 
                xPlayer.addWeaponComponent(weapon, 'scope') 
                xPlayer.removeAccountMoney('black_money', 5000)
            end
        else 
            TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST DIESE WAFFE NICHT !") 
        end 
    else 
        TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU HAST NICHT GENUG GELD !") 
    end 
end)


RegisterNetEvent("naim:farming")
AddEventHandler("naim:farming", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(naim.item).count 

    if item < naim.maxCarry then 
        xPlayer.addInventoryItem(naim.item, naim.giveItem)
        print("JA")
    else
        TriggerClientEvent("tunex:Notify", source, "INFORMATION", "DU KANNST NICHTS MEHR TRAGEN!")
    end
end)
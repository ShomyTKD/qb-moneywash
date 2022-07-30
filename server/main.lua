local QBCore = exports['qb-core']:GetCoreObject()

local ItemList = {
    ["markedbag"] = "markedbag"
}

RegisterServerEvent('qb-moneywash:server:getmoney')
AddEventHandler('qb-moneywash:server:getmoney', function()
    local src = source
	local total_worth = 0
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local markedbag = Player.Functions.GetItemByName('markedbag')
	for itemkey, item in pairs(Player.PlayerData.items) do
		if type(item.info) ~= 'string' and tonumber(item.info.worth) then
			total_worth = total_worth + tonumber(item.info.worth)
            if Player.PlayerData.items ~= nil then
                if markedbag ~= nil then
                    if markedbag.amount >= 1 then
                        Player.Functions.RemoveItem("markedbag", 1, false)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbag'], "remove")
            
                        Player.Functions.AddMoney("cash", total_worth, 'money-washed')
                        TriggerClientEvent('QBCore:Notify', src, "You washed $"..total_worth.." of marked money!")             
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have any marked bills.", 'error')     
                    end              
                else
                    TriggerClientEvent('QBCore:Notify', src, "You don't have any marked bills.", 'error')               
                end
            end
	    end
    end
end)

RegisterServerEvent('qb-moneywash:server:checkmoney')
AddEventHandler('qb-moneywash:server:checkmoney', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedbag = Player.Functions.GetItemByName('markedbag')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if markedbag ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "markedbag" and Player.PlayerData.items[k].amount >= 1 then 
                        local amount = Player.PlayerData.items[k].amount
					    TriggerClientEvent("qb-moneywash:client:WashProggress", src)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You don't have any marked bills.", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You don't have any marked bills.", 'error')
                break
            end
        end
    end
end)

QBCore.Commands.Add('putinbag', 'Put marked cash in a bag', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local markedcash = Player.Functions.GetItemByName('markedcash')
    local emptybag = Player.Functions.GetItemByName('emptybag')
    local markedbag = Player.Functions.GetItemByName('markedbag')
    local amount = 0

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do
            if emptybag == nil then 
                TriggerClientEvent('QBCore:Notify', src, "You don't have an empty bag.", 'error')
                break 
            end
            if markedcash ~= nil then
                if Player.PlayerData.items[k].name == 'markedcash' then
                    amount = amount + Player.PlayerData.items[k].amount
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You don't have marked money.", 'error')
                break
            end
        end
    end
    if amount > 0 then
        local info = {
            worth = amount * 25
        }
        Player.Functions.RemoveItem('markedcash', amount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedcash'], "remove", amount)
        Player.Functions.RemoveItem('emptybag', 1, false)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['emptybag'], "remove")
        Player.Functions.AddItem('markedbag', 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['markedbag'], "add")
    end
end)
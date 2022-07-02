ESX = nil
PlayerData = {}
local soygunSure = os.time()

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('kagan-itemver')
AddEventHandler('kagan-itemver', function(itemreward, count)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    xPlayer.addInventoryItem(itemreward, count)
end)

RegisterServerEvent('kagan:kapiyiac')
AddEventHandler('kagan:kapiyiac', function(bankid)
    for _, bank in pairs(Config.Banks) do
        if bank.id == bankid then
            TriggerClientEvent('banking:CloseBank', -1, bank.id)
            bank.cdoor.open = true
            bank.cdoor.opentime = os.time(t)
            bank.cashierlr = os.time(t) + Config.CounterCooldowns.Between
            bank.cashlock = true
        end
    end
    TriggerClientEvent('lsrp-banks:sendBanking', -1, Config.Banks)
end)



ESX.RegisterServerCallback('kagan:policeCount', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end
  print(CopsConnected)
	cb(CopsConnected)
end)

ESX.RegisterServerCallback('ss:itemal', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local quantity = xPlayer.getInventoryItem(item).count
	if quantity >= 1 then
        xPlayer.removeInventoryItem("lockpick2", 1)
	end
    
    cb(quantity)
end)
RegisterServerEvent('ss:soygunBasladi')
AddEventHandler('ss:soygunBasladi', function()
  soygunSure = os.time() 
end)


ESX.RegisterServerCallback('ss:SoygunYapiliyormu', function(source, cb)
    cb(os.time() - soygunSure)
end)


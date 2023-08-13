ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback("lab-HUD:getData", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local data = {bank = xPlayer.getAccount('bank').money, job = xPlayer.job.label, grade = xPlayer.job.grade_label}
	cb(data)
end)
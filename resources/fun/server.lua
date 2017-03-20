function airCars(thePlayer, commandName)
	if exports.global:isPlayerScripter(thePlayer) then
	triggerClientEvent("airCars", thePlayer)
	end
end
addCommandHandler("fly", airCars)

function airCarPlayer(thePlayer, commandName, targetPlayer)
	if exports.global:isPlayerScripter(thePlayer) then
		if not (targetPlayer) then
			outputChatBox("SYNTAX: /" .. commandName .. " [id]", thePlayer, 255, 194, 14)
		else
		local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, targetPlayer)
		triggerClientEvent("airCars", targetPlayer)
		outputChatBox("Set.", thePlayer, 0, 255, 0)
		end
	end
end
addCommandHandler("flyplayer", airCarPlayer)
		
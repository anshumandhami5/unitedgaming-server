supercar = { [541]=true, [451]=true, [429]=true, [506]=true, [477]=true, [411]=true, [415]=true }
mysql = exports.mysql
lowClassArea = { "Ganton", "Willowfield", "Corona", "Idlewood" }

function sendDeletionRequest(thePlayer, theCommand)
	if (exports['global']:isPlayerFullAdmin(thePlayer)) then
		if not getPedOccupiedVehicle(thePlayer) then
			outputChatBox("You're not in a vehicle.", thePlayer, 255, 0, 0)
		else
			local targetVehicle = getPedOccupiedVehicle(thePlayer)
			if (getElementData(targetVehicle, "faction") > 0) or (getElementData(targetVehicle, "owner") == -1) then
				outputChatBox("This vehicle can not be deleted.", thePlayer, 255, 0, 0)
			else
				local model = getElementModel(targetVehicle)
				local vehicleID = getElementData(targetVehicle, "dbid")
				local carName = getVehicleNameFromModel(model)
				local adminID = getElementData(thePlayer, "account:id")
				local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
				local adminTitle = exports.global:getPlayerAdminTitle(thePlayer)
				local adminUsername = getElementData(thePlayer, "account:username")
				if not supercar[model] then
					outputChatBox("Hey! This " .. carName .. " is not a supercar!", thePlayer)
				elseif supercar[model] then
					local x, y, z = getElementPosition(thePlayer)
					local location = getZoneName(x, y, z)
					local lowClass = false
					for k, v in ipairs(lowClassArea) do
						if v == location then
							lowClass = true
							break
						end
					end
					if not lowClass then
						outputChatBox("This is not a lowclass area.", thePlayer, 255, 0, 0)
					end
					if lowClass then
						local parkX, parkY, parkZ, parkRX, parkRY, parkRZ = unpack(getElementData(targetVehicle, "respawnposition"))
						local parkLocation = getZoneName(parkX, parkY, parkZ)
						local parkedHere = false
						for k, v in ipairs(lowClassArea) do
							if v == parkLocation then
								parkedHere = true
								break
							end
						end
						if not parkedHere then
							outputChatBox("This vehicle is not parked here. Vehicle has been respawned.", thePlayer)
							removePedFromVehicle(thePlayer)
							setElementPosition(targetVehicle, parkX, parkY, parkZ)
							setVehicleRotation(targetVehicle, parkRX, parkRY, parkRZ)
							setElementInterior(targetVehicle, getElementData(targetVehicle, "interior"))
							setElementDimension(targetVehicle, getElementData(targetVehicle, "dimension"))			
						end
						if parkedHere then
							local plustext = ("Vehicle deleted by " .. getPlayerName(thePlayer):gsub("_"," ") .. " because it was parked at " .. location .. ".")
							local result1 = mysql:query("SELECT `note` FROM `vehicles` WHERE `id`='" .. vehicleID .."'")
							local note = " "
							if result1 then
								note = tostring(mysql:fetch_assoc(result1)["note"])
								mysql:free_result(result1)
							end
							mysql:query_free("UPDATE `vehicles` SET `note`='" ..plustext:gsub("'","''").. "\r\n \r\n" ..note:gsub("'","''").."' WHERE `id`=" ..vehicleID)
							mysql:query_free("UPDATE `vehicles` SET `deleted`='"..tostring(adminID).."' WHERE `id`='" .. mysql:escape_string(vehicleID) .. "'")
							destroyElement(targetVehicle)
							exports["vehicle-manager"]:addVehicleLogs(vehicleID, "deleted supercar", thePlayer)
							exports['vehicle-system']:reloadVehicle(tonumber(vehicleID))
							if hiddenAdmin == 0 then
								exports.global:sendMessageToAdmins("[VEHICLE]: "..adminTitle.." ".. getPlayerName(thePlayer):gsub("_", " ").. " ("..adminUsername..") has deleted a " .. carName .. " (ID: #" .. vehicleID .. ") for being parked at " .. location ..".")
							else
								exports.global:sendMessageToAdmins("[VEHICLE]: A hidden admin has deleted a " .. carName .. " (ID: #" .. vehicleID .. ") for being parked at " .. location ..".")
							end
							outputChatBox("Vehicle has been deleted for being parked at " ..location..".", thePlayer, 0, 255, 0)
							outputChatBox("If you would like to undo this, please type: /restoreveh " ..vehicleID.. ".", thePlayer, 0, 255, 0)
						end
					end
				end
			end
		end
	end
end
addCommandHandler("delsupercar", sendDeletionRequest)

--[[function goBack(thePlayer, theCommand)
	if not iAmRespawned then
		outputChatBox("Your location was not changed.", thePlayer, 255, 0, 0)
	end
	if iAmRespawned then
		iAmRespawned = false
		setElementPosition(thePlayer, lX, lY, lZ)
		setElementInterior(thePlayer, 0)
		setElementDimension(thePlayer, 0)
		outputChatBox("Welcome back to your old location.", thePlayer, 0, 255, 0)
	end
end
addCommandHandler("goback", goBack)
]]
function getMyLocation(thePlayer, theCommand)
	if (exports.global:isPlayerScripter(thePlayer)) then
		local x, y, z = getElementPosition(thePlayer)
		local location = getZoneName(x, y, z)
		outputChatBox(location, thePlayer)
		local lowClass = false
		for key, value in ipairs(lowClassArea) do
			if value == location then
				lowClass = true
				break
			end
		end
		if lowClass then
			outputChatBox("Exists in table!", thePlayer)
		end
		if not lowClass then
			outputChatBox("Does not exist in table!", thePlayer)
		end
	end
end
addCommandHandler("getloc", getMyLocation)

unchoppable = { [511]=true, [548]=true, [512]=true, [593]=true, [519]=true, [460]=true, [417]=true, [487]=true, [553]=true, [488]=true, [497]=true, [563]=true, [476]=true, [469]=true, [513]=true, [568]=true, [424]=true, [504]=true, [508]=true, [495]=true, [434]=true, [494]=true, [503]=true, [502]=true, [541]=true, [451]=true, [429]=true, [506]=true, [477]=true, [411]=true, [415]=true, [485]=true, [431]=true, [438]=true, [437]=true, [574]=true, [420]=true, [427]=true, [523]=true, [599]=true, [596]=true, [567]=true, [598]=true, [601]=true, [628]=true, [407]=true, [544]=true, [416]=true }
mysql = exports.mysql

choppingList = {}
choppingCarID = {}

function sendChopRequest(thePlayer, theCommand)
	local logged = getElementData(thePlayer, "loggedin")
	local playerID = getElementData(thePlayer, "playerid")
	local targetVehicle = getPedOccupiedVehicle(thePlayer)
	local vehicleID = getElementData(targetVehicle, "dbid")
	local chopstatus = getElementData(thePlayer, "chopstatus")
	local model = getElementModel(targetVehicle)
	local actualCarName = getVehicleNameFromModel(model)
	if (logged==1) then
		if not isPedInVehicle(thePlayer) then
			outputChatBox("You're not in a vehicle!", thePlayer, 255, 0, 0)
		else
			if not chopstatus or chopstatus == "false" then
				if not unchoppable[model] and exports['carshop-system']:isForSale(model) then
					choppingList[thePlayer] = targetVehicle --Save the vehicle Element to be chopped in a list.
					choppingCarID[thePlayer] = vehicleID -- Save the vehicle ID
					outputChatBox("Your chopping request has been sent to any online vehicle team members, please standby. ", thePlayer, 0, 255, 0)
					outputChatBox("If you'd like to cancel your request, use /cancelchop.", thePlayer, 255, 255, 0)		
					setElementData(thePlayer, "chopstatus", "true")
					triggerClientEvent("addOneToChopCount", thePlayer)					
					for key, value in ipairs(exports.global:getAdmins()) do
						local adminduty = getElementData(value, "adminduty")
						if adminduty == 1 then
							outputChatBox("[VEH-CHOP] " .. getPlayerName(thePlayer):gsub("_", " ") .. " (" ..tostring(playerID)..") has requested to chop vehicle ID " ..tostring(vehicleID).. " (" ..actualCarName.. ").", value, 250, 217, 5)
							outputChatBox("[VEH-CHOP] Use /chopa [playerID] to accept the request, or /chopd [playerID] to deny it.", value, 250, 217, 5)
						end
					end
				else
					outputChatBox("This vehicle is not choppable!", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("You already have a pending request.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("chopcar", sendChopRequest)

function acceptChopRequest(thePlayer, theCommand, targetPlayerName)
	if exports.global:isPlayerSuperAdmin(thePlayer) then
		if not (targetPlayerName) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [playerID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
			local logged = getElementData(targetPlayer, "loggedin")
			local playerID = getElementData(targetPlayer, "playerid")
			local theVehicle = exports.pool:getElement("vehicle", targetVehicle)
			local chopstatus = getElementData(targetPlayer, "chopstatus")
			if not targetPlayer == choppingList[targetPlayer] then
				outputChatBox("Wrong ID?", value, 255, 0, 0)
				return false
			end
			local carPrice = false
			carType = choppingList[targetPlayer]
			carPrice = exports['carshop-system']:getVehiclePrice(choppingList[targetPlayer]) -- Find out what 30% value of the car is.
			carID = choppingCarID[targetPlayer]
			outputDebugString("[VEH-CHOP] Vehicle Price: "..carPrice) --Test if it successfully take the car from the choppingList
			outputDebugString("[VEH-CHOP] Vehicle ID: "..carID) -- Check what choppingList[targetPlayer]) actually is.
	local query = mysql:query("SELECT `model` FROM `vehicles` WHERE id ='" .. mysql:escape_string(carID) .. "'")
			local model = false
			if query then
						model  = mysql:fetch_assoc(query)["model"]
						mysql:free_result(query) -- Free RAM Memory
					else
						outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 72 / Database Error!")
						return false
					end
			if not model then
					outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 76 / Vehicle has no ID!")
					return false
			end
	outputDebugString("[VEH-CHOP] Vehicle Model: "..model)
	carName = getVehicleNameFromModel(model)
	outputDebugString("[VEH-CHOP] Vehicle Name: "..carName)
	local query2 = mysql:query("SELECT `owner` FROM `vehicles` WHERE id ='" .. mysql:escape_string(carID) .. "'")
			local owner = false
			if query2 then
						owner  = mysql:fetch_assoc(query2)["owner"]
						mysql:free_result(query2) -- Free RAM Memory
					else
						outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 85 / Database Error!")
						return false
					end
			if not owner then
					outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 89 / Vehicle has no ownert!")
					return false
			end
	outputDebugString("[VEH-CHOP] Vehicle Owner DBID: "..owner)
	local query3 = mysql:query("SELECT `charactername` FROM `characters` WHERE id ='" .. owner .. "'")
			local actualOwner = false
			if query3 then
						actualOwner  = mysql:fetch_assoc(query3)["charactername"]
						mysql:free_result(query3) -- Free RAM Memory
					else
						outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 98 / Database Error!")
						return false
					end
			if not actualOwner then
					outputDebugString("[CHOP SYSTEM] / s_chopcar.lua / line 102 / Vehicle has no ID!")
					return false
			end
	outputDebugString("[VEH-CHOP] Vehicle Owner Name: "..actualOwner)
			if unchoppable[model] then
				outputChatBox("This vehicle can not be chopped!", thePlayer, 255, 0, 0)
			end
				if (chopstatus == "true") and (logged==1) then
				triggerClientEvent("subtractOneFromChopCount", targetPlayer)
				-- Calculate the vehicle price
					--local VehicleName = getVehicleNameFromModel(tonumber(model))
					--local originalVehPrice = exports['carshop-system']:getPriceFromModel(VehicleName)
					setElementData(thePlayer, "chopstatus", "false")
					--outputDebugString(originalVehPrice)
					--local calculatePrice1 = tonumber(originalVehPrice) * 29
					--local choppedPrice = tonumber(calculatePrice1) / 100
					--local actualChoppedPrice = choppedPrice
					--outputDebugString(actualChoppedPrice)
					
					-- Make the forum thread before actually getting rid of the vehicle, so the previous owner name is printed or before money is given.
					-- This way, the player won't receive anything before we confirm everything is working.
					local realTime = getRealTime()
					date = string.format("%04d/%02d/%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
					time = string.format("%02d:%02d", realTime.hour, realTime.minute )
					local forumTitle = exports.mysql:escape_string("[VEH-CHOP] " ..carName.. " - " ..targetPlayerName)
					local firstID = exports.mysql:forum_query_insert_free("insert into post set threadid = '9999', parentid = '0', username = 'Chuevo', userid = '2', title = '" .. forumTitle .. "', dateline = unix_timestamp(), pagetext = '[B]Vehicle ID & Name:[/B] " ..carID.. " (" ..carName.. ")<br>[B]Date: [/B]" ..date.. "<br>[B]Time: [/B]" ..time.. "<br>[B]Vehicle Owner: [/B]" .. actualOwner:gsub("_", " ") .. "<br>[B]Chopped by: [/B]" .. getPlayerName(targetPlayer):gsub("_", " ") .. "<br>[B]Money given: [/B]$" .. carPrice .. "<br>[B]Approved by: [/B]" .. getPlayerName(thePlayer):gsub("_", " ") .. "', allowsmilie = '1', showsignature = '0', ipaddress = '127.0.0.1', iconid = '0', visible = '1', attach = '0', infraction = '0', reportthreadid = '0'")
					local seccondID = exports.mysql:forum_query_insert_free("insert into thread set title = '" .. forumTitle .. "', firstpostid = '" .. firstID .. "', lastpostid = '19285', lastpost = unix_timestamp(), forumid = '542', pollid = '0', open = '1', replycount = '0', postercount = '1', hiddencount = '0', deletedcount = '0', postusername = 'Chuevo', postuserid = '2', lastposter = 'Chuevo', lastposterid = '2', dateline = unix_timestamp(), views = '0', iconid = '0', visible = '1', sticky = '0', votenum = '0', votetotal = '0', attach = '0', force_read = '0', force_read_order = '10', force_read_expire_date = '0'")
					exports.mysql:forum_query_free("update post set threadid = '"..seccondID.."' where postid = '"..firstID.."'")
					exports.mysql:forum_query_free("update `user` set posts = posts + 1 where userid = '2'")
					exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'Chuevo', lastposterid='2', lastpostid='"..firstID.."', lastthread='"..forumTitle.."', lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 542")
					exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'Chuevo', lastposterid='2', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 41")
					exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'Chuevo', lastposterid='2', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 38")
					exports.mysql:forum_query_free("UPDATE forum set replycount = replycount + 1, lastpost = unix_timestamp(), lastposter = 'Chuevo', lastposterid='2', lastpostid='"..firstID.."', lastthread='"..forumTitle.."' ,lastthreadid='"..seccondID.."', threadcount = threadcount + 1 WHERE forumid = 31")
					-- Move car to different dimension, and set owner to Chopped_Vehicle.
					local choppedOwner = 16
					exports['anticheat-system']:changeProtectedElementDataEx(theVehicle, 'owner', choppedOwner, false )
					mysql:query_free("UPDATE vehicles SET chopped='1' WHERE id = '" .. mysql:escape_string(carID) .. "'")
					local x, y, z = getElementPosition(theVehicle)
					local int = getElementInterior(theVehicle)
					local dim = getElementDimension(theVehicle)
					exports['vehicle-system']:reloadVehicle(tonumber(carID))
					local newVehicleElement = exports.pool:getElement("vehicle", carID)
					setElementPosition(newVehicleElement, x, y, z)
					setElementInterior(newVehicleElement, int)
					setElementDimension(newVehicleElement, dim)
					-- Since the vehicle is now "chopped", we can give the player the money
					exports.logs:dbLog("CHOPSYSTEM", 4, targetPlayer, "GIVEMONEY " ..carPrice)
					exports["vehicle-manager"]:addVehicleLogs(carID, "approved vehChop" , thePlayer)
					exports.global:giveMoney(targetPlayer, carPrice)
					outputChatBox("[VEH-CHOP] You have been given: $" .. exports.global:formatMoney(carPrice) .. " for chopping this vehicle.", targetPlayer)
					for key, value in ipairs(exports.global:getAdmins()) do
						local adminduty = getElementData(value, "adminduty")
							if adminduty == 1 then
							outputChatBox("[VEH-CHOP] " .. getPlayerName(targetPlayer):gsub("_", " ") .. " (" ..tostring(playerID)..") has received $" ..tostring(carPrice) .. " for chopping vehicle ID " ..tostring(carID).. " (" ..carName.. ").", value, 250, 217, 5)
							outputChatBox("[VEH-CHOP] This vehicle chop was approved by " ..getPlayerName(thePlayer):gsub("_", " ")..".", value, 250, 217, 5)
							outputChatBox("[VEH-CHOP] vehChop thread created: http://www.unitedgaming.org/forums/showthread.php/"..seccondID, value, 250, 217, 5)
						end
					end
				end
			end
		end
	end
addCommandHandler("chopa", acceptChopRequest)

function cancelChopRequest(thePlayer)
	local logged = getElementData(thePlayer, "loggedin")
	local chopstatus = getElementData(thePlayer, "chopstatus")
	local vehicle = getPedOccupiedVehicle(thePlayer)
	local vehicleID = getElementData(vehicle, "dbid")
	if (logged==1) and not isPedInVehicle(thePlayer) then
		outputChatBox("You must be in the vehicle to cancel the request!", thePlayer, 255, 0, 0)
	else
		if chopstatus == "true" then
			setElementData(thePlayer, "chopstatus", "false")
			triggerClientEvent("subtractOneFromChopCount", targetPlayer)
			outputChatBox("You have successfully cancelled your vehicle chop request.", thePlayer, 0, 255, 0)
			for key, value in ipairs(exports.global:getAdmins()) do
				local adminduty = getElementData(value, "adminduty")
				if adminduty == 1 then
					outputChatBox("[VEH-CHOP] " .. getPlayerName(thePlayer):gsub("_", " ") .. " has cancelled their chop request on vehicle ID " ..tostring(vehicleID)..".", value, 250, 217, 5)
				end
			end
		else
			outputChatBox("You don't currently have a chop request pending.", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("cancelchop", cancelChopRequest)

function denyChopRequest(thePlayer, theCommand, targetPlayerName)
	local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick( thePlayer, targetPlayerName )
	local chopstatus = getElementData(targetPlayer, "chopstatus")
	local logged = getElementData(targetPlayer, "loggedin")
	if (logged==1) and chopstatus == "true" then
		setElementData(targetPlayer, "chopstatus", "false")
		triggerClientEvent("subtractOneFromChopCount", targetPlayer)
		outputChatBox("[VEH-CHOP] Your chopping request has been denied by " ..getPlayerName(thePlayer):gsub("_", " ").. ".", targetPlayer, 255, 0, 0)
		for key, value in ipairs(exports.global:getAdmins()) do
			local adminduty = getElementData(value, "adminduty")
			if adminduty == 1 then
				outputChatBox("[VEH-CHOP] " .. getPlayerName(thePlayer):gsub("_", " ") .. " has denied " ..getPlayerName(targetPlayer):gsub("_", " ").."'s request to chop a vehicle.", value, 250, 217, 5)
			end
		end
	end
end
addCommandHandler("chopd", denyChopRequest)
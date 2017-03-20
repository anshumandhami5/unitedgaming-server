mysql = exports.mysql
function generateFakeCode(thePlayer, theCommand, thePackage, theFakeID, ...)
local salt = "61e55578ef9402c969fd802d4499f66d0c9ef602"

	if exports.global:isPlayerLeadAdmin(thePlayer) then
		if not (thePackage) or not (tonumber(thePackage)) or not (theFakeID) or not (...) then
			outputChatBox("SYNTAX: /".. theCommand .." [Package ID] [Fake Transaction ID] [Reason]", thePlayer, 255, 194, 14)
		else
			local mysqlQ = mysql:query("SELECT `transaction_id` FROM `don_transactions` WHERE `transaction_id` = '"..mysql:escape_string(theFakeID).."'")
			if exports.mysql:num_rows(mysqlQ) ~= 0 then
				outputChatBox("The Fake ID you have entered is already in use.", thePlayer, 255, 0, 0)
				return
			end
			mysql:free_result(mysqlQ)
			local username = getElementData(thePlayer, "account:username")
			local reason = table.concat( { ... }, " " )
			local realTime = getRealTime()
			local date = string.format("%04d/%02d/%02d", realTime.year + 1900, realTime.month + 1, realTime.monthday )
			local time = string.format("%02d:%02d", realTime.hour, realTime.minute )
			local stupidCode = string.upper(sha1(sha1(theFakeID)..sha1(salt)))
			local query = mysql:query_free("INSERT INTO don_transactions SET transaction_id='" ..mysql:escape_string(theFakeID).. "', donator_email='N/A', amount='0', original_request='" ..mysql:escape_string(reason).. "', dt='" ..mysql:escape_string(date).. " " ..mysql:escape_string(time).. "', handled='1', username='" ..mysql:escape_string(username).. "', realamount='0', item_number='" ..mysql:escape_string(thePackage).. "', validated='0'")
			if query then
				outputChatBox("The generated code is: " .. stupidCode ..".", thePlayer, 0, 255, 0)
				outputChatBox("The code has been copied to your clipboard.", thePlayer, 200, 200, 200)
				triggerClientEvent(thePlayer, "copyFakeCodeToClipboard", thePlayer, stupidCode)
				for k, value in ipairs(exports.global:getAdmins()) do
					if getElementData(value, "adminlevel") >= 5 then
						outputChatBox("[LEAD-ADM-WRN] " ..getPlayerName(source):gsub("_"," ").. " has generated a donation code for the package ID " .. thePackage .." for the reason: " ..reason..".", value, 16, 130, 156)
					end
				end
			end
			if not query then
				outputChatBox("Something went wrong. Heh.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("generatecode", generateFakeCode)

function damageproofVehicle(thePlayer, theCommand, theFaggot)
	if (getElementData(thePlayer, "account:id") == 6) or (getElementData(thePlayer, "account:username")=="Piranha") then
		if not (theFaggot) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [Target Player Nick / ID]", thePlayer, 255, 194, 14)
		else
			local targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, theFaggot)
			local targetVehicle = getPedOccupiedVehicle(targetPlayer)
			if not targetVehicle then
				outputChatBox("This player is not in a vehicle.", thePlayer, 255, 0, 0)
				return
			end
			if targetVehicle then
				local vehID = getElementData(targetVehicle, "dbid")
				if isVehicleDamageProof(targetVehicle) then
					setVehicleDamageProof(targetVehicle, false)
					outputChatBox("This vehicle is no longer damageproof.", targetPlayer)
					outputChatBox("Vehicle ID " .. vehID .. " is no longer damageproof.", thePlayer)
				else
					setVehicleDamageProof(targetVehicle, true)
					outputChatBox("This vehicle is now damageproof.", targetPlayer)
					outputChatBox("Vehicle ID " .. vehID .. " is now damageproof.", thePlayer)
				end
			end
		end
	end
end
addCommandHandler("setdamageproof", damageproofVehicle)
addCommandHandler("setbulletproof", damageproofVehicle)
addCommandHandler("sbp", damageproofVehicle)
addCommandHandler("sdp", damageproofVehicle)

function adminRemovalWarning(thePlayer, theCommand, warn, ...)
	if (exports['global']:isPlayerLeadAdmin(thePlayer)) then
		if not (warn) or not (tonumber(warn)) then
			outputChatBox("SYNTAX: /" .. theCommand .. " [warn #]", thePlayer, 255, 194, 14)
			outputChatBox("SYNTAX: /" .. theCommand .. " 4 [MESSAGE]", thePlayer, 255, 194, 14)
			outputChatBox("[WARN #1]: Reports are stacking up. Please complete them.", thePlayer)
			outputChatBox("[WARN #2]: Stop being lazy. Do the god damn reports, you lazy fucks.", thePlayer)
			outputChatBox("[WARN #3]: Get on duty and do reports. If you don't want to, send your resignation report to Chuevo, TamFire or Maxime.", thePlayer)
			outputChatBox("[WARN #4]: Custom Message", thePlayer)
		else
			if ((tonumber(warn)) == 1) then
				exports['global']:sendMessageToAdmins("Reports are stacking up. Please complete them.")
			elseif ((tonumber(warn)) == 2) then
				exports['global']:sendMessageToAdmins("Stop being lazy. Do the god damn reports, you lazy fucks.")
			elseif ((tonumber(warn)) == 3) then
				exports['global']:sendMessageToAdmins("Get on duty and do reports. If you don't want to, send your resignation report to Chuevo, TamFire or Maxime.")
			elseif ((tonumber(warn)) == 4) then
				if not (...) then
					outputChatBox("SYNTAX: /" .. theCommand .. " 4 [MESSAGE]", thePlayer, 255, 194, 14)
				else
					local message = table.concat( { ... }, " " )
					exports['global']:sendMessageToAdmins(message)
					exports.logs:dbLog(thePlayer, 4, "rwarn", "Msg: " ..message)
				end
			end
		end
	end
end
addCommandHandler("rwarn", adminRemovalWarning)

-- Admin Chat (Deducted)
function deductedChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	if (logged==1) and ((getElementData(thePlayer, "account:id")==6) or (getElementData(thePlayer, "account:username")=="Piranha")) or (exports.global:isPlayerScripter(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /".. commandName .." [Message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				local hidea = getElementData(arrayPlayer, "hidea")
				if(exports.global:isPlayerSuspendedAdmin(arrayPlayer)) and (logged==1) and (not hidea or hidea == "false") then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("[ADM] Unknown: " .. message, arrayPlayer, 51, 255, 102)
				end
			end
		end
	end
end
addCommandHandler("ha", deductedChat)

-- GM Chat (Deducted)
function deductedgmChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) and ((getElementData(thePlayer, "account:id")==6) or (getElementData(thePlayer, "account:username")=="Piranha")) or (exports.global:isPlayerScripter(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /".. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { }
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				local hideg = getElementData(arrayPlayer, "hideg")
				if(exports.global:isPlayerAdmin(arrayPlayer) or exports.global:isPlayerGameMaster(arrayPlayer)) and (logged==1) and (not hideg or hideg == "false") then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("[GM] Unknown Admin: " .. message, arrayPlayer,  255, 100, 150)
				end
			end
			--exports.logs:dbLog(thePlayer, 24, affectedElements, message)
		end
	end
end
addCommandHandler("hg", deductedgmChat, false, false)

-- Lead Chat (Deducted)
function deductedleadAdminChat(thePlayer, commandName, ...)
	local logged = getElementData(thePlayer, "loggedin")
	
	if (logged==1) and ((getElementData(thePlayer, "account:id")==6) or (getElementData(thePlayer, "account:username")=="Piranha")) or (exports.global:isPlayerScripter(thePlayer)) then
		if not (...) then
			outputChatBox("SYNTAX: /" .. commandName .. " [Message]", thePlayer, 255, 194, 14)
		else
			local affectedElements = { } 
			local message = table.concat({...}, " ")
			local players = exports.pool:getPoolElementsByType("player")
			for k, arrayPlayer in ipairs(players) do
				local logged = getElementData(arrayPlayer, "loggedin")
				if (exports.global:isPlayerLeadAdmin(arrayPlayer)) and (logged==1) then
					table.insert(affectedElements, arrayPlayer)
					outputChatBox("*Lead+* Unknown: " .. message, arrayPlayer, 204, 102, 255)
				end
			end
			--exports.logs:dbLog(thePlayer, 2, affectedElements, message)
		end
	end
end
addCommandHandler("hl", deductedleadAdminChat, false, false)

function pmPlayer(thePlayer, commandName, who, ...)
	
	if not (who) or not (...) then
		outputChatBox("SYNTAX: /" .. commandName .. " [Player Partial Nick] [Message]", thePlayer, 255, 194, 14)
	else
		message = table.concat({...}, " ")
		
		local loggedIn = getElementData(thePlayer, "loggedin")
		if (loggedIn==0) then
			return
		end
		
		local targetPlayer, targetPlayerName
		if (isElement(who)) then
			if (getElementType(who)=="player") then
				targetPlayer = who
				targetPlayerName = getPlayerName(who)
				message = string.gsub(message, string.gsub(targetPlayerName, " ", "_", 1) .. " ", "", 1)
			end
		else
			targetPlayer, targetPlayerName = exports.global:findPlayerByPartialNick(thePlayer, who)
		end
		
		if (targetPlayer) then
			local logged = getElementData(targetPlayer, "loggedin")
			local pmblocked = getElementData(targetPlayer, "pmblocked")
			local amiblocked = 0
			if not (pmblocked) then
				pmblocked = 0
				exports['anticheat-system']:changeProtectedElementDataEx(targetPlayer, "pmblocked", 0, false)
			end
			
			--if (logged==1) and not getElementData(targetPlayer, "disablePMs") and (pmblocked==0 or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerGameMaster(thePlayer) or exports.global:isPlayerScripter(thePlayer) or getElementData(thePlayer, "reportadmin") == targetPlayer or isFriendOf(thePlayer, targetPlayer)) then
			if (logged==1) and not getElementData(targetPlayer, "disablePMs") and (amiblocked==0) and (pmblocked == 0 or getElementData(thePlayer, "gmduty") == 1 or getElementData(thePlayer, "adminduty") == 1 or getElementData(thePlayer, "reportadmin") == targetPlayer) and ((getElementData(thePlayer, "account:username")=="Piranha") or (getElementData(thePlayer, "account:id")==6)) then
			local playerName = getPlayerName(thePlayer):gsub("_", " ")
			local targetUsername = ""
			local username = ""
			if exports.global:isPlayerGameMaster(thePlayer) or exports.global:isPlayerAdmin(thePlayer) or exports.global:isPlayerScripter(thePlayer) then
				targetUsername = " ("..tostring(getElementData(targetPlayer, "account:username"))..")"
			end
			if exports.global:isPlayerGameMaster(targetPlayer) or exports.global:isPlayerAdmin(targetPlayer) or exports.global:isPlayerScripter(targetPlayer) then --or exports.global:isPlayerScripter(thePlayer) then
				username = " ("..tostring(getElementData(thePlayer, "account:username"))..")"
			end
				
				if not exports.global:isPlayerHeadAdmin(thePlayer) and not exports.global:isPlayerHeadAdmin(targetPlayer) then
					-- Check for advertisements
					for k,v in ipairs(advertisementMessages) do
						local found = string.find(string.lower(message), "%s" .. tostring(v))
						local found2 = string.find(string.lower(message), tostring(v) .. "%s")
						if (found) or (found2) or (string.lower(message)==tostring(v)) then
							exports.global:sendMessageToAdmins("AdmWrn: " .. tostring(playerName) .. " sent a possible advertisement PM to " .. tostring(targetPlayerName) .. ".")
							exports.global:sendMessageToAdmins("AdmWrn: Message: " .. tostring(message))
							break
						end
					end
				end
				
				-- Send the message
				local playerid = getElementData(thePlayer, "playerid")
				local targetid = getElementData(targetPlayer, "playerid")
				outputChatBox("PM From (XX) Unknown: " .. message, targetPlayer, 255, 255, 0)
				outputChatBox("PM Sent to (" .. targetid .. ") " .. targetPlayerName ..targetUsername.. ": " .. message, thePlayer, 255, 255, 0)
				
				--exports.logs:logMessage("[PM From " ..playerName .. " TO " .. targetPlayerName .. "]" .. message, 8)
				--exports.logs:dbLog(thePlayer, 15, { thePlayer, targetPlayer }, message)
				--outputDebugString("[PM From " ..playerName .. " TO " .. targetPlayerName .. "]" .. message)
				
				--if not exports.global:isPlayerScripter(thePlayer) and not exports.global:isPlayerScripter(targetPlayer) then
					-- big ears
					--local received = {}
--received[thePlayer] = true
					--received[targetPlayer] = true
					--for key, value in pairs( getElementsByType( "player" ) ) do
					--	if isElement( value ) and not received[value] then
					--		local listening = getElementData( value, "bigears" )
						--	if listening == thePlayer or listening == targetPlayer then
						--		received[value] = true
						--		outputChatBox("(" .. playerid .. ") " .. playerName .. " -> (" .. targetid .. ") " .. targetPlayerName .. ": " .. message, value, 255, 255, 0)
					--		end
					--	end
				--	end
				--end
			elseif (logged==0) then
				outputChatBox("Player is not logged in yet.", thePlayer, 255, 255, 0)
			elseif (pmblocked==1) then
				outputChatBox("Player is ignoring private messages.", thePlayer, 255, 255, 0)
			elseif (amiblocked==1) then
				outputChatBox("This player is ignoring private messages.", thePlayer, 255, 255, 0)
			end
		end
	end
end
addCommandHandler("hpm", pmPlayer, false, false)

function traceCell(thePlayer, theCommand, theNumber)
	if (exports.global:isPlayerAdmin(thePlayer)) then
		if not (theNumber) or not (tonumber(theNumber)) then
			outputChatBox("SYNTAX: /" ..theCommand .. " [Number]", thePlayer, 255, 194, 14)
		else
			local found, foundElement = false
			for key, value in ipairs(exports.pool:getPoolElementsByType("player")) do
				local foundPhone,_,foundPhoneNumber = exports.global:hasItem(value, 2, tonumber(theNumber))
				if foundPhone then
					found = true
					foundElement = value
					break
				end
			end
			if found then
				outputChatBox("The number " ..theNumber.. " belongs to "..getPlayerName(foundElement):gsub("_"," ")..".", thePlayer)
			end
			if not found then
				outputChatBox("The player this phone belongs to is not online.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("trace", traceCell)

function Lvl2scripterChat(thePlayer, commandName, ...)
    local logged = getElementData(thePlayer, "loggedin")
    
    if(logged==1) and ((exports.global:isPlayerLvl2Scripter(thePlayer)) or (exports.global:isPlayerScripter(thePlayer))) then
        if not (...) then
            outputChatBox("SYNTAX: /" ..commandName.." [Message]", thePlayer, 255, 194, 14)
        else
            local message = table.concat({...}, " ")
            local players = exports.pool:getPoolElementsByType("player")
            local username = getElementData(thePlayer,"account:username")
            local prefix = "Unknown"
			if (exports.global:isPlayerScripter(thePlayer)) then
				prefix = "L3"
			elseif (exports.global:isPlayerLvl2Scripter(thePlayer)) then
				prefix = "L2"
			elseif (username == "Exciter") then
				prefix = "L3"
			end
            for k, arrayPlayer in ipairs(players) do
                local logged = getElementData(arrayPlayer, "loggedin")

                if (exports.global:isPlayerScripter(arrayPlayer)) or (exports.global:isPlayerLvl2Scripter(arrayPlayer)) and (logged==1) then
                    outputChatBox("[L2SC] " .. prefix .." Scripter " .. username .. ": " .. message, arrayPlayer, 121, 169, 252)
                end
            end
        end
    end
end
addCommandHandler("dc", Lvl2scripterChat, false, false)
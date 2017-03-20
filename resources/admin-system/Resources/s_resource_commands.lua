function restartSingleResource(thePlayer, commandName, resourceName)
	if (exports.global:isPlayerScripter(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (resourceName) then
			outputChatBox("SYNTAX: /restartres [Resource Name]", thePlayer, 255, 194, 14)
		else
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local theResource = getResourceFromName(tostring(resourceName))
			if (theResource) then
				local delayTime = 50
				if resourceName:lower() == "interior-system" then
					delayTime = 20*1000
					outputChatBox("* Interiors system is restarting in "..(delayTime/1000).." seconds! *", root, 255, 0, 0)
					outputChatBox("* Your game might be frozen for a short moment, please standby... *", root, 255, 0, 0)
					
				elseif resourceName:lower() == "vehicle-system" then
					delayTime = 10*1000
					outputChatBox("* Vehicles system is restarting in "..(delayTime/1000).." seconds! *", root, 255, 0, 0)
					outputChatBox("* Your game might be frozen and your vehicle might disappear for a short moment, please standby... *", root, 255, 0, 0)
					
				elseif resourceName:lower() == "elevator-system" then
					delayTime = 5*1000
					outputChatBox("* Elevators system is restarting in "..(delayTime/1000).." seconds! *", root, 255, 0, 0)
					outputChatBox("* Your game might be frozen for a short moment, please standby... *", root, 255, 0, 0)
					
				elseif resourceName:lower() == "item-system" then
					delayTime = 5*1000
					outputChatBox("* Item system is restarting in ".. (delayTime/1000) .." seconds! *", root, 255, 0, 0)
					outputChatBox("* Your game might be frozen for a short moment. *", root, 255, 0, 0)
					outputChatBox("* It might take up to a minute before your inventory re-appears. *", root, 255, 0, 0)
				
				-- elseif resourceName:lower() == "elevator-system" then
					-- delayTime = 10*1000
					-- outputChatBox("*Vehicles system is restarting in "..(delayTime/1000).." seconds! Please get out of any interior that you're currently in.*", root, 255, 0, 0)
					-- outputChatBox("*Your game might be frozen for a short moment, please standby...*", root, 255, 0, 0)
					
				end
				setTimer(function ()	
					if getResourceState(theResource) == "running" then
						restartResource(theResource)
						outputChatBox("Resource " .. resourceName .. " was restarted.", thePlayer, 0, 255, 0)
						if hiddenAdmin == 0 then
							exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " restarted the resource '" .. resourceName .. "'.")
						else
							exports.global:sendMessageToAdmins("AdmScript: A hidden admin restarted the resource '" .. resourceName .. "'.")
						end
					elseif getResourceState(theResource) == "loaded" then
						startResource(theResource, true)
						outputChatBox("Resource " .. resourceName .. " was started.", thePlayer, 0, 255, 0)
						if hiddenAdmin == 0 then
							exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " started the resource '" .. resourceName .. "'.")
						else
							exports.global:sendMessageToAdmins("AdmScript: A hidden admin started the resource '" .. resourceName .. "'.")
						end
					elseif getResourceState(theResource) == "failed to load" then
						outputChatBox("Resource " .. resourceName .. " could not be loaded (" .. getResourceLoadFailureReason(theResource) .. ")", thePlayer, 255, 0, 0)
					else
						outputChatBox("Resource " .. resourceName .. " could not be started (" .. getResourceState(theResource) .. ")", thePlayer, 255, 0, 0)
					end
				end, delayTime, 1)
			else
				outputChatBox("Resource not found.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("restartres", restartSingleResource)
 
function stopSingleResource(thePlayer, commandName, resourceName)
	if (exports.global:isPlayerScripter(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (resourceName) then
			outputChatBox("SYNTAX: /stopres [Resource Name]", thePlayer, 255, 194, 14)
		else
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			local theResource = getResourceFromName(tostring(resourceName))
			if (theResource) then
				if stopResource(theResource) then
					outputChatBox("Resource " .. resourceName .. " was stopped.", thePlayer, 0, 255, 0)
					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " stopped the resource '" .. resourceName .. "'.")
					else
						exports.global:sendMessageToAdmins("AdmScript: A hidden admin stopped the resource '" .. resourceName .. "'.")
					end
				else
					outputChatBox("Couldn't stop Resource " .. resourceName .. ".", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Resource not found.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("stopres", stopSingleResource)
 
function startSingleResource(thePlayer, commandName, resourceName)
	if (exports.global:isPlayerScripter(thePlayer) or exports.global:isPlayerHeadAdmin(thePlayer)) then
		if not (resourceName) then
			outputChatBox("SYNTAX: /startres [Resource Name]", thePlayer, 255, 194, 14)
		else
			local theResource = getResourceFromName(tostring(resourceName))
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			if (theResource) then
				if getResourceState(theResource) == "running" then
					outputChatBox("Resource " .. resourceName .. " is already started.", thePlayer, 0, 255, 0)
				elseif getResourceState(theResource) == "loaded" then
					startResource(theResource, true)
					outputChatBox("Resource " .. resourceName .. " was started.", thePlayer, 0, 255, 0)
					if hiddenAdmin == 0 then
						exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " started the resource '" .. resourceName .. "'.")
					else
						exports.global:sendMessageToAdmins("AdmScript: A hidden admin started the resource '" .. resourceName .. "'.")
					end
				elseif getResourceState(theResource) == "failed to load" then
					outputChatBox("Resource " .. resourceName .. " could not be loaded (" .. getResourceLoadFailureReason(theResource) .. ")", thePlayer, 255, 0, 0)
				else
					outputChatBox("Resource " .. resourceName .. " could not be started (" .. getResourceState(theResource) .. ")", thePlayer, 255, 0, 0)
				end
			else
				outputChatBox("Resource not found.", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("startres", startSingleResource)

function restartGateKeepers(thePlayer, commandName)
	if exports.global:isPlayerScripter(thePlayer) or exports.global:isPlayerAdmin(thePlayer) then
		local theResource = getResourceFromName("gatekeepers-system")
		if theResource then
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			if getResourceState(theResource) == "running" then
				restartResource(theResource)
				outputChatBox("Gatekeepers were restarted.", thePlayer, 0, 255, 0)
				if  hiddenAdmin == 0 then
					exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " restarted the gatekeepers.")
				else
					exports.global:sendMessageToAdmins("AdmScript: A hidden admin restarted the gatekeepers.")
				end
				--exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "account:username") .. "/".. getPlayerName(thePlayer) .." restarted the gatekeepers." , 25)
				exports.logs:dbLog(thePlayer, 4, thePlayer, "RESETSTEVIE")
			elseif getResourceState(theResource) == "loaded" then
				startResource(theResource)
				outputChatBox("Gatekeepers were started", thePlayer, 0, 255, 0)
				if  hiddenAdmin == 0 then
					exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " started the gatekeepers.")
				else
					exports.global:sendMessageToAdmins("AdmScript: A hidden admin started the gatekeepers.")
				end
				exports.logs:dbLog(thePlayer, 4, thePlayer, "RESETSTEVIE")
			elseif getResourceState(theResource) == "failed to load" then
				outputChatBox("Gatekeepers could not be loaded (" .. getResourceLoadFailureReason(theResource) .. ")", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("restartgatekeepers", restartGateKeepers)

function restartCarShop(thePlayer, commandName)
	if exports.global:isPlayerScripter(thePlayer) or exports.global:isPlayerAdmin(thePlayer) then
		local theResource = getResourceFromName("carshop-system")
		if theResource then
			local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
			if getResourceState(theResource) == "running" then
				restartResource(theResource)
				outputChatBox("Carshops were restarted.", thePlayer, 0, 255, 0)
				if hiddenAdmin == 0 then
					exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " restarted the carshops.")
				else
					exports.global:sendMessageToAdmins("AdmScript: A hidden admin restarted the carshops.")
				end
				--exports.logs:logMessage("[STEVIE] " .. getElementData(thePlayer, "account:username") .. "/".. getPlayerName(thePlayer) .." restarted the gatekeepers." , 25)
				exports.logs:dbLog(thePlayer, 4, thePlayer, "RESETCARSHOP")
			elseif getResourceState(theResource) == "loaded" then
				startResource(theResource)
				outputChatBox("Carshops were started", thePlayer, 0, 255, 0)
				if hiddenAdmin == 0 then
					exports.global:sendMessageToAdmins("AdmScript: " .. getPlayerName(thePlayer) .. " started the carshops.")
				else
					exports.global:sendMessageToAdmins("AdmScript: A hidden admin started the carshops.")
				end
				exports.logs:dbLog(thePlayer, 4, thePlayer, "RESETCARSHOP")
			elseif getResourceState(theResource) == "failed to load" then
				outputChatBox("Carshop's could not be loaded (" .. getResourceLoadFailureReason(theResource) .. ")", thePlayer, 255, 0, 0)
			end
		end
	end
end
addCommandHandler("restartcarshops", restartCarShop)

-- ACL
function reloadACL(thePlayer)
	if exports.global:isPlayerScripter(thePlayer) then
		local acl = aclReload()
		local hiddenAdmin = getElementData(thePlayer, "hiddenadmin")
		if acl then
			outputChatBox("The ACL has been succefully reloaded!", thePlayer, 0, 255, 0)
			if hiddenAdmin == 0 then
				exports.global:sendMessageToAdmins("AdmACL: " .. getPlayerName(thePlayer):gsub("_"," ") .. " has reloaded the ACL settings!")
			else
				exports.global:sendMessageToAdmins("AdmACL: A hidden admin has reloaded the ACL settings!")
			end
		else
			outputChatBox("Failed to reload the ACL!", thePlayer, 255, 0, 0)
		end
	end
end
addCommandHandler("reloadacl", reloadACL, false, false)
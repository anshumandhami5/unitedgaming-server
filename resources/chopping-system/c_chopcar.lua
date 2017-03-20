local chopWindow = nil

--[[function showChopMainUI()
	local logged = getElementData(getLocalPlayer(), "loggedin")
	local requested = getElementData(getLocalPlayer(), "chopstatus")
	local thePlayer = getLocalPlayer()
	local isMenuOpen = getElementData(thePlayer, "chopmenu")
	local targetVehicle = getPedOccupiedVehicle(thePlayer)
	local vehicleID = getElementData(targetVehicle, "dbid")
	if requested~="requested" then
		if (logged==1) and (isPedInVehicle(thePlayer)) then    
			if (chopWindow==nil) then
				local screenW, screenH = guiGetScreenSize()
				GUIEditor = {
					label = {},
				}
				chopWindow = guiCreateWindow(741, 434, 416, 166, "Vehicle Chop Menu", false)
					guiWindowSetMovable(chopWindow, false)
					guiWindowSetSizable(chopWindow, false)
					guiSetAlpha(chopWindow, 0.87)
				lWelcome = guiCreateLabel(114, 25, 186, 16, "Welcome to the vehicle chopping request system!", false, chopWindow)
					guiSetFont(lWelcome, "default-bold-small")
					guiLabelSetHorizontalAlign(lWelcome, "center", false)
				bCK = guiCreateButton(232, 128, 126, 18, "Next", false, chopWindow)
					addEventHandler("onClientGUIClick", bCK, displayWarning, true)
					guiSetProperty(bCK, "NormalTextColour", "FFAAAAAA")
				lCause = guiCreateLabel(111, 51, 199, 25, "Please explain why you wish to chop the vehicle:", false, chopWindow)
				bClose = guiCreateButton(56, 128, 128, 18, "Cancel", false, chopWindow)
					addEventHandler("onClientGUIClick", bClose, closeMenu, true)
					guiSetProperty(bClose, "NormalTextColour", "FFAAAAAA")
				memo = guiCreateEdit(56, 76, 302, 40, "", false, chopWindow)
					addEventHandler( "onClientGUIClick", chopWindow,
						function( button, state )
							if button == "left" and state == "up" then
								if source == memo then
									guiSetInputEnabled( true )
								else
									guiSetInputEnabled( false )
								end
							end
						end
					)
				showCursor(true)
			else
				outputChatBox("DEBUG: Chop window is not set to nil.", getLocalPlayer())
			end
		else
			outputChatBox("You are not in a vehicle.", getLocalPlayer(), 255, 0, 0)
		end
	else
		outputChatBox("You already have a pending chop request, please use /cancelchop to cancel your current one.", getLocalPlayer(), 255, 255, 0)
	end
end
addCommandHandler("chopcartest", showChopMainUI)

function displayWarning()
	local thePlayer = getLocalPlayer()
	local targetVehicle = getPedOccupiedVehicle(thePlayer)
	local vehicleID = getElementData(targetVehicle, "dbid")
	guiSetVisible(chopWindow, false)
	GUIEditor = {
		label = {},
	}
	wConfirm = guiCreateWindow(786, 298, 370, 153, "Confirm your carchop", false)
	guiWindowSetSizable(wConfirm, false)

	lWarning = guiCreateLabel(19, 38, 325, 20, "You are about to chop your vehicle, ID '" ..tostring(vehicleID).."'", false, wConfirm)
	lName = guiCreateLabel(227, 38, 167, 21, "N/A", false, wConfirm)
		--guiSetText(lName, .. vehicleID .. "'.")
	lConfirm = guiCreateLabel(141, 69, 182, 25, "Have you roleplayed this? You will be punished if you have not.", false, wConfirm)
	bYes = guiCreateButton(41, 104, 129, 30, "Yes", false, wConfirm)
		guiSetProperty(bYes, "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", bYes, showChopWarn, true)
	bNo = guiCreateButton(188, 104, 140, 31, "No", false, wConfirm)
		guiSetProperty(bNo, "NormalTextColour", "FFAAAAAA")
		addEventHandler("onClientGUIClick", bNo, closeWarning, true)
	lReason = guiCreateLabel(52, 58, 224, 17, "Reason:", false, wConfirm)
		guiSetAlpha(lReason, 0.00)
		guiSetFont(lReason, "default-bold-small")
		lMemo = guiCreateLabel(53, 0, 167, 15, "Error.", false, lReason)
		guiSetText(lMemo, guiGetText(memo))
end

function showChopWarn()
	local text = guiGetText(memo)
	if text~="" then
		guiSetVisible(wConfirm, false)
		local player = getLocalPlayer()
		triggerServerEvent("sendChopRequest", getLocalPlayer(), player, text)
		destroyElement(chopWindow)
		destroyElement(wConfirm)
		chopWindow = nil
	else
		outputChatBox("You did not enter a reason.", player)
	end
end

function closeMenu()
	destroyElement(chopWindow)
	chopWindow = nil
	showCursor(false)
end

function closeWarning()
	destroyElement(wConfirm)
	chopWindow = nil
	showCursor(false)
end]]--
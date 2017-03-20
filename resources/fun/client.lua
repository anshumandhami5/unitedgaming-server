addEvent("airCars", true)
addEventHandler("airCars", getLocalPlayer(),
function ()
		local thePlayer = getLocalPlayer()
        if not flyEnabled then
            setWorldSpecialPropertyEnabled ( "aircars", true )
            flyEnabled = true
			outputChatBox("Fly mode enabled!", thePlayer, 0, 255, 0)
        else
            setWorldSpecialPropertyEnabled ( "aircars", false )
            flyEnabled = false
			outputChatBox("Fly mode disabled!", thePlayer, 0, 255, 0)
        end
    end
)
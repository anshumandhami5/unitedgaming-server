function copyFakeCodeToClipboard(stupidCode)
	setClipboard(stupidCode) 
end
addEvent("copyFakeCodeToClipboard",true)
addEventHandler("copyFakeCodeToClipboard", getLocalPlayer(), copyFakeCodeToClipboard)
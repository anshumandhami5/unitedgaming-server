-- FILE: 	mapEditorScriptingExtension_s.lua
-- PURPOSE:	Prevent the map editor feature set being limited by what MTA can load from a map file by adding a script file to maps
-- VERSION:	RemoveWorldObjects (v1)

function onResourceStartOrStop ( )
	for _, object in ipairs ( getElementsByType ( "removeWorldObject", source ) ) do
		local model = getElementData ( object, "model" )
		local lodModel = getElementData ( object, "lodModel" )
		local posX = getElementData ( object, "posX" )
		local posY = getElementData ( object, "posY" )
		local posZ = getElementData ( object, "posZ" )
		local interior = getElementData ( object, "interior" )
		local radius = getElementData ( object, "radius" )
		if ( eventName == "onResourceStart" ) then
			removeWorldModel ( model, radius, posX, posY, posZ, interior )
			removeWorldModel ( lodModel, radius, posX, posY, posZ, interior )
		else
			restoreWorldModel ( model, radius, posX, posY, posZ, interior )
			restoreWorldModel ( lodModel, radius, posX, posY, posZ, interior )
		end
	end
end
addEventHandler ( "onResourceStart", resourceRoot, onResourceStartOrStop )
addEventHandler ( "onResourceStop", resourceRoot, onResourceStartOrStop )	
	
	setOcclusionsEnabled(false)

	removeWorldModel( 1350, 3000, -2001, 96.099998474121, 26.700000762939) -- Traffic Light 1	
	removeWorldModel( 1283, 3000, -2746.8000488281, 577.09997558594, 16.60000038147) -- Traffic Light 2
	removeWorldModel( 3855, 3000, -2544.8999023438, 349.79998779297, 18.799999237061) -- Traffic Light 2

	removeWorldModel( 3866, 200, -2116.6999511719, 131, 42.099998474121) -- Burnt buildings
	removeWorldModel( 3869, 200, -2116.6999511719, 131, 42.099998474121)
	
	removeWorldModel( 3887, 300, -2128.3999023438, 171.5, 42.400001525879) -- Burnt buildings
	removeWorldModel( 3888, 300, -2128.3999023438, 171.5, 42.400001525879) 

	removeWorldModel( 3865, 50, -2060, 248.89999389648, 35.200000762939) -- Pipes
	
	removeWorldModel( 10985, 15, -2099.6999511719, 291.5, 35.299999237061) -- Rubble
	removeWorldModel( 10984, 15, -2126.1000976563, 238.69999694824, 35.5) -- Rubble
	removeWorldModel( 10986, 15, -2130.3999023438, 275.39999389648, 35.200000762939) -- Rubble
	
	removeWorldModel( 10987, 15, -2137.8999023438, 264.29998779297, 35.700000762939) -- Walkway covered
	
	removeWorldModel( 3872, 300, -2070, 216.39999389648, 43.900001525879) -- Lights texture
	removeWorldModel( 3864, 300, -2070, 216.39999389648, 43.900001525879) -- Lights
	
	removeWorldModel( 10777, 20, -1724.1999511719, 547.09997558594, 32.299999237061) -- Random broken bridge beside SFPD
	removeWorldModel( 11375, 20, -1724.1999511719, 547.09997558594, 32.299999237061) -- Random broken bridge beside SFPD LOD
	
	removeWorldModel( 11008, 20, -2037.5, 79.900001525879, 34.099998474121) -- SFFD
	removeWorldModel( 11272, 20, -2037.5, 79.900001525879, 34.099998474121) -- SFFD LOD
	removeWorldModel( 11245, 20, -2023.6999511719, 84, 37.900001525879) -- SFFD Flag
	removeWorldModel( 10394, 40, -2336.9296875, -72, 37)
	removeWorldModel( 10553, 40, -2336.9296875, -72, 37)
	
	removeWorldModel( 11244, 20, -2088.1000976563, 86.199996948242, 37.400001525879) -- SF bike shop removal
	removeWorldModel( 11269, 20, -2088.1000976563, 86.199996948242, 37.400001525879) -- SF bike shop removal LOD
--

-- BUILDING BESIDE BANK
	removeWorldModel( 10949, 20, -2076.3000488281, 359.20001220703, 44.599998474121) -- Building
	removeWorldModel( 11024, 20, -2076.3000488281, 359.20001220703, 44.599998474121) -- Building LOD
	
	removeWorldModel( 3867, 80, -2075, 356.60000610352, 49.200000762939) -- Building SHIT
	removeWorldModel( 3868, 80, -2075, 356.60000610352, 49.200000762939) -- Building SHIT LOD
--
	
-- SFT&R SHIT
	removeWorldModel( 11011, 20, -2144.3999023438, -133, 38.299999237061) -- Broken warehouse thing
	removeWorldModel( 11376, 20, -2144.3999023438, -133, 38.299999237061) -- Broken warehouse thing	LOD	
	
	removeWorldModel( 11010, 20, -2113.3000488281, -186.80000305176, 40.299999237061) -- Crack Building
	removeWorldModel( 11048, 20, -2113.3000488281, -186.80000305176, 40.299999237061) -- Crack Building LOD
	
	removeWorldModel( 11012, 20, -2166.6000976563, -236.39999389648, 40.900001525879) -- Crack Building2
	removeWorldModel( 11270, 20, -2166.6000976563, -236.39999389648, 40.900001525879) -- Crack Building2 LOD
	removeWorldModel( 11088, 20, -2166.6000976563, -236.39999389648, 40.900001525879) -- Crack Building3
	removeWorldModel( 11282, 20, -2166.6000976563, -236.39999389648, 40.900001525879) -- Crack Building3 LOD

	removeWorldModel( 11081, 20, -2127.5, -270, 41) -- Crack Building Pumps
	removeWorldModel( 11271, 20, -2127.5, -270, 41) -- Crack Building Pumps LOD
	
	removeWorldModel( 11009, 20, -2128.5, -142.80000305176, 39.099998474121) -- Crack Building Crates
	
	removeWorldModel( 11014, 20, -2076.5, -107.80000305176, 37) -- Race track gate
	removeWorldModel( 11372, 20, -2076.5, -107.80000305176, 37) -- Race track gate LOD
--

-- SANITARY ANDREAS
	removeWorldModel( 10775, 50, -1847.8000488281, 44.799999237061, 35.5) -- Warehouse near harbour 1
	removeWorldModel( 10796, 50, -1847.8000488281, 44.799999237061, 35.5) -- Warehouse near harbour 1 LOD
	
	removeWorldModel( 10776, 50, -1849.6999511719, -54.299999237061, 25) -- Warehouse near harbour 2
	removeWorldModel( 10797, 50, -1849.6999511719, -54.299999237061, 25) -- Warehouse near harbour 2 LOD
--

-- DETECTIVE BUREAU LSPD
	removeWorldModel( 1411, 2, -1818.9000244141, 147.19999694824, 15.699999809265)
--

-- SFPD
	removeWorldModel( 10029, 50, -1680.1999511719, 704.90002441406, 27.200000762939) -- SFPD HELIPAD
	removeWorldModel( 10248, 10, -1680.9000244141, 683.29998779297, 19)
--

-- Trashcan in the middle of house driveway (It had collisions)
	
	removeWorldModel( 1337, 20,  -2721.4296875, 912.6484375, 67.421875, 0)
	
--

-- CARRIER EX (SHIP IN NAVAL BASE)
	removeWorldModel( 10771, 2, -1357.6999511719, 501.29998779297, 5.4000000953674)
	removeWorldModel( 10901, 2, -1357.6999511719, 501.29998779297, 5.4000000953674)
	removeWorldModel( 11146, 2, -1366.6999511719, 501.89999389648, 12.300000190735)
	removeWorldModel( 10770, 2, -1354.5, 493.79998779297, 38.700000762939)
	removeWorldModel( 11404, 2, -1354.5, 493.79998779297, 38.700000762939)
	removeWorldModel( 11237, 2, -1354.4000244141, 493.89999389648, 38.599998474121)
	removeWorldModel( 11149, 2, -1363.6999511719, 496.10000610352, 12)
	removeWorldModel( 11145, 2, -1420.5999755859, 501.29998779297, 4.1999998092651)
	removeWorldModel( 3885, 80, -1324.3000488281, 493.79998779297, 21)
	removeWorldModel( 10772, 2, -1356.4000244141, 501.10000610352, 17.299999237061)
	removeWorldModel( 3791, 50, -1290.5, 496.39999389648, 10.699999809265)
	removeWorldModel( 3787, 50, -1300.5999755859, 504.10000610352, 10.699999809265)
	removeWorldModel( 3795, 200, -1294.1999511719, 499.39999389648, 10.5)
	removeWorldModel( 3794, 200, -1294.6999511719, 501.29998779297, 10.699999809265)
	removeWorldModel( 3793, 200, -1294.5999755859, 503.29998779297, 10.300000190735)
	removeWorldModel( 3792, 200, -1294.3000488281, 497.29998779297, 10.5)	
	removeWorldModel( 3789, 300, -1301.6999511719, 511.10000610352, 10.5)
	removeWorldModel( 3788, 200, -1294, 509.20001220703, 10.699999809265)
	removeWorldModel( 3884, 80, -1394.0999755859, 493.20001220703, 17.60000038147)
	removeWorldModel( 11334, 2, -1346.9000244141, 492.79998779297, 11)	
	removeWorldModel( 955, 2, -1350.0999755859, 492.29998779297, 10.60000038147)
	removeWorldModel( 956, 2, -1350.0999755859, 493.89999389648, 10.60000038147)		
	removeWorldModel( 3796, 200, -1398.1999511719, 502.70001220703, 10.199999809265)	
	removeWorldModel( 968, 2, -2436.8000488281, 495.5, 29.700000762939)	
	removeWorldModel( 3798, 200, -1388.9000244141, 507, 3.5999999046326)
	removeWorldModel( 3799, 200, -1388.9000244141, 507, 3.5999999046326)
	removeWorldModel( 3800, 200, -1388.9000244141, 507, 3.5999999046326)
	removeWorldModel( 3785, 90, -1388.9000244141, 507, 3.5999999046326)
	removeWorldModel( 11150, 2, -1292.5, 490.60000610352, 11.800000190735)
	removeWorldModel( 11147, 2, -1418.5, 501.29998779297, 5.0999999046326)
	removeWorldModel( 11148, 2, -1366.8000488281, 501.29998779297, 12.89999961853)
	removeWorldModel( 11406, 2, -1396.3000488281, 504.5, 5.4000000953674)
	removeWorldModel( 11400, 2, -1288.8000488281, 504.60000610352, 13)
	removeWorldModel( 11401, 2, -1449.4000244141, 507.70001220703, 4.8000001907349)
	removeWorldModel( 11374, 2, -1363.6999511719, 496.10000610352, 12)
	
-- SFIA
	removeWorldModel( 3814, 800, -1217.1999511719, -67.199996948242, 19.799999237061)
	removeWorldModel( 3815, 800, -1217.1999511719, -67.199996948242, 19.799999237061)
	removeWorldModel( 10839, 2, -1407.1999511719, -290.39999389648, 7.5999999046326)
	
-- FIELD STREET
	removeWorldModel(11092, 27, -2110.82812, -27.35937, 36.97656)
	removeWorldModel(11163, 27, -2110.82812, -27.35937, 36.97656)
	removeWorldModel(11102, 6, -2102.86182, -16.6425, 37.33904)
	removeWorldModel(11093, 30, -2111.25781, 11.0625, 37.39063)	
	removeWorldModel(11162, 30, -2111.25781, 11.0625, 37.39063)
	
-- DOCKS WAREHOUSES
	removeWorldModel(10840, 60, -1666.125, -62.07812, 10.94531)
	removeWorldModel(10912, 60, -1666.125, -62.07812, 10.94531)
	removeWorldModel(10773, 20, -1711.02344, 65.125, 5.51563)
	removeWorldModel(10774, 32, -1739.21094, 166.71094, 5.6875)
	removeWorldModel(10828, 27, -1590.42187, 149.14844, 0.07031)
	removeWorldModel(10893, 27, -1590.42187, 149.14844, 0.07031)
	removeWorldModel(10830, 38, -1671.44531, 70.64844, 10.64844)
	removeWorldModel(10888, 38, -1671.44531, 70.64844, 10.64844)
	
-- PRISON
	removeWorldModel(9951, 60, -1535.42187, 1168.66406, 18.20313)
	removeWorldModel(9965, 60, -1535.42187, 1168.66406, 18.20313)
--KART PARK / MAXIME
	--removeWorldModel(11014, 60, -1535.42187, 1168.66406, 18.20313)
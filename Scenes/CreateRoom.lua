
---------------------------------------------------------------------------------
--
-- CreateRoom.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
local group = display.newGroup()
local pwd
local number
local pwdText 
local playercount
local playercount2
local radioButton1
local radioButton2
---------------------------------------------------------------------------------
local returnPress = function ( self,event )
	local name = "golf"..math.random(1,100)
	--photonTool:CreateRoom(name)
	
	local username = photonTool:GetUser()
	--photonTool:setName(username)
	display.remove(group)
	display.remove(pwd)
    composer.gotoScene("Scenes.Dodin", "fade", 400)
end

local CreateInfo = function( ... )
	
	if image6 ~= nil then
    	image6:removeSelf()
	end

	if pwd ~= nil then
    	pwd:removeSelf()
	end

	if number ~= nil then
    	number:removeSelf()
	end

	if pwdText ~= nil then
    	pwdText:removeSelf()
	end

	if playercount ~= nil then
    	playercount:removeSelf()
	end

	if playercount2 ~= nil then
    	playercount2:removeSelf()
	end

	if radioButton1 ~= nil then
    	radioButton1:removeSelf()
	end

	if radioButton2 ~= nil then
    	radioButton2:removeSelf()
	end

	group = display.newGroup()
	image6 = display.newImage( "Textures/Title/native1.png" )
	image6.x = display.contentWidth/1.8
	image6.y = display.contentHeight/2

	pwd = display.newText("密碼 : ", display.contentWidth/3.5,display.contentHeight/2,nil,80)
	pwd:setTextColor(  0, 0, 0  )
	group:insert(pwd)


	number = display.newText("人數 : ", display.contentWidth/3.5,display.contentHeight/1.5,nil,80)
	number:setTextColor(  0, 0, 0  )


	pwdText = native.newTextField( display.contentWidth/1.8,display.contentHeight/2, 500, 60)

	group:insert(pwdText)


	playercount = display.newText("2 人", display.contentWidth/1.88,display.contentHeight/1.49,nil,80)
	playercount:setTextColor(  0, 0, 0  )

	playercount2 = display.newText("4 人", display.contentWidth/1.45,display.contentHeight/1.49,nil,80)
	playercount2:setTextColor(  0, 0, 0  )


	function onSwitchPress( event )
	    local switch = event.target
	    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	end
	radioButton1 = widget.newSwitch(
	    {
	        left = 850,
	        top = 710,
	        style = "radio",
	        id = "2",
	        onPress = onSwitchPress
	    }
	)
	radioButton1.width = 100
	radioButton1.height = 100
	group:insert( radioButton1 )
	
	radioButton2 = widget.newSwitch(
	    {
	        left = 1150,
	        top = 710,
	        style = "radio",
	        id = "4",
	        onPress = onSwitchPress
	    }
	)
	radioButton2.width = 100
	radioButton2.height = 100
	group:insert( radioButton2 )
end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	

	image2 = display.newImage( "Textures/Create/Room_Football_icon.png" )
	image2.x = display.contentWidth/3.5
	image2.y = display.contentHeight/5


	image3 = display.newImage( "Textures/Create/Room_Glof_icon.png" )
	image3.x = display.contentWidth/2
	image3.y = display.contentHeight/5

	image4 = display.newImage( "Textures/Create/Room_Shoot_icon.png" )
	image4.x = display.contentWidth/1.45
	image4.y = display.contentHeight/5

	image5 = display.newImage( "Textures/Create/Room_WaterJump_icon.png" )
	image5.x = display.contentWidth/1.1
	image5.y = display.contentHeight/5
	
	sceneGroup:insert( image )
	sceneGroup:insert( image2 )
	sceneGroup:insert( image3 )
	sceneGroup:insert( image4 )
	sceneGroup:insert( image5 )


	image2.touch = CreateInfo
	image3.touch = CreateInfo
	image4.touch = CreateInfo
	image5.touch = CreateInfo
---------------------------------------------------------------------------------





	local returnPress = widget.newButton
	 { 
		defaultFile = "Textures/returnPress.png",
		overFile = "Textures/returnPress.png",
		emboss = true,
		onPress = returnPress,
		--onRelease = button1Release,
	 }
    sceneGroup:insert(returnPress)
	returnPress.x =  returnPress.width / 2 
	returnPress.y =  returnPress.height / 2

end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )
	
		local showMem = function()
			image2:addEventListener( "touch", image2 )
			image3:addEventListener( "touch", image3 )
			image4:addEventListener( "touch", image4 )
			image5:addEventListener( "touch", image5 )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
		
		print( "1: hide event, phase will" )
		
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
	end
end


function scene:destroy( event )
	print( "((destroying scene 1's view))" )
	
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
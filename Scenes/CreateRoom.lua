require "Libs.PhotonTool"
---------------------------------------------------------------------------------
--
-- CreateRoom.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()



---------------------------------------------------------------------------------
local returnPress = function ( self,event )
	local name = "golf"..math.random(1,100)
	photonTool:CreateRoom(name)
	
	local username = photonTool:GetUser()
	photonTool:setName(username)
	
    
end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	

	


	
	sceneGroup:insert( image )
	
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
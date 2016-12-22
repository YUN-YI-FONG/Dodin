-----------------------------------------------------------------------------------------
--
-- Room.lua
--
-----------------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
---------------------------------------------------------------------------------
local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "", "slideLeft", 800  )
		return true
	end
end

---------------------------------------------------------------------------------
local returnPress = function ( self,event ) 
    composer.gotoScene( "Scenes.Lobby", "fade", 400 )
end
---------------------------------------------------------------------------------
function scene:create( event )

	local sceneGroup = self.view

	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Rooms.png" )
	image1.x = image1.width / 2 + 20
	image1.y = display.contentHeight/3.5

	image2 = display.newImage( "Textures/MainFarm.png" )
	image2.x = display.contentWidth / 1.7
	image2.y = display.contentHeight / 1.8

	image3 = display.newImage( "Textures/RoomTitle.png" )
	image3.x = display.contentWidth / 1.75 + 30
	image3.y = image3.height / 2  + 40

	image4 = display.newImage( "Textures/Room/RoomActor.png" )
	image4.x = display.contentWidth /2 - image4.width - 20
	image4.y = display.contentHeight/2.2

	image5 = display.newImage( "Textures/Room/RoomActor.png" )
	image5.x = display.contentWidth/2
	image5.y = display.contentHeight/2.2

	
	sceneGroup:insert( image  )
	sceneGroup:insert( image1 )
	sceneGroup:insert( image2 )
	sceneGroup:insert( image3 )
	sceneGroup:insert( image4 )
	sceneGroup:insert( image5 )
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
	returnPress.x = returnPress.width / 2
	returnPress.y = returnPress.height / 2

	local StartButton = widget.newButton
	{ 
		defaultFile = "Textures/Room/StartButton.png",
		overFile = "Textures/Room/StartButton_down.png",
		emboss = true,
		onPress = StartButton,
		--onRelease = button1Release,
 	}
    sceneGroup:insert(StartButton)
	StartButton.x = display.contentWidth/1.7
	StartButton.y = display.contentHeight/1.15

end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		 -- print( "1: show event, phase did" )
	
		local showMem = function()
		--	image6:addEventListener( "touch", image6 )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		--print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		--image6:removeEventListener( "touch", image6 )
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
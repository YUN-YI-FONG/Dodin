-----------------------------------------------------------------------------------------
--
-- Dodin.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local scene = composer.newScene()

function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "Scenes.Login", "slideLeft", 800  )
		return true
	end
end


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "Textures/Title/titleBG.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Title/titletext.png" )
	image1.x = display.contentWidth/4
	image1.y = display.contentHeight/4.2
	
	sceneGroup:insert( image )
	sceneGroup:insert( image1 )

	image.touch = onSceneTouch
	image1.touch = onSceneTouch
end

function scene:show( event )	
	local phase = event.phase
	if "did" == phase then
		print( "1: show event, phase did" )
		-- remove previous scene's view-
	-- Update Lua memory text display
		local showMem = function()
			image:addEventListener( "touch", image )
			
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
	
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
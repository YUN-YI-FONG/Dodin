--loading.lua

local widget= require("widget")
local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	--display.setDefault( "background", 0, 0, 0 )
	local bkground = display.newImage("Textures/background_shoot.png")
	bkground.x = display.contentCenterX
	bkground.y = display.contentCenterY
	sceneGroup:insert(bkground)
	local test = display.newText("Loading ...",display.contentWidth/1.2,display.contentHeight/1.1,nil,120)
	test:setTextColor(  0, 0, 1  )
		sceneGroup:insert( test )	
	end
function scene:show( event )
	local phase = event.phase 

	if "did" == phase then
		print( "1: show event, phase did" )
		if(name ~= "")then
			photonTool:SetUser(name)
		end
		timer.cancel(playernameTimer)
local showMem = function()
	
	
	end
		memTimer = timer.performWithDelay( 500, showMem, 1 )
	end	
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		print( "1: hide event, phase will" )
	
	

		timer.cancel(playernameTimer)
	end
end



function scene:destroy( event )
	print( "((destroying scene 1's view))" )
	
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene



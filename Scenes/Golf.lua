---------------------------------------------------------------------------------
--
--Glof.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local baseline = 280
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5
local physics = require( "physics" )
physics.start()
local physicsData = (require "physics3").physicsData(1.0)

--physics.setDrawMode( "hybrid" )
physics.setGravity( 0, 10 )
display.setStatusBar( display.HiddenStatusBar )
local golf
----------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	function fire( event )

	local t = event.target
	local phase = event.phase
	
		
	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true
		
		-- Stop current cueball motion, if any
		t:setLinearVelocity( 0, 0 )
		t.angularVelocity = 0

		

		
		myLine = nil

	elseif t.isFocus then
		
		if "moved" == phase then
			
			if ( myLine ) then
				myLine.parent:remove( myLine ) -- erase previous line, if any
			end
			myLine = display.newLine( t.x,t.y, event.x,event.y )
			myLine:setStrokeColor( 1, 1, 1, 50/255 )
			myLine.strokeWidth = 15

		elseif "ended" == phase or "cancelled" == phase then
		
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			
			
			if ( myLine ) then
				myLine.parent:remove( myLine )
			end
			print("t.x :"..event.x)
			-- Strike the ball!
			t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )	
		end
	end

	return true	-- Stop further propagation of touch event
end

	image = display.newImage( "Textures/BackgroundColor.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	image1 = display.newImage( "Textures/prospect.png" )
	image1.x =display.contentCenterX
	image1.y =display.contentHeight/2
	
	--image2 = display.newImage( "Textures/golf.png" )
	--image2.x =display.contentWidth/6
	--image2.y =display.contentHeight/1.47
	
	--image3 = display.newImage( "Textures/Frontscene.png" )
	--image3.x =display.contentCenterX
	--image3.y =display.contentHeight/1.5

	

	sceneGroup:insert( image )
	sceneGroup:insert( image1)
	--sceneGroup:insert( image2)
	--sceneGroup:insert( image3)
----------------------------------------------------------------------------------
local bar = display.newImage("Textures/Frontscene.png")
bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
bar.myName = "Frontscene"
physics.addBody( bar, "static", physicsData:get("Frontscene") )

function newgolf( ... )
	golf = display.newImage( "Textures/golf.png" )
	golf.x = display.contentWidth/6 ; golf.y = display.contentHeight/1.47
	physics.addBody( golf, { density=0.2, friction=0.8, bounce=0.4, radius=24 } )
	golf.isBullet = true
	golf.name = "golf" 	
	golf:addEventListener( "touch", fire )
end
function removegolf( ... )
	display.remove(golf)
end
	
local golf1 = display.newImage( "Textures/golf.png" )
golf1.x = display.contentWidth/1.185 ; golf1.y = display.contentHeight/1.63
physics.addBody( golf1,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
golf1.name = "golf1"
golf1.isVisible = false
local golf2 = display.newImage( "Textures/golf.png" )
golf2.x = display.contentWidth/1.34 ; golf2.y = display.contentHeight/1.25
physics.addBody( golf2,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
golf2.name = "golf2"
golf2.isVisible = false
newgolf()



---------------------------------------------------------------------------------

local Cloud = display.newImage( "Textures/Cloud.png" )
Cloud.anchorX = LEFT_REF
Cloud.x = 0
Cloud.y =baseline - 20

local Cloud2 = display.newImage( "Textures/Cloud.png" )
Cloud2.anchorX = LEFT_REF
Cloud2.x = 1080
Cloud2.y =baseline - 20

local tPrevious = system.getTimer()
local function move(event)
	local tDelta = event.time - tPrevious
	tPrevious = event.time

	local xOffset = ( 0.3 * tDelta )

	Cloud.x = Cloud.x - xOffset
	Cloud2.x = Cloud2.x - xOffset
	
	if (Cloud.x + Cloud.contentWidth) < 0 then
		Cloud:translate( 1400 *4, 0)
	end
	if (Cloud2.x + Cloud2.contentWidth) < 0 then
		Cloud2:translate( 1400 *2.5,0)
		end
	end
	Runtime:addEventListener( "enterFrame", move );
end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )


	
		local restart = function()
			if(golf)then
				if(golf.x>display.viewableContentWidth or golf.y > display.viewableContentHeight or golf.x<0) then
					removegolf()
					newgolf()
				end
				
			end
		end
		memTimer = timer.performWithDelay( 100, restart, 0 )
		

		local function onGlobalCollision( event )
		if ( event.phase == "began" ) then

			if  event.object1.name == "golf1" and event.object2.name == "golf"  then
			    print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  1  !!")
			    timer.cancel( memTimer )
				removegolf()
			    

			    
			elseif event.object1.name == "golf2" and event.object2.name == "golf" then
				print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  2  !!")
			    timer.cancel( memTimer )
			    removegolf()
			    

			   
			end
		end
	end
	Runtime:addEventListener( "collision", onGlobalCollision )
	
	end

	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
		physics.stop()
		
		Runtime:removeEventListener("touch")
		Runtime:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame")
		-- remove touch listener for image
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
	end
end


function scene:destroy( event )
	print( "((destroying scene 1's view))" )
	physics.stop()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
<<<<<<< HEAD
require "Libs.RoomPlayer"
require "View.ScoreView"
=======
<<<<<<< HEAD
require "Libs.RoomPlayer"
=======
>>>>>>> origin/master
>>>>>>> origin/master
---------------------------------------------------------------------------------
--
--Glof.lua
--
---------------------------------------------------------------------------------
<<<<<<< HEAD
local s = "0"
=======
<<<<<<< HEAD
local s = "0"
=======

>>>>>>> origin/master
>>>>>>> origin/master
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
<<<<<<< HEAD
local roomPlayer = RoomPlayer.new()
local scoreView = ScoreView.new(composer , widget)
=======
<<<<<<< HEAD
local roomPlayer = RoomPlayer.new()
>>>>>>> origin/master
--physics.setDrawMode( "hybrid" )
physics.setGravity( 0, 10 )
display.setStatusBar( display.HiddenStatusBar )

local golf
local score
local Cloud
local Cloud2
<<<<<<< HEAD
local gamestate = true
----------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	scoreView:Create()
=======
=======

--physics.setDrawMode( "hybrid" )
physics.setGravity( 0, 10 )
display.setStatusBar( display.HiddenStatusBar )
local golf
>>>>>>> origin/master
----------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
>>>>>>> origin/master
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
<<<<<<< HEAD
			--發射線條
=======
<<<<<<< HEAD
			--發射線條
=======
>>>>>>> origin/master
>>>>>>> origin/master
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

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
	image = display.newImage( "Textures/Games/BackgroundColor.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	image1 = display.newImage( "Textures/Games/prospect.png" )
	image1.x =display.contentCenterX
	image1.y =display.contentHeight/2
	
	image2 = display.newImage( "Textures/Games/bluePlayerInfo.png" )
	image2.x =display.contentWidth/8
	image2.y =display.contentHeight/7

	image3 = display.newImage( "Textures/Games/redPlayerInfo.png" )
	image3.x =display.contentWidth/1.13
	image3.y =display.contentHeight/7
<<<<<<< HEAD
=======
=======
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

>>>>>>> origin/master
>>>>>>> origin/master
	

	sceneGroup:insert( image )
	sceneGroup:insert( image1)
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
	sceneGroup:insert( image2)
	sceneGroup:insert( image3)
---------------------------------------------------------------------------------
--遊戲分數
score = display.newText(s,0,0,nil,50)
score.x = display.contentWidth/8.4
score.y = display.contentHeight/6.3

score2 = display.newText(s,0,0,nil,50)
score2.x = display.contentWidth/1.13
score2.y = display.contentHeight/6.3
----------------------------------------------------------------------------------
local bar = display.newImage("Textures/Games/Frontscene.png")
bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
bar.myName = "Frontscene"
physics.addBody( bar, "static", physicsData:get("Frontscene") )
sceneGroup:insert( bar)
--新增一顆高爾夫球
function newgolf( ... )
	golf = display.newImage( "Textures/Games/golf.png" )
<<<<<<< HEAD
=======
=======
	--sceneGroup:insert( image2)
	--sceneGroup:insert( image3)
----------------------------------------------------------------------------------
local bar = display.newImage("Textures/Frontscene.png")
bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
bar.myName = "Frontscene"
physics.addBody( bar, "static", physicsData:get("Frontscene") )

function newgolf( ... )
	golf = display.newImage( "Textures/golf.png" )
>>>>>>> origin/master
>>>>>>> origin/master
	golf.x = display.contentWidth/6 ; golf.y = display.contentHeight/1.47
	physics.addBody( golf, { density=0.2, friction=0.8, bounce=0.4, radius=24 } )
	golf.isBullet = true
	golf.name = "golf" 	
	golf:addEventListener( "touch", fire )
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
	sceneGroup:insert( golf)
end
--移除高爾夫球
function removegolf( ... )
	display.remove(golf)
end

--在洞口地下設置球點	
local golf1 = display.newImage( "Textures/Games/golf.png" )
<<<<<<< HEAD
=======
=======
end
function removegolf( ... )
	display.remove(golf)
end
	
local golf1 = display.newImage( "Textures/golf.png" )
>>>>>>> origin/master
>>>>>>> origin/master
golf1.x = display.contentWidth/1.185 ; golf1.y = display.contentHeight/1.63
physics.addBody( golf1,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
golf1.name = "golf1"
golf1.isVisible = false
<<<<<<< HEAD

local golf2 = display.newImage( "Textures/Games/golf.png" )
=======
<<<<<<< HEAD

local golf2 = display.newImage( "Textures/Games/golf.png" )
=======
local golf2 = display.newImage( "Textures/golf.png" )
>>>>>>> origin/master
>>>>>>> origin/master
golf2.x = display.contentWidth/1.34 ; golf2.y = display.contentHeight/1.25
physics.addBody( golf2,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
golf2.name = "golf2"
golf2.isVisible = false
newgolf()



---------------------------------------------------------------------------------

<<<<<<< HEAD
Cloud = display.newImage( "Textures/Games/Cloud.png" )
=======
<<<<<<< HEAD
Cloud = display.newImage( "Textures/Games/Cloud.png" )
=======
local Cloud = display.newImage( "Textures/Cloud.png" )
>>>>>>> origin/master
>>>>>>> origin/master
Cloud.anchorX = LEFT_REF
Cloud.x = 0
Cloud.y =baseline - 20

<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
Cloud2 = display.newImage( "Textures/Games/Cloud.png" )
Cloud2.anchorX = LEFT_REF
Cloud2.x = 1080
Cloud2.y =baseline - 20
sceneGroup:insert( Cloud)
sceneGroup:insert( Cloud2)
function removecloud( ... )
	display.remove(Cloud)
	display.remove(Cloud2)
end

	
	sceneGroup:insert( image2)
	sceneGroup:insert( image3)
	sceneGroup:insert( score)
	sceneGroup:insert( score2)
<<<<<<< HEAD
=======
=======
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
>>>>>>> origin/master
>>>>>>> origin/master
end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
		--遊戲時間倒數
		roomPlayer:gamecountdown(50,false,display.contentCenterX,display.contentHeight/8)
		local tPrevious = system.getTimer()

		--雲的移動
		local function move(event)
			local tDelta = event.time - tPrevious
			tPrevious = event.time

			local xOffset = ( 0.3 * tDelta )
			if (Cloud.x) then
				Cloud.x = Cloud.x - xOffset
				Cloud2.x = Cloud2.x - xOffset
			
			
				if (Cloud.x + Cloud.contentWidth) < 0 then
					Cloud:translate( 1400 *4, 0)
				end
				if (Cloud2.x + Cloud2.contentWidth) < 0 then
					Cloud2:translate( 1400 *2.5,0)
				end
			end
		end
	Runtime:addEventListener( "enterFrame", move );
	
		local restart = function()
			if(golf.x)then
				--超出範圍就從新開始,沒有天花板設置
<<<<<<< HEAD
=======
=======


	
		local restart = function()
			if(golf)then
>>>>>>> origin/master
>>>>>>> origin/master
				if(golf.x>display.viewableContentWidth or golf.y > display.viewableContentHeight or golf.x<0) then
					removegolf()
					newgolf()
				end
				
			end
		end
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
		
		
		Runtime:addEventListener("enterFrame",restart)
		--物體間碰撞
<<<<<<< HEAD
=======
=======
		memTimer = timer.performWithDelay( 100, restart, 0 )
		

>>>>>>> origin/master
>>>>>>> origin/master
		local function onGlobalCollision( event )
		if ( event.phase == "began" ) then

			if  event.object1.name == "golf1" and event.object2.name == "golf"  then
			    print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  1  !!")
<<<<<<< HEAD
			    
			    --遊戲分數得分
				s = s + 20 
				
=======
<<<<<<< HEAD
			    
			    --遊戲分數得分
				s = s + 20 
				score.text = s
>>>>>>> origin/master
				photonTool:setCustomProperty(false,s)
				removegolf()
				timer.performWithDelay( 200, newgolf , 1)
 				
<<<<<<< HEAD
=======
=======
			    timer.cancel( memTimer )
				removegolf()
			    

>>>>>>> origin/master
>>>>>>> origin/master
			    
			elseif event.object1.name == "golf2" and event.object2.name == "golf" then
				print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  2  !!")
<<<<<<< HEAD
			    
			    --遊戲分數得分
			    s = s + 20 
			   
			    photonTool:setCustomProperty(false,s)
			    removegolf()
			    timer.performWithDelay( 200, newgolf , 1)
=======
<<<<<<< HEAD
			    
			    --遊戲分數得分
			    s = s + 20 
			    score.text = s
			    photonTool:setCustomProperty(false,s)
			    removegolf()
			    timer.performWithDelay( 200, newgolf , 1)
=======
			    timer.cancel( memTimer )
			    removegolf()
			    
>>>>>>> origin/master
>>>>>>> origin/master

			   
			end
		end
	end
<<<<<<< HEAD
	--將碰撞加入監聽器
	Runtime:addEventListener( "collision", onGlobalCollision )
	local myId = photonTool:getId()	
	--取得對方的分數
	local enemygame = function()

		
		RoomActors = photonTool:GetRoomActorInfo()
		
		score.text = RoomActors[1].gamescore
		score2.text = RoomActors[2].gamescore
			
			
			
	end

		enemygameTimer = timer.performWithDelay( 20, enemygame, 0 )


	
	local gameend = function()

		RoomActors = photonTool:GetRoomActorInfo()
		
		if(RoomActors[1].gamestate == "end" and RoomActors[2].gamestate == "end") then
			if(gamestate) then
				scoreView:Show()
				local showgamescore = function()
			
					scoreView:PrintScore(RoomActors[1].gamescore, RoomActors[2].gamescore)
					gamestate = false
					timer.cancel(enemygameTimer)
					timer.cancel(gameendTimer)
				end
				timer.performWithDelay( 100, showgamescore, 1 )
			end
		end
		
			
	end

		gameendTimer = timer.performWithDelay( 200, gameend, 0 )
=======
<<<<<<< HEAD
	--將碰撞加入監聽器
	Runtime:addEventListener( "collision", onGlobalCollision )
	

	local showMem = function()
		local myId = photonTool:getId()	
		RoomActors = photonTool:GetRoomActorInfo()
		for i=1, #RoomActors do
			if(RoomActors[i].Num ~= myId) then
				score2.text = RoomActors[i].gamescore
			end
		end	
			
	end

		memTimer = timer.performWithDelay( 20, showMem, 0 )
=======
	Runtime:addEventListener( "collision", onGlobalCollision )
	
>>>>>>> origin/master
>>>>>>> origin/master
	end

	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/master
		
		roomPlayer:removeTime()
		Runtime:removeEventListener("touch")
		Runtime:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame",move)
		-- remove touch listener for image
		-- cancel timer
		removecloud()
<<<<<<< HEAD
		scoreView:RemoveSelf()
=======
		
=======
		physics.stop()
		
		Runtime:removeEventListener("touch")
		Runtime:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame")
		-- remove touch listener for image
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
>>>>>>> origin/master
>>>>>>> origin/master
	end
end


function scene:destroy( event )
	print( "((destroying scene 1's view))" )
<<<<<<< HEAD
	roomPlayer:removeTime()
	Runtime:removeEventListener("enterFrame",move)
	removecloud()
=======
<<<<<<< HEAD
	roomPlayer:removeTime()
	Runtime:removeEventListener("enterFrame",move)
	removecloud()
=======
	physics.stop()
>>>>>>> origin/master
>>>>>>> origin/master
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
require "View.ActorSlot"
require "Libs.RoomPlayer"
-----------------------------------------------------------------------------------------
--
-- Room.lua
--
-----------------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
local RoomInfo = {}
local RoomActors = {}
local ActorSlots = {}
local SlotPos = {
	{ x = 600 , y = 500 },
	{ x = 950 , y = 500 },
	{ x = 1300 , y = 500},
	{ x = 1650 , y = 500}
}
local roomPlayer = RoomPlayer.new()
local countdown = 1
---------------------------------------------------------------------------------
local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "", "slideLeft", 800  )
	end
end

---------------------------------------------------------------------------------
local returnPress = function ( self,event ) 
	photonTool:LeaveRoom()
    composer.gotoScene( "Scenes.Lobby", "fade", 400 )

end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
    -- Initalize Display
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


	sceneGroup:insert( image  ); sceneGroup:insert( image1 );
	sceneGroup:insert( image2 ); sceneGroup:insert( image3 );
 
---------------------------------------------------------------------------------

	local StartButton = function ( self,event ) 
		   photonTool:setCustomProperty("Ready")
		end

    local StandByButton = function ( self,event ) 
	   photonTool:setCustomProperty(false)
	end	


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

	StartButton = widget.newButton
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

	StartText  =  display.newText("準備",display.contentWidth*0.64,display.contentHeight*0.86,nil,70)
	sceneGroup:insert(StartText)

	function backgroundcount( ... )
		-- body
		rect1 = display.newRect( display.contentWidth*0.5, display.contentHeight*0.5, display.contentWidth, display.contentHeight )
		rect1:setFillColor(143/255, 143/255, 143/255)
		rect1.alpha = 0.5
		--sceneGroup:insert(rect1)
	end
	function removebackgroundcount( ... )
		display.remove(rect1)
	end
	
end
---------------------------------------------------------------------------------

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if "did" == phase then
	
		 -- print( "1: show event, phase did" )
	
		local showMem = function()
			-- 刷新房間資訊
			RoomInfo = photonTool:GetRoomInfo()
			if (RoomInfo.maxActors ~= 0 and next(ActorSlots) == nil) then
				for i=1, RoomInfo.maxActors do
					ActorSlots[i] = ActorSlot.new(composer, widget)
					ActorSlots[i]:SetPos( SlotPos[i] )
				end
			end
			-- 刷新玩家資訊
			RoomActors = photonTool:GetRoomActorInfo()
			if ( next(RoomActors) ~= nil and next(ActorSlots) ~= nil) then
			-- 全部清除
				for i=1, #ActorSlots do
					ActorSlots[i]:Reset()

				end
			-- 重新顯示
				for i=1, #RoomActors do
					ActorSlots[i]:Show( RoomActors[i] )
				end
			end
			for i=1 , #RoomActors do
				
				if(RoomActors[1].isReady == "Ready" and RoomActors[2].isReady == "Ready") then
					--removebackgroundcount()
					--backgroundcount()
					countdown = countdown + 1
					print(countdown)
					if(countdown == 2) then
						roomPlayer:gamecountdown(5,true)
					end
				end
			end

			
		end

		memTimer = timer.performWithDelay( 1000, showMem, 0 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase

	if "will" == phase then

		timer.cancel( memTimer ); memTimer = nil;
		-- 釋放資源
		for i=1, #ActorSlots do
			ActorSlots[i]:RemoveSelf()
		end
		roomPlayer:removeTime()
	end

	if "did" == phase then

	end
end


function scene:destroy( event )
	roomPlayer:removeTime()
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
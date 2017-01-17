require "Libs.RoomList"
require "Libs.PhotonTool"
---------------------------------------------------------------------------------
--
-- Lobby.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
local roomList = RoomList.new(composer , widget)
---------------------------------------------------------------------------------
local returnPress = function ( self,event ) 
    composer.gotoScene( "Scenes.MenuPage",  "fade",400 )
end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/RoomTitle.png" )
	image1.x = display.contentWidth/1.75
	image1.y = image1.height / 2  + 30

	image2 = display.newImage( "Textures/MainFarm.png" )
	image2.x = display.contentWidth/1.7
	image2.y = display.contentHeight/1.8

	image5 = display.newImage( "Textures/Rooms.png" )
	image5.x = image5.width / 2 + 20
	image5.y = display.contentHeight/3.5
	
	sceneGroup:insert( image )
	sceneGroup:insert( image1 )
	sceneGroup:insert( image5 )
	sceneGroup:insert( image2 )
	
	
	roomList:RoomTableView()
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
			local newRoomList = photonTool:GetRoomList()
			roomList:UpdateRoomList(newRoomList)
			print("Update?")

		end
		memTimer = timer.performWithDelay( 500, showMem, 0 )

	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
		roomList:RemoveTableview()
		roomList = nil
		
		print( "1: hide event, phase will" )
		
		
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
-----------------------------------------------------------------------------------------
--
-- MenuPage.lua
--
-----------------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

---------------------------------------------------------------------------------
local CreateRoom = function ( self,event ) 
    composer.gotoScene( "Scenes.CreateRoom", "fade", 400 )
end

local JoinLobby = function ( self,event ) 
    composer.gotoScene( "Scenes.Lobby",  "fade",400)
end

local FastJoin = function ( self,event ) 
    composer.gotoScene( "Scenes.Room", "fade", 400 )
end
---------------------------------------------------------------------------------
local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "", "slideLeft", 800  )
		return true
	end
end

local function onSceneTouch1( self, event )
	if event.phase == "began" then
		
		composer.gotoScene( "", "slideLeft", 800  )

		return true
	end
end

local function onSceneTouch2( self, event )
	if event.phase == "began" then
		composer.gotoScene( "", "slideLeft", 800  )
		return true
	end
end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Menu/rank.png" )
	image1.x =display.contentWidth/6
	image1.y =display.contentHeight/1.15

	image2 = display.newImage( "Textures/Menu/shops.png" )
	image2.x = display.contentWidth/2
	image2.y = display.contentHeight/1.15

	image3 = display.newImage( "Textures/Menu/sound_on.png" )
	image3.x = display.contentWidth / 1.2
	image3.y = display.contentHeight/1.15

	sceneGroup:insert( image )
	sceneGroup:insert( image1)	image1.touch = JoinLobby
	sceneGroup:insert( image2)	image2.touch = nil
	sceneGroup:insert( image3)	image3.touch = nil



	CreateroomText = display.newText("創建房間",0,0,native.systemFontBold,80)
	CreateroomText.x = display.contentWidth/6
	CreateroomText.y = display.contentHeight/2.5
	CreateroomText:setTextColor( 0.3, 0.3, 0.3 )

	JoinroomText = display.newText("加入房間",0,0,native.systemFontBold,80)
	JoinroomText.x = display.contentWidth/2
	JoinroomText.y = display.contentHeight/2.5
	JoinroomText:setTextColor( 1, 0.5, 0 )

	FastJoinText = display.newText("快速加入",0,0,native.systemFontBold,80)
	FastJoinText.x = display.contentWidth/1.2
	FastJoinText.y = display.contentHeight/2.5
	FastJoinText:setTextColor( 0, 0, 0.9 )
---------------------------------------------------------------------------------
	




	local CreateRoom = widget.newButton
	 { 
		defaultFile = "Textures/Menu/CreateRoom.png",
		overFile = "Textures/Menu/CreateRoom_down.png",
		emboss = true,
		onPress = CreateRoom,
		--onRelease = button1Release,
	 }
    
    sceneGroup:insert(CreateRoom)
    CreateRoom.x =display.contentWidth/6
	CreateRoom.y =display.contentHeight/2.5

	local JoinLobby = widget.newButton
	{ 
		defaultFile = "Textures/Menu/JoinLobby.png",
		overFile = "Textures/Menu/JoinLobby_down.png",
		emboss = true,
		onPress = JoinLobby,
		--onRelease = button1Release,
 	}
    sceneGroup:insert(JoinLobby)
    JoinLobby.x =display.contentWidth/2
	JoinLobby.y =display.contentHeight/2.5

	local FastJoin = widget.newButton
	{ 
		defaultFile = "Textures/Menu/fastjoin.png",
		overFile = "Textures/Menu/fastjoin_down.png",
		emboss = true,
		onPress = FastJoin,
		--onRelease = button1Release,
 	}
    sceneGroup:insert(FastJoin)
    FastJoin.x =display.contentWidth/1.2
	FastJoin.y =display.contentHeight/2.5


 	sceneGroup:insert(CreateroomText)
 	sceneGroup:insert(JoinroomText)
 	sceneGroup:insert(FastJoinText)
end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	composer.removeScene("Scenes.Login")
	if "did" == phase then
		--[[if(name ~= "")then
			photonTool:SetUser(name)
		end
		timer.cancel(playernameTimer)]]
		-- print( "1: show event, phase did" )
	
		local showMem = function()
			image:addEventListener( "touch", image )
			image1:addEventListener( "touch", image1 )
			image2:addEventListener( "touch", image2 )
			image3:addEventListener( "touch", image3 )
		end

		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		-- print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
		image1:removeEventListener( "touch", image1 )
		image2:removeEventListener( "touch", image2 )
		image3:removeEventListener( "touch", image3)

		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
		timer.cancel(playernameTimer)
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
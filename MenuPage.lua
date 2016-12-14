--MenuPage.lua
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()


---------------------------------------------------------------------------------
local CreateRoom = function ( self,event ) 
           composer.gotoScene( "CreateRoom", "fade", 400 )
end

local fastjoin = function ( self,event ) 
           composer.gotoScene( "fastjoin", "fade", 400 )
end

local JoinRoom = function ( self,event ) 
           composer.gotoScene( "JoinRoom", "fade", 400 )
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

	image1 = display.newImage( "Textures/rank.png" )
	image1.x =display.contentWidth/6
	image1.y =display.contentHeight/1.2

	image2 = display.newImage( "Textures/shops.png" )
	image2.x = display.contentWidth/1.85
	image2.y = display.contentHeight/1.2

	image3 = display.newImage( "Textures/sound_on.png" )
	image3.x = display.contentWidth/1.1
	image3.y = display.contentHeight/1.2

	sceneGroup:insert( image )
	sceneGroup:insert( image1)	image1.touch = onSceneTouch
	sceneGroup:insert( image2)	image2.touch = onSceneTouch1
	sceneGroup:insert( image3)	image3.touch = onSceneTouch2
---------------------------------------------------------------------------------

local CreateRoom = widget.newButton
 { 
	
	defaultFile = "Textures/CreateRoom.png",
	overFile = "Textures/CreateRoom_down.png",
	emboss = true,
	onPress = CreateRoom,
	--onRelease = button1Release,
 }
     sceneGroup:insert(CreateRoom)
    CreateRoom.x =display.contentWidth/6
	CreateRoom.y =display.contentHeight/2.5

	local fastjoin = widget.newButton
 { 
	
	defaultFile = "Textures/fastjoin.png",
	overFile = "Textures/fastjoin_down.png",
	emboss = true,
	onPress = fastjoin,
	--onRelease = button1Release,
 }
     sceneGroup:insert(fastjoin)
    fastjoin.x =display.contentWidth/1.85
	fastjoin.y =display.contentHeight/2.5

	local JoinRoom = widget.newButton
 { 
	
	defaultFile = "Textures/JoinRoom.png",
	overFile = "Textures/JoinRoom_down.png",
	emboss = true,
	onPress = JoinRoom,
	--onRelease = button1Release,
 }
     sceneGroup:insert(JoinRoom)
    JoinRoom.x =display.contentWidth/1.1
	JoinRoom.y =display.contentHeight/2.5
end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )
	
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
	
		print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
		image1:removeEventListener( "touch", image1 )
		image2:removeEventListener( "touch", image2 )
		image3:removeEventListener( "touch", image3)

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
--login.lua
require "Libs.DatabaseMysql"

local widget= require("widget")
local composer = require( "composer" )
local scene = composer.newScene()


local Register = function ( self,event ) 
    composer.gotoScene( "Scenes.Register", "fade", 400 )
end


function scene:create( event )
	local sceneGroup = self.view
	databaseMysql = DatabaseMysql.new(composer)
	image = display.newImage( "Textures/Title/titleBG.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Title/login1.png" )
	image1.x = display.contentCenterX
	image1.y = display.contentCenterY


-----------------------------------------------------------------------------------------	
	local Email = native.newTextField( display.contentWidth/1.90,482, 860, 60)
		  
		  Email:setTextColor(  0, 0, 0  )
		  Email.hasBackground = false

	local Password = native.newTextField( display.contentWidth/1.90,644, 860, 60)
		  
		  Password:setTextColor(  0, 0, 0  )
		  Password.hasBackground = false

		sceneGroup:insert( Email )
		sceneGroup:insert( Password )
		sceneGroup:insert( image )  	
		sceneGroup:insert( image1 )		
		
------------------------------------------------------------------------------------------
	
	function LoginPost()

		photonTool:SetAuthentication(Email.text , Password.text)
		photonTool:Connect()
		
		databaseMysql:Returnusername(Email.text)
		
		local username = function()
			name = databaseMysql:read("nickname.txt")
			
			if(name) then
				print("username timer: "..name)
			end
		end
		playernameTimer = timer.performWithDelay( 300, username, 0 )
		
		
			
			
		
		
	end

	local Login = widget.newButton
 	{ 
	
		defaultFile = "Textures/Title/login.png",
		overFile = "Textures/Title/login0.png",
		emboss = false,
		onPress = LoginPost,
		--onRelease = button1Release,
 	}
   	  	sceneGroup:insert(Login)
  	 	Login.x =display.contentWidth/1.5
		Login.y =display.contentHeight/1.2

	local Register = widget.newButton
 	{ 
	
		defaultFile = "Textures/Title/Register2.png",
		overFile = "Textures/Title/Register3.png",
		emboss = false,
		onPress = Register,
		--onRelease = button1Release,
 	}
   	  	sceneGroup:insert(Register)
  	 	Register.x =display.contentWidth/3
		Register.y =display.contentHeight/1.2
	
	end
function scene:show( event )
	local phase = event.phase

	if "did" == phase then
		print( "1: show event, phase did" )
local showMem = function()
	--image1:addEventListener( "touch", image1 )
	--image17:addEventListener( "touch", image17 )
	
	end
		memTimer = timer.performWithDelay( 500, showMem, 1 )
	end	
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then
		print( "1: hide event, phase will" )
	--image1:removeEventListener( "touch", image1 )
	--image17:removeEventListener( "touch", image17 )
	
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



--Register.lua
local widget= require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "Textures/Title/titleBG.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Title/Registerpanel.png" )
	image1.x = display.contentCenterX
	image1.y = display.contentCenterY
-----------------------------------------------------------------------------------------	
	local Country = native.newTextField( display.contentWidth/1.475,648, 265, 60)
		  
		  Country:setTextColor(  0, 0, 0  )
		  Country.hasBackground = false

	local Password = native.newTextField( display.contentWidth/1.94,390, 800, 60)
		  
		  Password:setTextColor(  0, 0, 0  )
		  Password.hasBackground = false

	local Email = native.newTextField( display.contentWidth/1.94,236, 800, 60)
		  
		  Email:setTextColor(  0, 0, 0  )
		  Email.hasBackground = false

	local Firstname = native.newTextField( display.contentWidth/2.38,540, 260, 60)
		  
		  Firstname:setTextColor(  0, 0, 0  )
		  Firstname.hasBackground = false

	local Lastname = native.newTextField( display.contentWidth/1.48,540, 260, 60)
		  
		  Lastname:setTextColor(  0, 0, 0  )
		  Lastname.hasBackground = false

	local Username = native.newTextField( display.contentWidth/2.38,650, 260, 60)
		  
		  Username:setTextColor(  0, 0, 0  )
		  Username.hasBackground = false

	local ConfirnPassword = native.newTextField( display.contentWidth/1.73,760, 650, 60)
		  
		  ConfirnPassword:setTextColor(  0, 0, 0  )
		  ConfirnPassword.hasBackground = false
		
		sceneGroup:insert( image )  	sceneGroup:insert( Username )  
		sceneGroup:insert( image1 )		sceneGroup:insert(ConfirnPassword)
		sceneGroup:insert(Country)
		sceneGroup:insert(Password)
		sceneGroup:insert(Email)
		sceneGroup:insert(Firstname)
		sceneGroup:insert(Lastname)
------------------------------------------------------------------------------------------

	local Cancel = widget.newButton
 	{ 
	
		defaultFile = "Textures/Title/Cancel2.png",
		overFile = "Textures/Title/Cancel3.png",
		emboss = false,
		onPress = Cancel,
		--onRelease = button1Release,
 	}
   	  	sceneGroup:insert(Cancel)
  	 	Cancel.x =display.contentWidth/1.5
		Cancel.y =display.contentHeight/1.2

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



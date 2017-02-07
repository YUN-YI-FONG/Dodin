--Register.lua
require "Libs.DatabaseMysql"
local widget= require("widget")
local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	databaseMysql = DatabaseMysql.new(composer)
	image = display.newImage( "Textures/Title/titleBG.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	image1 = display.newImage( "Textures/Title/Registerpanel.png" )
	image1.x = display.contentCenterX
	image1.y = display.contentCenterY
-----------------------------------------------------------------------------------------	
	local Country = native.newTextField( display.contentWidth/1.465,648, 280, 60)
		  
		  Country:setTextColor(  0, 0, 0  )
		  --Country.hasBackground = false

	local Password = native.newTextField( display.contentWidth/1.94,380, 845, 60)
		  
		  Password:setTextColor(  0, 0, 0  )
		  Password.hasBackground = false

	local Email = native.newTextField( display.contentWidth/1.94,222, 845, 60)
		  
		  Email:setTextColor(  0, 0, 0  )
		  Email.hasBackground = false

	local Firstname = native.newTextField( display.contentWidth/2.43,540, 275, 60)
		  
		  Firstname:setTextColor(  0, 0, 0  )
		  Firstname.hasBackground = false

	local Lastname = native.newTextField( display.contentWidth/1.465,540, 265, 60)
		  
		  Lastname:setTextColor(  0, 0, 0  )
		  Lastname.hasBackground = false

	local Username = native.newTextField( display.contentWidth/2.43,650, 270, 60)
		  
		  Username:setTextColor(  0, 0, 0  )
		  Username.hasBackground = false

	local ConfirnPassword = native.newTextField( display.contentWidth/1.72,770, 680, 60)
		  
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
	local Registerbut = function ( self,event )
<<<<<<< HEAD
		
=======
		--[[if(Password.text and ConfirnPassword.text) then
			if(Password.text == ConfirnPassword.text) then 
	    		databaseMysql:Register(Email.text,Password.text,Username.text)
	    	else
	    		function onComplete( event )
				    if ( event.action == "clicked" ) then
				    	
				        local i = event.index
				        
				        if ( i == 1 ) then
				          
						
				        elseif ( i == 2 ) then
				           
				        end
				    end
				end
				alert = native.showAlert( "Dodin", "確認密碼與原密碼不符.", {"OK"}, onComplete )
	    	end
	    end]]
>>>>>>> origin/master
	    function networkListener( event )
			if ( event.isError ) then
		        print( "Network error: ", event.response )
		    else
		    	
				print ( "Register RESPONSE: " .. event.response)
		       
		        --self.composer.gotoScene("Scenes.Login", "fade", 400)
	    	end
	    end
	
	local headers = {}
	headers["Content-Type"] = "application/x-www-form-urlencoded"
	headers["Accept-Language"] = "en-US"
	print(Email.text)
	local body2 = "email="..Email.text.."&password="..Password.text.."&nickname="..Username.text
			
	local params2 = {}
	params2.headers = headers
	params2.body = body2

	network.request( "http://trance.nctu.me/register.php", "POST", networkListener, params2 )
	end




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

	local Registerbut = widget.newButton
 	{ 
	
		defaultFile = "Textures/Title/Register2.png",
		overFile = "Textures/Title/Register3.png",
		emboss = false,
		onPress = Registerbut,
		--onRelease = button1Release,
 	}
   	  	sceneGroup:insert(Registerbut)
  	 	Registerbut.x =display.contentWidth/3
		Registerbut.y =display.contentHeight/1.2
	
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



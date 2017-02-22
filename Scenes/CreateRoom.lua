
---------------------------------------------------------------------------------
--
-- CreateRoom.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
local group = display.newGroup()
local group2 = display.newGroup()
local level
local pwd
local number
local leveltext,leveltext2,leveltext3
local pwdText 
local levelButton1,levelButton2,levelButton2
local playercount,playercount2
local radioButton1,radioButton2
local Create
local count 
---------------------------------------------------------------------------------
local returnPress = function ( self,event )
	
	display.remove(group)
	display.remove(pwd)
    composer.gotoScene("Scenes.MenuPage", "fade", 400)
end


function removeCreate( ... )
	
	if image6 ~= nil then
    	image6:removeSelf()
	end

	if pwd ~= nil then
    	pwd:removeSelf()
	end

	if level ~= nil then
		level:removeSelf()
	end

	if number ~= nil then
    	number:removeSelf()
	end

	if leveltext ~= nil then
    	leveltext:removeSelf()
	end

	if leveltext2 ~= nil then
    	leveltext2:removeSelf()
	end

	if leveltext3 ~= nil then
    	leveltext3:removeSelf()
	end

	if pwdText ~= nil then
    	pwdText:removeSelf()
	end

	if playercount ~= nil then
    	playercount:removeSelf()
	end

	if playercount2 ~= nil then
    	playercount2:removeSelf()
	end

	if levelButton1 ~= nil then
    	levelButton1:removeSelf()
	end

	if levelButton2 ~= nil then
    	levelButton2:removeSelf()
	end

	if levelButton3 ~= nil then
    	levelButton3:removeSelf()
	end

	if radioButton1 ~= nil then
    	radioButton1:removeSelf()
	end

	if radioButton2 ~= nil then
    	radioButton2:removeSelf()
	end

	if Create ~= nil then
    	Create:removeSelf()
	end

end
local CreateInfo = function( ... )
	
	removeCreate()

	group = display.newGroup()
	image6 = display.newImage( "Textures/Title/native1.png" )
	image6.x = display.contentWidth/1.8
	image6.y = display.contentHeight/1.7

	pwd = display.newText("密碼 : ", display.contentWidth/3.5,display.contentHeight/1.7,nil,80)
	pwd:setTextColor(  0, 0, 0  )
	group:insert(pwd)


	number = display.newText("人數 : ", display.contentWidth/3.5,display.contentHeight/1.3,nil,80)
	number:setTextColor(  0, 0, 0  )
	group:insert(number)

	level = display.newText("難度 : ",display.contentWidth/3.5,display.contentHeight/2.5,nil,80)
	level:setTextColor(  0, 0, 0  )
	group:insert(level)

	leveltext = display.newText("初級",display.contentWidth/1.88,display.contentHeight/2.5,nil,80)
	leveltext:setTextColor(  0, 0, 0  )
	group2:insert(leveltext)

	leveltext2 = display.newText("中級",display.contentWidth/1.45,display.contentHeight/2.5,nil,80)
	leveltext2:setTextColor(  0, 0, 0  )
	group2:insert(leveltext2)

	leveltext3 = display.newText("高級",display.contentWidth/1.19,display.contentHeight/2.5,nil,80)
	leveltext3:setTextColor(  0, 0, 0  )
	group2:insert(leveltext3)

	pwdText = native.newTextField( display.contentWidth/1.8,display.contentHeight/1.7, 500, 60)

	group:insert(pwdText)


	playercount = display.newText("2 人", display.contentWidth/1.88,display.contentHeight/1.28,nil,80)
	playercount:setTextColor(  0, 0, 0  )

	playercount2 = display.newText("4 人", display.contentWidth/1.45,display.contentHeight/1.28,nil,80)
	playercount2:setTextColor(  0, 0, 0  )

	function levelPress( event )
	    local switch = event.target
	    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	   	gamelevel = switch.id
	end

	--widget.newSwitch要把不同的類型的放在不同的group
	--要是放在相同的group會導致只有一個按鈕會被選到
	levelButton1 = widget.newSwitch(
	    {
	        left = 850,
	        top = 420,
	        style = "radio",
	        id = "初級",
	        onPress = levelPress
	    }
	)
	levelButton1.width = 100
	levelButton1.height = 100
	group2:insert( levelButton1 )

	levelButton2 = widget.newSwitch(
	    {
	        left = 1150,
	        top = 420,
	        style = "radio",
	        id = "中級",
	        onPress = levelPress
	    }
	)
	levelButton2.width = 100
	levelButton2.height = 100
	group2:insert( levelButton2 )

	levelButton3 = widget.newSwitch(
	    {
	        left = 1450,
	        top = 420,
	        style = "radio",
	        id = "高級",
	        onPress = levelPress
	    }
	)
	levelButton3.width = 100
	levelButton3.height = 100
	group2:insert( levelButton3 )

	function onSwitchPress( event )
	    local switch = event.target
	    print( "Switch with ID '"..switch.id.."' is on: "..tostring(switch.isOn) )
	    count = tonumber(switch.id)
	end
	radioButton1 = widget.newSwitch(
	    {
	        left = 850,
	        top = 830,
	        style = "radio",
	        id = "2",
	        onPress = onSwitchPress
	    }
	)
	radioButton1.width = 100
	radioButton1.height = 100
	group:insert( radioButton1 )
	
	radioButton2 = widget.newSwitch(
	    {
	        left = 1150,
	        top = 830,
	        style = "radio",
	        id = "4",
	        onPress = onSwitchPress
	    }
	)
	radioButton2.width = 100
	radioButton2.height = 100
	group:insert( radioButton2 )

	local Room = function( ... )
		local name = "golf"..math.random(1,100)
		photonTool:CreateRoom(name,count)
	
		local username = photonTool:GetUser()
		photonTool:setName(username)
		--設定遊戲的難度
		photonTool:setCustomProperty(false,false,false,gamelevel)
		 composer.gotoScene("Scenes.loading", "fade", 400)
	end

	Create = widget.newButton
 	{ 
	
		defaultFile = "Textures/Title/login.png",
		overFile = "Textures/Title/login0.png",
		emboss = false,
		onPress = Room,
		--onRelease = button1Release,
 	}
   	  	group:insert(Create)
  	 	Create.x =display.contentWidth/1.2
		Create.y =display.contentHeight/1.18

end
---------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view

	image = display.newImage( "Textures/LobbyBackground.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY

	

	image2 = display.newImage( "Textures/Create/Room_Football_icon.png" )
	image2.x = display.contentWidth/3.5
	image2.y = display.contentHeight/5


	image3 = display.newImage( "Textures/Create/Room_Glof_icon.png" )
	image3.x = display.contentWidth/2
	image3.y = display.contentHeight/5

	image4 = display.newImage( "Textures/Create/Room_Shoot_icon.png" )
	image4.x = display.contentWidth/1.45
	image4.y = display.contentHeight/5

	image5 = display.newImage( "Textures/Create/Room_WaterJump_icon.png" )
	image5.x = display.contentWidth/1.1
	image5.y = display.contentHeight/5
	
	sceneGroup:insert( image )
	sceneGroup:insert( image2 )
	sceneGroup:insert( image3 )
	sceneGroup:insert( image4 )
	sceneGroup:insert( image5 )


	image2.touch = CreateInfo
	image3.touch = CreateInfo
	image4.touch = CreateInfo
	image5.touch = CreateInfo
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
			image2:addEventListener( "touch", image2 )
			image3:addEventListener( "touch", image3 )
			image4:addEventListener( "touch", image4 )
			image5:addEventListener( "touch", image5 )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
		
		print( "1: hide event, phase will" )
		if image6 ~= nil then
    	image6:removeSelf()
	end

	removeCreate()
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
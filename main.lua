require "Libs.PhotonTool"
require "Libs.Classes"
-----------------------------------------------------------------------------------------
-- main.lua
-----------------------------------------------------------------------------------------
print("==============Game is running==============")
-- System Controller.
display.setStatusBar(display.HiddenStatusBar)
system.activate('multitouch')

-- Include Global module
CloudAppInfo = require("cloud-app-info")
photonTool = PhotonTool.new()

-- Include local module.
local composer = require( "composer" )
composer.recycleOnSceneChange = true -- Automatically remove scenes from memory

-- Create and link peer .
photonTool:Create()
playernameTimer =nil
name = nil
<<<<<<< HEAD
playerinfoTimer = nil
=======
<<<<<<< HEAD
playerinfoTimer = nil
=======

>>>>>>> origin/master
>>>>>>> origin/master
-- To Title scene.
composer.gotoScene( "Scenes.Dodin", frad,400)




<<<<<<< HEAD

=======
--[[display.setDefault("background", 0.2, 0.2, 0.4 )

-- Keep track of time in seconds
local secondsLeft = 5  -- 20 minutes * 60 seconds

local clockText = display.newText("05", display.contentCenterX, 80, native.systemFontBold, 80)
clockText:setFillColor( 0.7, 0.7, 1 )

local function updateTime()
	-- decrement the number of seconds
	secondsLeft = secondsLeft - 1
	
	-- time is tracked in seconds.  We need to convert it to minutes and seconds
	local minutes = math.floor( secondsLeft / 60 )
	local seconds = secondsLeft % 60
	
	-- make it a string using string format.  
	local timeDisplay = string.format( "%02d", seconds )
	clockText.text = timeDisplay
end

-- run them timer
local countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )]]
>>>>>>> origin/master
	

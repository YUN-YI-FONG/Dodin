require "Libs.PhotonTool"
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
photonTool:Connect()

-- To Title scene.
composer.gotoScene( "Scenes.Dodin", frad,400)
	

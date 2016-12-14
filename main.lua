-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
print("==============Game is running==============")
-- Hide the status bar.
display.setStatusBar(display.HiddenStatusBar)
-- Include Global module
require "Libs.PhotonTool"
photonTool = PhotonTool.new(30)

-- Include local module.
local composer = require( "composer" )

print(display.actualContentHeight)

photonTool:printX()

composer.gotoScene( "Dodin", frad,400)


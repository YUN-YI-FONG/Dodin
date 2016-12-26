---------------------------------------------------------------------------------
--
-- Lobby.lua
--
---------------------------------------------------------------------------------
local widget = require("widget")
local composer = require( "composer" )
local scene = composer.newScene()
---------------------------------------------------------------------------------
local function onSceneTouch( self, event )
	if event.phase == "began" then
		composer.gotoScene( "Scenes.Room", "slideLeft", 800  )
		return true
	end
end
---------------------------------------------------------------------------------
local returnPress = function ( self,event ) 
    composer.gotoScene( "Scenes.MenuPage", "fade", 400 )
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

	image3 = display.newImage( "Textures/Lobby/Room.png" )
	image3.x = display.contentWidth/1.7
	image3.y = display.contentHeight/3.5

	image4 = display.newImage( "Textures/Lobby/Room.png" )
	image4.x = display.contentWidth/1.7
	image4.y = display.contentHeight/1.8

	image5 = display.newImage( "Textures/Rooms.png" )
	image5.x = image5.width / 2 + 20
	image5.y = display.contentHeight/3.5

	image6 = display.newImage( "Textures/Lobby/Enter.png" )
	image6.x = display.contentWidth/1.1
	image6.y = display.contentHeight/3.5


	
	sceneGroup:insert( image )
	sceneGroup:insert( image1 )
	sceneGroup:insert( image5 )
	sceneGroup:insert( image2 )
	sceneGroup:insert( image3 )
	sceneGroup:insert( image4 )
	sceneGroup:insert( image6 )	image6.touch = onSceneTouch
	
---------------------------------------------------------------------------------
--每一欄位要插入的物件
local function onRowRender( event )
        local row = event.row
        local rowIndex=row.index
        local groupContentWidth = row.contentWidth
        local groupContentHeight = row.contentHeight

        rowimg = display.newImage( "Textures/Lobby/Room.png" )
        rowimg.x =groupContentWidth*0.5
        rowimg.y = groupContentHeight*0.5
        row:insert(rowimg)
        rowenterbut = display.newImage( "Textures/Lobby/Enter.png" )
		rowenterbut.x = groupContentWidth*0.91
		rowenterbut.y = groupContentHeight*0.5
		row:insert(rowenterbut)
    ---------------------------------------------------------------------------------

    end
    -- Create the widget
    tableView = widget.newTableView{
        left =display.contentHeight*0.392,
        top = 170,
        height = display.contentHeight*0.8,
        width = display.contentWidth*0.74,
        hideBackground = true,
        listener = tableViewListener,
        onRowRender = onRowRender,
       --onRowTouch = onRowTouch,
        --listener = scrollListener
    }
    sceneGroup:insert(tableView)
           
    
    for i = 1, 5 do
        local params={}
        local isCategory = false
        local rowHeight = 230
        local rowColor = {default={1,1,1,0}}
        local lineColor = { 0.5, 0.5, 0.5 }
        
        
        params.isCategory= false
        params.rowHeight = 230
        params.rowColor = rowColor
        
        tableView:insertRow(params)

    end




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
			image6:addEventListener( "touch", image6 )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
	
		-- remove touch listener for image
		image6:removeEventListener( "touch", image6 )
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
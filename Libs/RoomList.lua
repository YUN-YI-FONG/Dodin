require ('Module.RoomInfo')
RoomList = class()
    RoomList.widget = nil   
    RoomList.composer = nil
	RoomList.TableView = nil
	RoomList.row = nil 
	RoomList.rowIndex = nil
    RoomList.ContentWidth = nil
	RoomList.ContentHeight = nil
	RoomList.params = nil
	RoomList.rowColor = nil
	RoomList.lineColor = nil
    RoomList.group = nil
    RoomList.IconList = {
        "Textures/Lobby/Room_Glof_icon.png",
        "Textures/Lobby/Room_WaterJump_icon.png",
        "Textures/Lobby/Room_Football_icon.png",
        "Textures/Lobby/Room_Shoot_icon.png",
    }

function RoomList:Ctor( composer , widget )
	-- Initialize
    self.composer = composer
	self.widget = widget
	self.params = {}

end


--顯示房間列表
function RoomList:RoomTableView(...)
    -- RoomList Group
    self.group = display.newGroup()
    self.RoomInfoList = photonTool:GetRoomList()

    print(self.RoomInfoList)

    function onRowRender( event )
        -- init render
        local row = event.row
        local rowIndex = row.index
        self.ContentWidth = row.contentWidth
        self.ContentHeight = row.contentHeight

        -- get data and render
        local roomInfo = self.RoomInfoList[rowIndex]

        local rowbg = display.newImage( "Textures/Lobby/Room.png" )
        rowbg.x = self.ContentWidth * 0.5
        rowbg.y = self.ContentHeight * 0.5

        local rowbtn = display.newImage( "Textures/Lobby/Enter.png" )
        rowbtn.x = self.ContentWidth * 0.91
        rowbtn.y = self.ContentHeight * 0.5

        local roomName = display.newText( roomInfo.name, 0 , 0 , native.systemFont,50)
        roomName.x = self.ContentWidth * 0.4
        roomName.y = self.ContentHeight * 0.2
        roomName:setFillColor(0/255,0/255,0/255)

        local creator = display.newText( roomInfo.creator or "system", 0, 0, nil, 50)
        creator.x =  self.ContentWidth * 0.2
        creator.y =  self.ContentHeight * 0.7
        creator:setFillColor(0/255,0/255,0/255)

        local iconType = display.newImage( self.IconList[roomInfo.gameType]) 
        iconType.x = self.ContentWidth * 0.42
        iconType.y = self.ContentHeight * 0.7

        local state = display.newText( roomInfo:GetState(), 0, 0, nil, 40)
        state.x =  self.ContentWidth *0.59
        state.y =  self.ContentHeight *0.7
        state:setFillColor(0/255,0/255,0/255)

        local actorCount = display.newText( roomInfo.actorCount .. " / " .. roomInfo.maxActors, 0, 0, nil, 45)
        actorCount.x = self.ContentWidth * 0.75
        actorCount.y = self.ContentHeight * 0.7
        actorCount:setFillColor(0/255,0/255,0/255)

        row:insert( rowbg )
        row:insert( rowbtn )
        row:insert( roomName )
        row:insert( creator )
        row:insert( iconType )
        row:insert( state )
        row:insert( actorCount )
    end


    function onRowTouch( event )
        local phase = event.phase
        local row = event.row
        local rowIndex = row.index
        username = photonTool:GetUser()
        print("測試")
        photonTool:setName(username)
        photonTool:JoinRoom(self.RoomInfoList[rowIndex].name)
        self.composer.gotoScene( "Scenes.loading",  "fade",400 )
        print("joinroom:".. self.RoomInfoList[rowIndex].name)
        

    end


    -- Create the widget
    self.TableView = self.widget.newTableView{
        left = display.contentHeight*0.392,
        top = 170,
        height = display.contentHeight*0.8,
        width = display.contentWidth*0.74,
        hideBackground = true,
        listener = tableViewListener,
        onRowRender = onRowRender,
        onRowTouch = onRowTouch,
        
    }
    self.group:insert(self.TableView)
           
    
    for i = 1, #self.RoomInfoList do
        
        self.rowColor = {default={1,1,1,0}}
        self.lineColor = { 0.5, 0.5, 0.5 }
        
        
        self.params.isCategory= false
        self.params.rowHeight = 230
        self.params.rowColor = self.rowColor
        
        self.TableView:insertRow(self.params)

    end
end


--更新房間列表
function RoomList:UpdateRoomList( rooms )
    self.TableView:deleteAllRows()
    self.RoomInfoList = rooms
    for i = 1 , #rooms do
        self.rowColor = {default={1,1,1,0}}
        self.lineColor = { 0.5, 0.5, 0.5 }
        
        
        self.params.isCategory= false
        self.params.rowHeight = 230
        self.params.rowColor = self.rowColor
        
        self.TableView:insertRow(self.params)

    end
end

--移除tableview
function RoomList:RemoveTableview()
    self.TableView:removeSelf()
	
end



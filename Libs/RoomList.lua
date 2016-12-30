require "Libs.Classes"
--require "Libs.PhotonTool"
RoomList = class()
	RoomList.TableView = nil
	RoomList.row = nil 
	RoomList.rowIndex = nil
    RoomList.groupContentWidth = nil
	RoomList.groupContentHeight = nil
	RoomList.rowTitle = nil
	RoomList.params = nil
	RoomList.rowHeight = nil
	RoomList.rowColor = nil
	RoomList.lineColor = nil
    RoomList.group = nil
    RoomList.roomlisttable = {}
function RoomList:Ctor( ... )
	-- Initialize
	self.widget = require("widget")
	self.params = {}

end

function RoomList:RoomTableView(...)
    self.group = display.newGroup()
    roomlisttable = photonTool:GetRoomList()
    print(#roomlisttable)
    if(true) then
    
    	--每一欄位要插入的物件
        function onRowRender( event )
            local state
            local imggamemode
            self.row = event.row
            self.rowIndex=self.row.index
            self.groupContentWidth = self.row.contentWidth
            self.groupContentHeight = self.row.contentHeight
            --local creatorname = photonTool:GetUser()

            local roomname = display.newText(roomlisttable[self.rowIndex][1],0,0,nil,50)
            roomname.x =  self.groupContentWidth*0.4
            roomname.y =  self.groupContentHeight*0.2
            roomname:setFillColor(0/255,0/255,0/255)
            
            local creator = display.newText("system",0,0,nil,50)
            creator.x =  self.groupContentWidth*0.2
            creator.y =  self.groupContentHeight*0.7
            creator:setFillColor(0/255,0/255,0/255) 

            if(roomlisttable[self.rowIndex][4] == "1") then
                imggamemode = display.newImage( "Textures/Lobby/Room_Glof_icon.png" )
                imggamemode.x =  self.groupContentWidth*0.42
                imggamemode.y =  self.groupContentHeight*0.7
            else
                imggamemode = display.newImage( "Textures/Lobby/Room_Glof_icon.png" )
                imggamemode.x =  self.groupContentWidth*0.42
                imggamemode.y =  self.groupContentHeight*0.7
            end

            if(roomlisttable[self.rowIndex][2] == roomlisttable[self.rowIndex][3])then
                state = display.newText("不可進入",0,0,nil,40)
                state.x =  self.groupContentWidth*0.59
                state.y =  self.groupContentHeight*0.7
                state:setFillColor(0/255,0/255,0/255)
            else
                state = display.newText("可進入",0,0,nil,45)
                state.x =  self.groupContentWidth*0.59
                state.y =  self.groupContentHeight*0.7
                state:setFillColor(0/255,205/255,102/255)
            end

            local player = display.newText(roomlisttable[self.rowIndex][3].." / "..roomlisttable[self.rowIndex][2],0,0,nil,45)
            player.x =  self.groupContentWidth*0.75
            player.y =  self.groupContentHeight*0.7
            player:setFillColor(0/255,0/255,0/255)

            local rowenter = display.newImage( "Textures/Lobby/Room.png" )
            rowenter.x =self.groupContentWidth*0.5
            rowenter.y = self.groupContentHeight*0.5
            self.row:insert(rowenter)
            local rowenterbut = display.newImage( "Textures/Lobby/Enter.png" )
            rowenterbut.x = self.groupContentWidth*0.91
            rowenterbut.y = self.groupContentHeight*0.5
            self.row:insert(rowenterbut)
            self.row:insert(imggamemode)
            self.row:insert(player)
            self.row:insert(state)
            self.row:insert(creator)
            self.row:insert(roomname)
        ---------------------------------------------------------------------------------

        end
        -- Create the widget
        self.TableView = self.widget.newTableView{
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
        self.group:insert(self.TableView)
               
        
        for i = 1, #roomlisttable do
            
            self.rowColor = {default={1,1,1,0}}
            self.lineColor = { 0.5, 0.5, 0.5 }
            
            
            self.params.isCategory= false
            self.params.rowHeight = 230
            self.params.rowColor = self.rowColor
            
            self.TableView:insertRow(self.params)

        end
	end
end



function RoomList:RemoveTableview()
        self.TableView:removeSelf()
	
end



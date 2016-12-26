require "Libs.Classes"

RoomList = class()
	TableView = nil
	row = nil 
	rowIndex = nil
    groupContentWidth = nil
	groupContentHeight = nil
	rowTitle = nil
	params = nil
	rowHeight = nil
	rowColor = nil
	lineColor = nil
    group = nil

function RoomList:Ctor( ... )
	-- Initialize
	self.widget = require("widget")
	self.params = {}

end

function RoomList:RoomTableView(...)
    self.group = display.newGroup()

	--每一欄位要插入的物件
    local function onRowRender( event )
        self.row = event.row
        self.rowIndex=self.row.index
        self.groupContentWidth = self.row.contentWidth
        self.groupContentHeight = self.row.contentHeight

        local rowimg = display.newImage( "Textures/Lobby/Room.png" )
        rowimg.x =self.groupContentWidth*0.5
        rowimg.y = self.groupContentHeight*0.5
        self.row:insert(rowimg)
        local rowenterbut = display.newImage( "Textures/Lobby/Enter.png" )
        rowenterbut.x = self.groupContentWidth*0.91
        rowenterbut.y = self.groupContentHeight*0.5
        self.row:insert(rowenterbut)
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
           
    
    for i = 1, 5 do
        
        self.rowColor = {default={1,1,1,0}}
        self.lineColor = { 0.5, 0.5, 0.5 }
        
        
        self.params.isCategory= false
        self.params.rowHeight = 230
        self.params.rowColor = self.rowColor
        
        self.TableView:insertRow(self.params)

    end
	
end



function RoomList:RemoveTableview()
        self.TableView:removeSelf()
	
end

function RoomList:Register( email,password,username,age,country,gender,firstname,lastname )
	


end

function RoomList:RegisterError( errorMsg )


end


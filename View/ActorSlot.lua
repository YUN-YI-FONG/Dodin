ActorSlot = class()
    ActorSlot.composer = nil
    ActorSlot.widget = nil
    ActorSlot.group = nil
    ActorSlot.face = nil
    ActorSlot.name = nil
    ActorSlot.score = nil
    ActorSlot.isReady = nil

function ActorSlot:Ctor(composer , widget)
    -- Init ActorSlot
    self.composer = composer
    self.widget = widget
    self.group = display.newGroup()
    -- Draw ActorSlot
    local bg = display.newImage("Textures/Room/RoomActor.png")
    -- Draw Face
    local options = {width = 277,height = 337,numFrames = 2,sheetContentWidth = 554,sheetContentHeight= 337}

    local faceSheet = graphics.newImageSheet( "Textures/Room/unknow.png", options )
    local faceData = {
        { name = "hide" , frames= {1}, time = 300},
        { name = "show" , frames= {2}, time = 300},
    }

    local face = display.newSprite( faceSheet, faceData )
    face.x = -5; face.y = -118
    -- NameField --
    local name = display.newText( "", 0, 100, nil, 40 )
    name:setFillColor(0/255,0/255,0/255)
    -- ScoreField --
    local score = display.newText( "", 0, 170, nil , 40)
    score:setFillColor( 0/255, 0/255, 255/255)
    -- ReadyField -- 
    local isReady = display.newText( "" , 0, 240, nil , 40)
    isReady:setFillColor( 255/255, 0/255, 0/255 )



    self.face = face;   self.name = name;
    self.score = score; self.isReady = isReady;


    self.group:insert(bg);   self.group:insert(face);
    self.group:insert(name); self.group:insert(score);
    self.group:insert(isReady);
end

--設定位置
function ActorSlot:SetPos( pos )
    self.group.x = pos.x
    self.group.y = pos.y
end

--顯示玩家
function ActorSlot:Show( roomActor )
    self.face:setSequence("show")
    self.name.text = roomActor.name
    self.score.text = roomActor.score
    self.isReady.text = roomActor.isReady

end

--清除所有玩家
function ActorSlot:Reset()
    self.face:setSequence("hide")
    self.face.x = -5; self.face.y = -118;
    self.name.text = ""
    self.score.text = ""
    self.isReady.text = ""

end

--移除玩家顯示
function ActorSlot:RemoveSelf()
    self.face = nil
    self.name = nil
    self.score = nil
    self.isReady = nil
    self.group:removeSelf()
end
require "Libs.Classes"
--require "Libs.PhotonTool"
RoomPlayer = class()
    RoomPlayer.widget = nil
    RoomPlayer.composer = nil
<<<<<<< HEAD
=======
	RoomPlayer.name = nil
    RoomPlayer.picture= nil
    RoomPlayer.playergroup = nil
    RoomPlayer.state = nil
>>>>>>> origin/master
    RoomPlayer.secondsLeft = nil
    RoomPlayer.seconds = nil
    RoomPlayer.clockText = nil
    RoomPlayer.group = nil
    RoomPlayer.rect1 = nil
    RoomPlayer.countdown = nil
function RoomPlayer:Ctor( ... )
	-- Initialize
	self.widget = require("widget")
    self.composer = require ("composer")
	self.secondsLeft = 5

end

<<<<<<< HEAD


--倒數計時
function RoomPlayer:gamecountdown( time,bkground,countX,countY )
=======
function RoomPlayer:player(username1,user1X,user1Y,username2,user2X,user2Y)
   

    self.name = display.newText(username,userX,userY,nil,38)
    self.name:setFillColor(0/255,0/255,0/255) 
    self.player1name = display.newText(username1,user1X,user1Y,nil,38)
    if(username2) then
        self.player2name = display.newText(username2,user2X,user2Y,nil,38)
    end
    self.picture = display.newImage("Textures/Room/unknow.png",imgX,imgY)

    
end

function RoomPlayer:gamestate(stateX,stateY)
   

    self.state = display.newText("Ready !!",stateX,stateY,nil,38)
   self.state:setFillColor(255/255,0/255,0/255) 
    
end

function RoomPlayer:gamecountdown( time,bkground )
>>>>>>> origin/master
    self.group = display.newGroup()
    if(bkground)then
        self.rect1 = display.newRect( display.contentWidth*0.5, display.contentHeight*0.5, display.contentWidth, display.contentHeight )
        self.rect1:setFillColor(143/255, 143/255, 143/255)
<<<<<<< HEAD
        --alpha透明度
=======
>>>>>>> origin/master
        self.rect1.alpha = 0.5
        self.group:insert(self.rect1)
    end


    self.secondsLeft = time  

<<<<<<< HEAD
    self.clockText = display.newText(time, display.contentCenterX, display.contentCenterY, native.systemFontBold, 120)
    --時間 x ,y 座標
    if(countX and countY) then
        self.clockText.x = countX
        self.clockText.y = countY
    end

    self.clockText:setFillColor( 0.7, 0.7, 1 )
    self.group:insert(self.clockText)
    function updateTime()
        
        self.secondsLeft = self.secondsLeft - 1
       
        self.seconds = self.secondsLeft % 60
        
        -- 將seconds轉成字串
        local timeDisplay = string.format( "%02d", self.seconds )
        self.clockText.text = timeDisplay
        if(timeDisplay == "00")then
            if(bkground)then
                self.composer.gotoScene("Scenes.Golf", "fade", 400)
                
            else
                self.composer.gotoScene("Scenes.Dodin", "fade", 400)
            end
=======
    self.clockText = display.newText("05", display.contentCenterX, display.contentCenterY, native.systemFontBold, 120)
    self.clockText:setFillColor( 0.7, 0.7, 1 )
    self.group:insert(self.clockText)
    function updateTime()
        -- decrement the number of seconds
        self.secondsLeft = self.secondsLeft - 1
        
        -- time is tracked in seconds.  We need to convert it to minutes and seconds
       
        self.seconds = self.secondsLeft % 60
        
        -- make it a string using string format.  
        local timeDisplay = string.format( "%02d", self.seconds )
        self.clockText.text = timeDisplay
        if(timeDisplay == "00")then
            
            self.composer.gotoScene("Scenes.Golf", "fade", 400)
            
            print("golf")
            
>>>>>>> origin/master
        end
    end

    -- run them timer
    self.countdown = timer.performWithDelay( 1000, updateTime, self.secondsLeft )
end

function RoomPlayer:removeTime()
    
    timer.cancel(self.countdown)
    
    self.clockText = nil
    self.rect1 = nil
    self.group:removeSelf()
    
end

<<<<<<< HEAD

=======
function RoomPlayer:startstate( ... )
    if(self.state) then
        self.state:removeSelf()
    end
end
>>>>>>> origin/master

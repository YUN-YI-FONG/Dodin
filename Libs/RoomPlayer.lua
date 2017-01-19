require "Libs.Classes"
--require "Libs.PhotonTool"
RoomPlayer = class()
    RoomPlayer.widget = nil
    RoomPlayer.composer = nil
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



--倒數計時
function RoomPlayer:gamecountdown( time,bkground,countX,countY )
    self.group = display.newGroup()
    if(bkground)then
        self.rect1 = display.newRect( display.contentWidth*0.5, display.contentHeight*0.5, display.contentWidth, display.contentHeight )
        self.rect1:setFillColor(143/255, 143/255, 143/255)
        --alpha透明度
        self.rect1.alpha = 0.5
        self.group:insert(self.rect1)
    end


    self.secondsLeft = time  

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



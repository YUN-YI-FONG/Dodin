ScoreView = class()
	ScoreView.composer = nil
	ScoreView.widget = nil
	ScoreView.group = nil
	ScoreView.blue = nil
	ScoreView.blueScore = nil
	ScoreView.red = nil
	ScoreView.redScore = nil
	ScoreView.rebut = nil
function ScoreView:Ctor(composer , widget)
	self.composer = composer
	self.widget = widget
end

function ScoreView:Create()	
	-- Init
	local group = display.newGroup()
	group.x = display.contentCenterX; group.y = display.contentCenterY;
	local bg = display.newImage("Textures/ScoreView/background.png")
	bg.width = 0 ; bg.isVisible = true

	-- Blue Area
	local blue = display.newImage("Textures/ScoreView/score_blue.png")
	blue.x = -400 ; blue.y = -200; blue.isVisible = false
	local blueScoreOption = {
		text = "",
		x = -450,
		y = -60,
		width = 600,
		fontSize = 100,
		align = "right",
	}
	local blueScore = display.newText( blueScoreOption )

	-- Red Area
	local red = display.newImage("Textures/ScoreView/score_red.png")
	red.x = 400 ; red.y = -200; red.isVisible = false

	local redScoreOption = {
		text = "",
		x = 340,
		y = -60,
		width = 600,
		fontSize = 100,
		align = "right",
	}


	local redScore = display.newText( redScoreOption )


	function ReturnMenu( event )
 
	    if ( "ended" == event.phase ) then
	    	photonTool:LeaveRoom()
	        self.composer.gotoScene( "Scenes.MenuPage",  "fade",400)
	    end
	end

	local rebut = self.widget.newButton(
	    {
	        left = -200,
	        top = 200,
	        id = "button1",
	        label = "Return Menu",
	        onEvent = ReturnMenu,
	        fontSize = 100,
	        labelColor = { default={ 1, 1, 1 }},

	    }
	)
	rebut.isVisible = false
	group:insert(bg);
	group:insert(blue); group:insert(blueScore)
	group:insert(red); group:insert( redScore )
	group:insert(rebut);
	self.group = group;	self.bg = bg; 
	self.blue = blue ; self.blueScore = blueScore;
	self.red = red ; self.redScore = redScore;
	self.rebut = rebut

end

function ScoreView:PrintScore( bScore, rScore )
	-- 第三階段 計算分數
	local blueScore = 0;  local redScore = 0;

	local step3 = function ()
		blueScore = blueScore + bScore / 20
		redScore = redScore + rScore / 20

		self.blueScore.text = tostring( blueScore ) 
		self.redScore.text = tostring( redScore )
	end
	timer.performWithDelay( 4, step3, 20)

end


function ScoreView:Show()
	self.bg.isVisible = true
	self.bg.width = 0

	-- 第一階段 展開Panel
	local step1 = function ()
		self.bg.width = self.bg.width + 192
	end
	timer.performWithDelay( 1, step1 , 10)

	-- 第二階段 顯示組件
	local step2 = function ()
		self.blue.isVisible = true; self.red.isVisible = true;
		self.blueScore.text = "0"; self.redScore.text = "0";
		self.rebut.isVisible = true;
	end
	timer.performWithDelay(500, step2 )
end

function ScoreView:Hide()


end

function ScoreView:RemoveSelf()
	self.blue = nil; self.red = nil
	self.blueScore = nil ; self.redScore = nil
	self.rebut = nil
	self.group:removeSelf()

end
require "Libs.RoomPlayer"
require "View.ScoreView"
---------------------------------------------------------------------------------
--
--Glof.lua
--
---------------------------------------------------------------------------------
local s = "0"
local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local baseline = 280
local TOP_REF = 0
local BOTTOM_REF = 1
local LEFT_REF = 0
local RIGHT_REF = 1
local CENTER_REF = 0.5
local physics = require( "physics" )
physics.start()
local physicsData

RoomActors = photonTool:GetRoomActorInfo()

--判斷遊戲難度決定匯入物理鋼體
if (RoomActors[1].level == "初級") then
	physicsData = (require "physics3").physicsData(1.0)
	
elseif (RoomActors[1].level  == "中級") then
	physicsData = (require "physics4").physicsData(1.0)
	
elseif (RoomActors[1].level  == "高級") then
	physicsData = (require "physics5").physicsData(1.0)
	
end

local roomPlayer = RoomPlayer.new()
local databaseMysql = DatabaseMysql.new()
local scoreView = ScoreView.new(composer , widget)
--physics.setDrawMode( "hybrid" )
physics.setGravity( 0, 10 )
display.setStatusBar( display.HiddenStatusBar )

local golf
local score
local Cloud
local Cloud2
local gamestate = true
local teamscore1 
local teamscore2
----------------------------------------------------------------------------------
function scene:create( event )
	local sceneGroup = self.view
	scoreView:Create()
	function fire( event )

	local t = event.target
	local phase = event.phase
	
		
	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true
		
		-- Stop current cueball motion, if any
		t:setLinearVelocity( 0, 0 )
		t.angularVelocity = 0

		

		
		myLine = nil

	elseif t.isFocus then
		
		if "moved" == phase then
			
			if ( myLine ) then
				myLine.parent:remove( myLine ) -- erase previous line, if any
			end
			--發射線條
			myLine = display.newLine( t.x,t.y, event.x,event.y )
			myLine:setStrokeColor( 1, 1, 1, 50/255 )
			myLine.strokeWidth = 15

		elseif "ended" == phase or "cancelled" == phase then
		
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			
			
			if ( myLine ) then
				myLine.parent:remove( myLine )
			end
			print("t.x :"..event.x)
			-- Strike the ball!
			t:applyForce( (t.x - event.x), (t.y - event.y), t.x, t.y )	
		end
	end

	return true	-- Stop further propagation of touch event
end
	
	
	image = display.newImage( "Textures/Games/BackgroundColor.png" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	image1 = display.newImage( "Textures/Games/prospect.png" )
	image1.x =display.contentCenterX
	image1.y =display.contentHeight/2
	
	image2 = display.newImage( "Textures/Games/bluePlayerInfo.png" )
	image2.x =display.contentWidth/8
	image2.y =display.contentHeight/7

	image3 = display.newImage( "Textures/Games/redPlayerInfo.png" )
	image3.x =display.contentWidth/1.13
	image3.y =display.contentHeight/7
	

	sceneGroup:insert( image )
	sceneGroup:insert( image1)
	sceneGroup:insert( image2)
	sceneGroup:insert( image3)
---------------------------------------------------------------------------------
	--遊戲分數
	score = display.newText(s,0,0,nil,50)
	score.x = display.contentWidth/8.4
	score.y = display.contentHeight/6.3

	score2 = display.newText(s,0,0,nil,50)
	score2.x = display.contentWidth/1.13
	score2.y = display.contentHeight/6.3
----------------------------------------------------------------------------------

	--判斷遊戲難度 選擇遊戲關卡圖片
	if (RoomActors[1].level  == "初級") then

		local bar = display.newImage("Textures/Games/Frontscene.png")
		bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
		bar.myName = "Frontscene"
		physics.addBody( bar, "static", physicsData:get("Frontscene") )
		sceneGroup:insert( bar)
		
	elseif (RoomActors[1].level  == "中級") then

		local bar = display.newImage("Textures/Games/Frontscene2.png")
		bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
		bar.myName = "Frontscene2"
		physics.addBody( bar, "static", physicsData:get("Frontscene2") )
		sceneGroup:insert( bar)

	elseif (RoomActors[1].level  == "高級") then

		local bar = display.newImage("Textures/Games/Frontscene3.png")
		bar.x = display.contentCenterX; bar.y = display.contentHeight/1.5
		bar.myName = "Frontscene3"
		physics.addBody( bar, "static", physicsData:get("Frontscene3") )
		sceneGroup:insert( bar)

	end

--新增一顆高爾夫球
	function newgolf( ... )
		golf = display.newImage( "Textures/Games/golf.png" )
		golf.x = display.contentWidth/6 ; golf.y = display.contentHeight/1.47
		physics.addBody( golf, { density=0.2, friction=0.8, bounce=0.4, radius=24 } )
		golf.isBullet = true
		golf.name = "golf" 	
		golf:addEventListener( "touch", fire )
		sceneGroup:insert( golf)
	end
--移除高爾夫球
	function removegolf( ... )
		display.remove(golf)
	end

--在洞口地下設置球點	
	local golf1 = display.newImage( "Textures/Games/golf.png" )
	physics.addBody( golf1,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
	golf1.name = "golf1"
	golf1.isVisible = false

	local golf2 = display.newImage( "Textures/Games/golf.png" )
	physics.addBody( golf2,  "static" , { density=2.9, friction=0.5, bounce=0.7, radius=24 } )
	golf2.name = "golf2"
	golf2.isVisible = false
	newgolf()

	--判斷遊戲難度 決定進球位置
	if(RoomActors[1].level  == "初級")then
		golf1.x = display.contentWidth/1.185 ; golf1.y = display.contentHeight/1.63
		golf2.x = display.contentWidth/1.34 ; golf2.y = display.contentHeight/1.25
	elseif(RoomActors[1].level  == "中級")then
		golf1.x = display.contentWidth/1.175 ; golf1.y = display.contentHeight/1.63
		golf2.x = display.contentWidth/2.09 ; golf2.y = display.contentHeight/1.33
	elseif(RoomActors[1].level  == "高級")then
		golf1.x = display.contentWidth/1.192 ; golf1.y = display.contentHeight/1.65
		golf2.x = display.contentWidth/2.1 ; golf2.y = display.contentHeight/1.33
	end
---------------------------------------------------------------------------------

	Cloud = display.newImage( "Textures/Games/Cloud.png" )
	Cloud.anchorX = LEFT_REF
	Cloud.x = 0
	Cloud.y =baseline - 20

	Cloud2 = display.newImage( "Textures/Games/Cloud.png" )
	Cloud2.anchorX = LEFT_REF
	Cloud2.x = 1080
	Cloud2.y =baseline - 20
	sceneGroup:insert( Cloud)
	sceneGroup:insert( Cloud2)
	function removecloud( ... )
		display.remove(Cloud)
		display.remove(Cloud2)
	end

	
	sceneGroup:insert( image2)
	sceneGroup:insert( image3)
	sceneGroup:insert( score)
	sceneGroup:insert( score2)
end
---------------------------------------------------------------------------------

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "1: show event, phase did" )
		--遊戲時間倒數
		roomPlayer:gamecountdown(50,false,display.contentCenterX,display.contentHeight/8)
		local tPrevious = system.getTimer()

		--雲的移動
		local function move(event)
			local tDelta = event.time - tPrevious
			tPrevious = event.time

			local xOffset = ( 0.3 * tDelta )
			if (Cloud.x) then
				Cloud.x = Cloud.x - xOffset
				Cloud2.x = Cloud2.x - xOffset
			
			
				if (Cloud.x + Cloud.contentWidth) < 0 then
					Cloud:translate( 1400 *4, 0)
				end
				if (Cloud2.x + Cloud2.contentWidth) < 0 then
					Cloud2:translate( 1400 *2.5,0)
				end
			end
		end
	Runtime:addEventListener( "enterFrame", move );
	
		local restart = function()
			if(golf.x)then
				--超出範圍就從新開始,沒有天花板設置
				if(golf.x>display.viewableContentWidth or golf.y > display.viewableContentHeight or golf.x<0) then
					removegolf()
					newgolf()
				end
				
			end
		end
		
		
		Runtime:addEventListener("enterFrame",restart)
		--物體間碰撞
		local function onGlobalCollision( event )
		if ( event.phase == "began" ) then
			
			if  event.object1.name == "golf1" and event.object2.name == "golf"  then
			    print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  1  !!")
			    
			    --遊戲分數得分
				s = s + 20 
				 --把自己得分傳到photon伺服器
				photonTool:setCustomProperty(false,s)
				removegolf()
				timer.performWithDelay( 200, newgolf , 1)
 				
			    
			elseif event.object1.name == "golf2" and event.object2.name == "golf" then
				print( "event.object1 :",event.object1.name )       --the first object in the collision
			    print( "event.object2  :",event.object2.name )       --the second object in the collision
			    print("success  2  !!")
			    
			    --遊戲分數得分
			    s = s + 20 
			   
			   --把自己得分傳到photon伺服器
			    photonTool:setCustomProperty(false,s)
			    removegolf()
			    timer.performWithDelay( 200, newgolf , 1)

			   
			end
		end
	end
	--將碰撞加入監聽器
	Runtime:addEventListener( "collision", onGlobalCollision )
	local myId = photonTool:getId()	
	--取得對方的分數
	local enemygame = function()

		
		RoomActors = photonTool:GetRoomActorInfo()
		if(#RoomActors == 2) then
			score.text = RoomActors[1].gamescore
			score2.text = RoomActors[2].gamescore
		elseif(#RoomActors == 4)then
			--玩家1分數
			grade1 = tonumber(RoomActors[1].gamescore)
			--玩家2分數
			grade2 = tonumber(RoomActors[2].gamescore)
			--玩家3分數
			grade3 = tonumber(RoomActors[3].gamescore)
			--玩家4分數
			grade4 = tonumber(RoomActors[4].gamescore)

			--團隊1分數
			team1 = grade1+grade2
			--團隊2分數
			team2 = grade3+grade4


			--分數顯示
			score.text =tostring(team1)
			score2.text =tostring(team2)
		end
			
			
			
	end

		enemygameTimer = timer.performWithDelay( 20, enemygame, 0 )


	
	local gameend = function()

		RoomActors = photonTool:GetRoomActorInfo()
		--判斷玩家人數
		if(#RoomActors == 2)then
			--判斷玩家都是否結束狀態
			if(RoomActors[1].gamestate == "end" and RoomActors[2].gamestate == "end") then
				--判斷gamestate是否有執行過 
				if(gamestate) then
					scoreView:Show()
					local showgamescore = function()
						--顯示結算畫面
						scoreView:PrintScore(RoomActors[1].gamescore, RoomActors[2].gamescore)
						gamestate = false
						--取得自己的名稱
						local nickname = photonTool:GetUser()
						--判斷誰是開房者 是開房者就把遊戲分數資訊上傳
						if(RoomActors[1].name == nickname) then
							--把分數從字串轉成整數
							teamscore1 = tonumber(score.text)
							teamscore2 = tonumber(score2.text)
							--上傳分數
							if(RoomActors[1].gamescore>RoomActors[2].gamescore)then
								databaseMysql:savescore(1,RoomActors[1].name,100)

							elseif(RoomActors[1].gamescore<RoomActors[2].gamescore)then
								databaseMysql:savescore(1,RoomActors[2].name,100)
							else
								databaseMysql:savescore(2,RoomActors[1].name,50,RoomActors[2].name,50)
							end
							--記錄遊戲資訊
							databaseMysql:saverecord(2,teamscore1,teamscore2,RoomActors[1].name,RoomActors[2].name)
						end
						timer.cancel(enemygameTimer)
						timer.cancel(gameendTimer)
					end
					timer.performWithDelay( 100, showgamescore, 1 )
				end
			end
		elseif(#RoomActors == 4)then
			if(RoomActors[1].gamestate == "end" and RoomActors[2].gamestate == "end" and RoomActors[3].gamestate == "end" and RoomActors[4].gamestate == "end") then
				if(gamestate) then
					scoreView:Show()
					local showgamescore = function()
						--顯示結算畫面
						scoreView:PrintScore(score.text,score2.text)
						gamestate = false
						--取得自己的名稱
						local nickname = photonTool:GetUser()
						--判斷誰是開房者 是開房者就把遊戲分數資訊上傳
						if(RoomActors[1].name == nickname) then
							--把分數從字串轉成整數
							teamscore1 = tonumber(score.text)
							teamscore2 = tonumber(score2.text)
							--上傳分數
							if( teamscore1 > teamscore2 ) then
								databaseMysql:savescore(2,RoomActors[1].name,100,RoomActors[2].name,100)
							elseif( teamscore1 < teamscore2 ) then
								databaseMysql:savescore(2,RoomActors[3].name,100,RoomActors[4].name,100)
							else
								databaseMysql:savescore(4,RoomActors[1].name,50,RoomActors[2].name,50,RoomActors[3].name,50,RoomActors[4].name,50)
							end
							--記錄遊戲資訊
							databaseMysql:saverecord(4,teamscore1,teamscore2,RoomActors[1].name,RoomActors[2].name,RoomActors[3].name,RoomActors[4].name)
						end
						timer.cancel(enemygameTimer)
						timer.cancel(gameendTimer)
					end

					timer.performWithDelay( 100, showgamescore, 1 )
				end
			end
		end
	end

		gameendTimer = timer.performWithDelay( 200, gameend, 0 )
	end

	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		print( "1: hide event, phase will" )
		
		roomPlayer:removeTime()
		Runtime:removeEventListener("touch")
		Runtime:removeEventListener("collision")
		Runtime:removeEventListener("enterFrame",move)
		-- remove touch listener for image
		-- cancel timer
		removecloud()
		scoreView:RemoveSelf()
	end
end


function scene:destroy( event )
	print( "((destroying scene 1's view))" )
	roomPlayer:removeTime()
	Runtime:removeEventListener("enterFrame",move)
	removecloud()
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene
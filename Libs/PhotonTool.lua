require('Module.RoomInfo')
require('Module.RoomActor')

PhotonTool = class()
	-- Define Variables
	PhotonTool.Core = nil
	PhotonTool.LoadBalancingClient = nil
	PhotonTool.LoadBalancingConstants = nil
	PhotonTool.tableutil = nil
	PhotonTool.Logger = nil
	PhotonTool.client = nil

	PhotonTool.RoomList = {}
	

	----- STATES -----
	PhotonTool.INITIALIZED = "Initialized"
	PhotonTool.CREATED = "Created"
	PhotonTool.CONNECTING = "Connecting"
	PhotonTool.CONNECTED = "Connected"
	PhotonTool.DISCONNECTED = "Disconnected"
	----- /STATES -----
	PhotonTool.state = PhotonTool.INITIALIZED
	PhotonTool.END_CONNECTION_CODE = 100 -- TODO: get rid of this
	PhotonTool.ENDCONNECTION = false
	
<<<<<<< HEAD
	--創建房間的設定
	PhotonTool.basicRoomCreateOptions= {
=======

	PhotonTool.basicRoomCreateOptions= {
		maxPlayers = 2,

		customGameProperties = { 
			gameType = 1 , 
			creator = "nil"
		
		}
>>>>>>> origin/master

	}

	PhotonTool.basicRoomOptions =  {

	}

function PhotonTool:Ctor( ... )
	-- Initialize
	
	if (pcall(require, "plugin.photon")) then
		print ("Demo: main module:", "Corona plugin used")
		self.Core = require "plugin.photon"
		self.LoadBalancingClient = self.Core.loadbalancing.LoadBalancingClient
		self.LoadBalancingConstants = self.Core.loadbalancing.constants
		self.Logger = self.Core.common.Logger
		self.tableutil = self.Core.common.util.tableutil
	else  -- orload photon.lua module
	    print("Demo: main module:","Lua lib used")
	    self.Core= require("Libs.api.photon")
		self.LoadBalancingClient = require("photon.loadbalancing.LoadBalancingClient")
		self.LoadBalancingConstants = require("photon.loadbalancing.constants")
		self.Logger = require("photon.common.Logger")
		self.tableutil = require("photon.common.util.tableutil")
	end
end

function PhotonTool:Create(...)
	local composer = require("composer")
	local tool = self
	local client = self.LoadBalancingClient.new(CloudAppInfo.MasterAddress , CloudAppInfo.AppId, CloudAppInfo.AppVersion)
	-- client:setLogLevel(self.Logger.Level.FATAL)-- limits to fatal logs, remove to see what Photon is doing

	function client:onOperationResponse(errorCode, errorMsg, code, content)
		-- body
		print("onOperationResponse ec:",errorCode, "er:", errorMsg, "code:", code , "content:", content)
	end

	function client:onEvent( code , content , actNum)
		-- body
		print ("onEvent code:" , code , "content:", content, "actNum:", actNum)
	end

	--房間列表
	function client:onRoomList( rooms )
		local creator, gamemode, roomInfo
		local roomArray = {}

		-- Get RoomInfo from Photon
		for roomNum ,room in pairs(rooms) do
			-- GetCustomProperty
			creator = room:getCustomProperty("creator")
			gameType = room:getCustomProperty("gameType")
			-- Save to Module and add List
			roomInfo = RoomInfo.new(room.name , creator, room.maxPlayers, room.playerCount, gameType)
			roomArray[#roomArray + 1] =  roomInfo
		end

		tool.RoomList = roomArray

	end

	function client:onRoomListUpdate(rooms, roomsUpdated, roomsAdded, roomsRemoved)
		-- body
		self:onRoomList(rooms)
		print("onRoomListUpdate:", rooms)
	end

	function client:onStateChange( state )
		-- body
		print("State:", state , tostring(tool.LoadBalancingClient.StateToName(state)))
		
<<<<<<< HEAD
		--登入時會跑一長串,必須跑完能創建房間或是加入房間,因此在這邊做判斷在在登入時以及創建和加入房間跑完一長串才進行到下一個頁面
=======
>>>>>>> origin/master
		if(tostring(tool.LoadBalancingClient.StateToName(state)) == "JoinedLobby")then
			composer.gotoScene("Scenes.MenuPage", "fade", 400)
		end
		if(tostring(tool.LoadBalancingClient.StateToName(state)) == "Joined")then
			composer.gotoScene( "Scenes.Room",  "fade",400 )
		end
	end

	self.client = client
	self.state = self.CREATED
end

-----------------------
-- 連線相關 link function --
-----------------------
function PhotonTool:Connect()
	if (self.state == self.CREATED) then
		self.client.logger:info("Start")
		self.client:connectToRegionMaster("kr")
		self.runTimes = 0
		self.timerTable = timer.performWithDelay( 1000, self, 0 ) -- test table can be used to cancel timer
		self.state = self.CONNECTING
		
	end
end

function PhotonTool:Disconnect()
	self.client:disconnect()
end


function PhotonTool:RemoveSelf( ... )
	-- body
end

<<<<<<< HEAD
--photon驗證
=======
<<<<<<< HEAD
--photon驗證
=======
>>>>>>> origin/master
>>>>>>> origin/master
function PhotonTool:SetAuthentication(username , password)

	-- load AuthenticationType from LoadBalancingConstants
	local AuthenticationType = self.LoadBalancingConstants.CustomAuthenticationType

	print(username, password)
<<<<<<< HEAD
	
=======
<<<<<<< HEAD
	
=======
>>>>>>> origin/master
>>>>>>> origin/master
	self.client:setCustomAuthentication("username=".. username.."&password="..password, AuthenticationType.Custom )


	self:Connect()
end

-----------------------
-- 設定玩家相關 function --
-----------------------

function PhotonTool:SetUser(id)
	print("setUserId:"..id)
	self.client:setUserId(id)
end


function PhotonTool:GetUser()
	print("getUserId :", self.client:getUserId())
	return self.client:getUserId()
	
end

<<<<<<< HEAD
--設定玩家名稱
=======
<<<<<<< HEAD
--設定玩家名稱
=======

>>>>>>> origin/master
>>>>>>> origin/master
function PhotonTool:setName(name)
	self.client:myActor():setName(name)
end

<<<<<<< HEAD
--取得房間內的ID
function PhotonTool:getId()
	return self.client:myActor().actorNr
end
---------------------------
-- 房間運作相關 function --
---------------------------
--取得玩家資訊
=======
<<<<<<< HEAD
function PhotonTool:getId()
	return self.client:myActor().actorNr
=======
---------------------------
-- 房間運作相關 function --
---------------------------
>>>>>>> origin/master
function PhotonTool:GetRoomActorInfo()
	local actorArray = {} 
	local myRoomActors = self.client:myRoomActors()
	
	-- get data from photon 
	for actorNum, actor in pairs( myRoomActors ) do
<<<<<<< HEAD
		actorArray[#actorArray + 1] = RoomActor.new(actor.name , actor.Nr, actor:getCustomProperty("isReady"), actor:getCustomProperty("gamescore"),actor:getCustomProperty("gamestate"))
		--{actor.name,actor.actorNr,actor:getCustomProperty("isReady")}
		print(actor.name, actor.actorNr, actor:getCustomProperty("isReady"), actor:getCustomProperty("gamescore"),actor:getCustomProperty("gamestate"))
	end

	return actorArray 	
end

--設定遊戲房間內自定義的變數
function PhotonTool:setCustomProperty( playerstate,gamescore,gamestate )
=======
		actorArray[#actorArray + 1] = RoomActor.new(actor.name , actor.Nr, actor:getCustomProperty("isReady"))
		--{actor.name,actor.actorNr,actor:getCustomProperty("isReady")}
		print(actor.name, actor.actorNr, actor:getCustomProperty("isReady"))
	end

	return actorArray 	
>>>>>>> origin/master
end
---------------------------
-- 房間運作相關 function --
---------------------------
--取得玩家資訊
function PhotonTool:GetRoomActorInfo()
	local actorArray = {} 
	local myRoomActors = self.client:myRoomActors()
	
	-- get data from photon 
	for actorNum, actor in pairs( myRoomActors ) do
		actorArray[#actorArray + 1] = RoomActor.new(actor.name , actor.Nr, actor:getCustomProperty("isReady"), actor:getCustomProperty("gamescore"))
		--{actor.name,actor.actorNr,actor:getCustomProperty("isReady")}
		print(actor.name, actor.actorNr, actor:getCustomProperty("isReady"), actor:getCustomProperty("gamescore"))
	end

<<<<<<< HEAD
	return actorArray 	
end

--設定遊戲房間內自定義的變數
function PhotonTool:setCustomProperty( playerstate,gamescore )
>>>>>>> origin/master
	if(playerstate ~= false) then
		self.client:myActor():setCustomProperty("isReady", playerstate)
	end
	if(gamescore) then
		self.client:myActor():setCustomProperty("gamescore", gamescore)
<<<<<<< HEAD
		
	end
	if(gamestate) then
		self.client:myActor():setCustomProperty("gamestate", gamestate)
=======
>>>>>>> origin/master
	end
end


--取得房間資訊
<<<<<<< HEAD
function  PhotonTool:GetRoomInfo()
	-- Get Room
	local room = self.client:myRoom()
	local creator = room:getCustomProperty("creator")
	local gameType = room:getCustomProperty("gameType")

	local roomInfo = RoomInfo.new(room.name , creator, room.maxPlayers, room.playerCount, gameType)

	return roomInfo
=======
=======
function PhotonTool:setCustomProperty( playerstate )
	
	self.client:myActor():setCustomProperty("isReady", playerstate)
	
>>>>>>> origin/master
end
---------------------------
-- 大廳運作相關 function --
---------------------------

--創建房間
function PhotonTool:CreateRoom( roomName,playercount )
	-- 取得創建房間設定
	 
	

	self.basicRoomCreateOptions= {
		maxPlayers = 2,

		customGameProperties = { 
			gameType = 1 , 
			creator = "nil"
		
		}

	}
	local createOptions =self.basicRoomCreateOptions
	createOptions.customGameProperties.creator = "Yee"

	self.client:createRoom(roomName, createOptions)
end

--加入房間
function PhotonTool:JoinRoom( RoomName )
	self.client:joinRoom(RoomName, self.basicRoomOptions, self.basicRoomCreateOptions)
end

<<<<<<< HEAD
--離開房間
=======

>>>>>>> origin/master
function  PhotonTool:GetRoomInfo()
	-- Get Room
	local room = self.client:myRoom()
	local creator = room:getCustomProperty("creator")
	local gameType = room:getCustomProperty("gameType")

	local roomInfo = RoomInfo.new(room.name , creator, room.maxPlayers, room.playerCount, gameType)

	return roomInfo
end
---------------------------
-- 大廳運作相關 function --
---------------------------

<<<<<<< HEAD
--創建房間
=======
>>>>>>> origin/master
function PhotonTool:CreateRoom( roomName )
	-- 取得創建房間設定
	local createOptions = self.basicRoomCreateOptions
	createOptions.customGameProperties.creator = "Yee"

	self.client:createRoom(roomName, createOptions)
end

<<<<<<< HEAD
--加入房間
=======
>>>>>>> origin/master
function PhotonTool:JoinRoom( RoomName )
	self.client:joinRoom(RoomName, self.basicRoomOptions, self.basicRoomCreateOptions)
end

<<<<<<< HEAD
--離開房間
=======
>>>>>>> origin/master
>>>>>>> origin/master
function PhotonTool:LeaveRoom()
	self.client:leaveRoom()
end

<<<<<<< HEAD
--取得房間列表
=======
<<<<<<< HEAD
--取得房間列表
=======
>>>>>>> origin/master
>>>>>>> origin/master
function PhotonTool:GetRoomList()
	return self.RoomList
end

---------------------------
-- 常駐運作相關 function --
---------------------------
function PhotonTool:timer(event)
	local str = nul
	self:Update()

	if (self.ENDCONNECTION) then
		timer.cancel(event.source)
	end
end

function PhotonTool:Update()
	self.client:service()
end

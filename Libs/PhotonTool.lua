require "Libs.Classes"

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
	
	PhotonTool.basicRoomCreateOptions= {
		maxPlayers = 2,
		customGameProperties = { gamemode = 1}
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

	function client:onRoomList( rooms )
		local c 
		local roomArray = {}
		-- Get RoomInfo from Photon
		for k,v in pairs(rooms) do
			c= v:getCustomProperty("gamemode")
			roomArray[#roomArray + 1] =  {v.name,v.maxPlayers,v.playerCount,c}
			
			print(c)
		end

		tool.RoomList = roomArray

		print("onRoomList:", rooms , "Count:" , #roomArray)
	end

	function client:onRoomListUpdate(rooms, roomsUpdated, roomsAdded, roomsRemoved)
		-- body
		self:onRoomList(rooms)
	end

	function client:onStateChange( state )
		-- body
		print("State:", state , tostring(tool.LoadBalancingClient.StateToName(state)))
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
		self.client:connect()
		self.runTimes = 0
		self.timerTable = timer.performWithDelay( 100, self, 0 ) -- test table can be used to cancel timer
		self.state = self.CONNECTING
	end
end

function PhotonTool:Disconnect()
	self.client:disconnect()
end


function PhotonTool:RemoveSelf( ... )
	-- body
end



-----------------------
-- 設定玩家相關 function --
-----------------------

function PhotonTool:SetUser(id)
	print("setUserId:"..id)
	self.client:setUserId(id)
end


function PhotonTool:GetUser()
	print("getUserId :"..self.client:getUserId())
	return self.client:getUserId()
	
end

---------------------------
-- 大廳運作相關 function --
---------------------------

function PhotonTool:CreateRoom( ... )
	-- body
	
	self.client:createRoom(Roomname,self.basicRoomCreateOptions)
end

function PhotonTool:JoinRoom( ... )
	
end

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
		self.cancel(event.source)
	end
end

function PhotonTool:Update()
	self.client:service()
end

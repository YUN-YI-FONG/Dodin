require "Libs.Classes"

PhotonTool = class()
	-- Define Variables
	PhotonTool.Core = nil
	PhotonTool.LoadBalancingClient = nil
	PhotonTool.LoadBalancingConstants = nil
	PhotonTool.tableutil = nil
	PhotonTool.Logger = nil
	PhotonTool.client = nil
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
		-- body
		print("onRoomList:", rooms , "Count:" , table.getn(rooms))
	end

	function client:onStateChange( state )
		-- body
		print("State:", state , tostring(tool.LoadBalancingClient.StateToName(state)))
	end

	self.client = client
	self.state = self.CREATED
end

function PhotonTool:Connect()
	if (self.state == self.CREATED) then
		self.client.logger:info("Start")
		self.client:connect()
		self.runTimes = 0
		self.timerTable = timer.performWithDelay( 100, self, 0 ) -- test table can be used to cancel timer
		self.state = self.CONNECTING
	end
end

function PhotonTool:JoinRoom( ... )
	
end
<<<<<<< HEAD
=======

function PhotonTool:Disconnect()
	self.client:disconnect()
end

function PhotonTool:Update()
	self.client:service()
end


function PhotonTool:RemoveSelf( ... )
	-- body
end


function PhotonTool:timer(event)
	local str = nul
	self:Update()

	if (self.ENDCONNECTION) then
		self.cancel(event.source)
	end
end

function PhotonTool:SetUser(id)
	print("setUserId:"..id)
	self.client:setUserId(id)
>>>>>>> origin/master

function PhotonTool:Disconnect()
	self.client:disconnect()
end

<<<<<<< HEAD
function PhotonTool:Update()
	self.client:service()
end


function PhotonTool:RemoveSelf( ... )
	-- body
end


function PhotonTool:timer(event)
	local str = nul
	self:Update()

	if (self.ENDCONNECTION) then
		self.cancel(event.source)
	end
end
=======
function PhotonTool:GetUser()
	self.client:getUserId()
	print("getUserId :"..self.client:getUserId())
end
>>>>>>> origin/master

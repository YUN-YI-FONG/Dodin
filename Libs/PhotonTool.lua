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
	if (false) then
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

function PhotonTool:printX(...)
	print(self.DISCONNECTED)
end
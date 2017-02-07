require("Libs.Classes")
RoomInfo = class()
	RoomInfo.name = nil
	RoomInfo.creator = nil
	RoomInfo.maxActors = nil
	RoomInfo.actorCount = nil
	RoomInfo.gameType = nil
	RoomInfo.state = nil

function RoomInfo:Ctor( name , creator, maxActors, actorCount, gameType)
	self.name = name
	self.creator = creator
	self.maxActors = maxActors
	self.actorCount = actorCount
	self.gameType = gameType

	if (self.actorCount == self.maxActors) then
		self.state = "已額滿"
	else
		self.state = "可進入"
	end
end

function RoomInfo:GetState( )

	return self.state
end

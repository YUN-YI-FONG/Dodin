RoomActor = class()
	RoomActor.face = nil
	RoomActor.name = nil
	RoomActor.Num = nil
	RoomActor.score = nil
	RoomActor.isReady = nil
	
function RoomActor:Ctor ( name, actorNum, isReady)
	self.name = name
	self.score = score
	self.isReady = isReady or false
end



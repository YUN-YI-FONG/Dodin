RoomActor = class()
	RoomActor.face = nil
	RoomActor.name = nil
	RoomActor.Num = nil
	RoomActor.score = nil
	RoomActor.isReady = nil
	RoomActor.gamescore = nil
	RoomActor.gamestate = nil
function RoomActor:Ctor ( name, actorNum, isReady ,gamescore,gamestate)
	self.name = name
	self.score = score
	self.isReady = isReady or false
	self.gamescore = gamescore
	self.gamestate = gamestate
end



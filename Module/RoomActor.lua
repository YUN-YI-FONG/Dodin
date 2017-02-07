RoomActor = class()
	RoomActor.face = nil
	RoomActor.name = nil
	RoomActor.Num = nil
	RoomActor.score = nil
	RoomActor.isReady = nil
<<<<<<< HEAD
	RoomActor.gamescore = nil
	RoomActor.gamestate = nil
function RoomActor:Ctor ( name, actorNum, isReady ,gamescore,gamestate)
=======
<<<<<<< HEAD
	RoomActor.gamescore = nil
	RoomActor.gamestate = nil
function RoomActor:Ctor ( name, actorNum, isReady ,gamescore,gamestate)
=======
<<<<<<< HEAD
	RoomActor.gamescore = nil
function RoomActor:Ctor ( name, actorNum, isReady ,gamescore)
>>>>>>> origin/master
>>>>>>> origin/master
	self.name = name
	self.score = score
	self.isReady = isReady or false
	self.gamescore = gamescore
<<<<<<< HEAD
	self.gamestate = gamestate
=======
<<<<<<< HEAD
	self.gamestate = gamestate
=======
=======
	
function RoomActor:Ctor ( name, actorNum, isReady)
	self.name = name
	self.score = score
	self.isReady = isReady or false
>>>>>>> origin/master
>>>>>>> origin/master
>>>>>>> origin/master
end



require "Libs.Classes"

DatabaseMysql = class()
	
	DatabaseMysql.decodedData = nil
	DatabaseMysql.json = nil
	DatabaseMysql.myNewData = nil
	DatabaseMysql.phpresponse = nil
	DatabaseMysql.headers = nil
	DatabaseMysql.body = nil
	DatabaseMysql.body2 = nil
	DatabaseMysql.params = nil
	DatabaseMysql.params2 = nil
	DatabaseMysql.errormessage = nil
	DatabaseMysql.nickname = nil
	DatabaseMysql.path = nil
	DatabaseMysql.file = nil
	DatabaseMysql.content = nil
function DatabaseMysql:Ctor( composer )
	-- Initialize
	self.json = require ( "json" )
	self.composer =composer
	self.myNewData = {}
	self.decodedData = {}
	self.headers = {}
	self.headers["Content-Type"] = "application/x-www-form-urlencoded"
	self.headers["Accept-Language"] = "en-US"
	self.headers2 = {}
	self.headers2["Content-Type"] = "application/x-www-form-urlencoded"
	self.headers2["Accept-Language"] = "en-US"
	self.body = {}
	self.body2 = {}
	self.params = {}
	self.params2 = {}
	self.errormessage = {}
	self.nickname = ""

end


--儲存玩家名稱
function DatabaseMysql:Saveusername(email)
	
	function networkListener2( event )
		if ( event.isError ) then
			print( "Network error!" )
 	
		else
			self.myNewData = event.response
			print ( "From server: " .. self.myNewData)--印出json
			self.decodedData = self.json.decode(self.myNewData)
			if(self.decodedData) then
				self.nickname = self.decodedData[1]
			end
			--儲存到手機的file
			self:save(self.nickname)
			
			
		end
	end
	
					
	self.body = "email="..email
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://trance.nctu.me/username.php", "POST", networkListener2, self.params )
	
end



--儲存到手機的file
function DatabaseMysql:save( text )
	self.path = system.pathForFile("nickname.txt",system.DocumentsDirectory)
	self.file = io.open(self.path,"w")

	if (self.file) then
		self.file:write(text)
		io.close(self.file)
	end
end

--讀取手機內的file
function DatabaseMysql:read(filename)
	self.path = system.pathForFile(filename,system.DocumentsDirectory)
	self.file = io.open(self.path,"r")
	
	if (self.file) then
		self.content = self.file:read("*a")
		io.close(self.file)
	end
	
	return self.content
end


--儲存遊戲分數以及玩家
function DatabaseMysql:savescore(number,player1,score1,player2,score2,player3,score3,player4,score4)
	function networkListener( event )
		if ( event.isError ) then
			print( "Network error!" )
 	
		else
			print("success savescore!!")
			self.myNewData = event.response
			print ( "From server: " .. self.myNewData)--印出json
			
		end
	end
	
	if(number == 1)then				
		self.body = "number="..number.."&player1="..player1.."&score1="..score1
	elseif(number == 2)  then
		self.body = "number="..number.."&player1="..player1.."&score1="..score1.."&player2="..player2.."&score2="..score2
	elseif(number == 4) then
		self.body = "number="..number.."&player1="..player1.."&score1="..score1.."&player2="..player2.."&score2="..score2.."&player3="..player3.."&score3="..score3.."&player4="..player4.."&score4="..score4
	end
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://trance.nctu.me/updatescore.php", "POST", networkListener, self.params )
end

--儲存遊戲記錄()
function DatabaseMysql:saverecord(number,teamscore1,teamscore2,player1,player2,player3,player4)

	function networkListener( event )
		if ( event.isError ) then
			print( "Network error!" )
 	
		else
			print("success saverecord!!")
			self.myNewData = event.response
			print ( "From server: " .. self.myNewData)--印出json
			
		end
	end
	
	--以遊玩時間當作資料庫的主鍵
	local time = os.date("*t")
	local timeid = tostring(time.year)+tostring(time.month)+tostring(time.day)+tostring(time.hour)+tostring(time.min)+tostring(time.sec)
	local timeidnumber = tonumber(timeid)

	if(number == 2) then				
		self.body = "number="..number.."&redscore="..teamscore1.."&bluescore="..teamscore2.."&player1="..player1.."&player2="..player2.."&roomtime="..timeidnumber
	elseif(number == 4) then

		self.body = "number="..number.."&redscore="..teamscore1.."&bluescore="..teamscore2.."&player1="..player1.."&player2="..player2.."&player3="..player3.."&player4="..player4.."&roomtime="..timeidnumber
		
	end
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://trance.nctu.me/updaterecord.php", "POST", networkListener, self.params )

end
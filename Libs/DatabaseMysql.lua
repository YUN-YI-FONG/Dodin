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


<<<<<<< HEAD
--儲存玩家名稱
function DatabaseMysql:Saveusername(email)
	
=======
<<<<<<< HEAD
--儲存玩家名稱
function DatabaseMysql:Saveusername(email)
=======
<<<<<<< HEAD
--儲存玩家名稱
function DatabaseMysql:Saveusername(email)
=======

function DatabaseMysql:Returnusername(email)
>>>>>>> origin/master
>>>>>>> origin/master

>>>>>>> origin/master
	function networkListener2( event )
		if ( event.isError ) then
			print( "Network error!" )
 	
		else
			self.myNewData = event.response
			print ( "From server: " .. self.myNewData)--印出json
<<<<<<< HEAD
			self.decodedData = self.json.decode(self.myNewData)
			if(self.decodedData) then
				self.nickname = self.decodedData[1]
			end
			--儲存到手機的file
=======
			self.decodedData=self.json.decode(self.myNewData)
			if(self.decodedData)then
				self.nickname = self.decodedData[1]
			end
<<<<<<< HEAD
			--儲存到手機的file
=======
<<<<<<< HEAD
			--儲存到手機的file
=======
>>>>>>> origin/master
>>>>>>> origin/master
>>>>>>> origin/master
			self:save(self.nickname)
			
			
		end
	end
	
					
	self.body = "email="..email
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://trance.nctu.me/username.php", "POST", networkListener2, self.params )
	
end

<<<<<<< HEAD

=======
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
function DatabaseMysql:Register( email,password,nickname)
	
	function networkListener( event )
		if ( event.isError ) then
	        print( "Network error: ", event.response )
	    else
	    	self.myNewData = event.response
			print ( "Register RESPONSE: " .. self.myNewData)
	       
	        --self.composer.gotoScene("Scenes.Login", "fade", 400)
    	end
	end
	self.headers2["Content-Type"] = "application/x-www-form-urlencoded"
	self.headers2["Accept-Language"] = "en-US"
	print(email , password , nickname)
	self.body2 = "email="..email
			
	self.params2 = {}
	self.params2.headers = headers2
	self.params2.body = body2

	network.request( "http://140.131.12.56/test5.php", "POST", networkListener, self.params2 )

end

>>>>>>> origin/master
>>>>>>> origin/master

>>>>>>> origin/master

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



--[[function DatabaseMysql:savescore(player1,score,player2)
	function networkListener( event )
		if ( event.isError ) then
			print( "Network error!" )
 	
		else
			print("success !!")
			
			
		end
	end
	
					
	self.body = "email="..email
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://trance.nctu.me/updateScore.php", "POST", networkListener, self.params )
end]]
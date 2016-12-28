require "Libs.Classes"

DatabaseMysql = class()
	
	DatabaseMysql.decodedData = nil
	DatabaseMysql.json = nil
	myNewData = nil
	phpresponse = nil
	headers = nil
	body = nil
	params = nil
	errormessage = nil
	nickname = nil
	path = nil
	file = nil
	content = nil
function DatabaseMysql:Ctor( ... )
	-- Initialize
	self.json = require ( "json" )
	self.composer =require ("composer")
	self.myNewData = {}
	self.decodedData = {}
	self.headers = {}
	self.headers["Content-Type"] = "application/x-www-form-urlencoded"
	self.headers["Accept-Language"] = "en-US"
	self.body = {}
	self.params = {}
	self.errormessage = {}
	self.nickname = ""

end

function DatabaseMysql:Login(email,password)

	function networkListener( event )

		if ( event.isError ) then
	        print( "Network error: ", event.response )
		else
			
			self.myNewData = event.response
			print ( "RESPONSE: " .. event.response )
			self.decodedData=self.json.decode(self.myNewData)
			self.phpresponse= self.decodedData["ResultCode"]

	        if (self.phpresponse == 1) then
				self:Returnusername(email)
				--self.composer.gotoScene("Home")
				print("success")
			end
	    end
	end
	

	self.body = "email="..email.."&password="..password
	
	self.params = {}
	self.params.headers = self.headers
	self.params.body =self.body

	network.request( "http://140.131.12.56/Login22.php", "POST", networkListener, self.params )
end



function DatabaseMysql:Returnusername(email)

	function networkListener2( event )
		if ( event.isError ) then
			print( "Network error!" )
		else
			self.myNewData = event.response
			print ( "From server: " .. self.myNewData)--印出json
			self.decodedData=self.json.decode(self.myNewData)
			self.nickname = self.decodedData[1]["value"]
			self:save(self.nickname)
			
		end
	end
	
					
	self.body = "email="..email
					
	self.params = {}
	self.params.headers = self.headers
	self.params.body = self.body
					
	network.request( "http://140.131.12.56/username.php", "POST", networkListener2, self.params )
	
end

function DatabaseMysql:Register( email,password,username,age,country,gender,firstname,lastname )
	
	local function networkListener( event )
			if ( event.isError ) then
		        print( "Network error: ", event.response )
		    else

		        print ( "RESPONSE1: " .. event.response )

		        self.myNewData = event.response
			    self.decodedData=self.json.decode(self.myNewData)    
			            
			            
				if(self.myNewData == "correct")then
				--把country加到資料庫
					local function networkListener2( event )
						if ( event.isError ) then
					        print( "Network error: ", event.response )
					    else
					    	print ( "RESPONSE2: " .. event.response )
					    	composer.gotoScene("Home")		
					    end
					end
					
							
					local body2 = "email="..email.."&country="..country.."&firstname="..firstname.."&lastname="..lastname.."&gender="..gender
							
					local params = {}
					params.headers = headers
					params.body = body2

					network.request( "http://140.131.12.56/Register2.php", "POST", networkListener2, params )

	--------------------------------------------------------------------------------------------
							
				else
					--error
					--把錯誤的值插入到errormessage
					self:RegisterError(self.decodedData)
				end
	    	end
		end

				
		self.body = "email="..email.."&password="..password.."&username="..username.."&age="..age.."&country="..country.."&gender="..gender.."&firstname="..firstname.."&lastname="..lastname
				
		self.params = {}
		self.params.headers = headers
		self.params.body = body

		network.request( "http://140.131.12.56/Register.php", "POST", networkListener, params )

end

function DatabaseMysql:RegisterError( errorMsg )

	local j = 1
	for i=1,5 do
		if(errorMsg[i] == nil) then
				
		else
			table.insert(self.errormessage,j,errorMsg[i])
			j= j+1
		end
	end
			
	function onComplete( event )
		if ( event.action == "clicked" ) then
			local i = event.index
			if ( i == 1 ) then
			  	for j=#errorMsg,1,-1 do
					table.remove(self.errormessage,j)
				end
					
			elseif ( i == 2 ) then
			       
			end
		end
	end
			
	print(#self.errormessage)
	--顯示回傳錯誤訊息
	if(#self.errormessage == 5) then
		alert = native.showAlert( "Riddle Me There", self.errormessage[1].."\n"..self.errormessage[2].."\n"..self.errormessage[3].."\n"..self.errormessage[4].."\n"..self.errormessage[5], {"OK"}, onComplete )
	elseif(#self.errormessage == 4) then
		alert = native.showAlert( "Riddle Me There", self.errormessage[1].."\n"..self.errormessage[2].."\n"..self.errormessage[3].."\n"..self.errormessage[4], {"OK"}, onComplete )
	elseif(#self.errormessage == 3) then
		alert = native.showAlert( "Riddle Me There", self.errormessage[1].."\n"..self.errormessage[2].."\n"..self.errormessage[3], {"OK"}, onComplete )
	elseif(#self.errormessage == 2) then
		alert = native.showAlert( "Riddle Me There", self.errormessage[1].."\n"..self.errormessage[2], {"OK"}, onComplete )
	elseif(#self.errormessage == 1) then
		alert = native.showAlert( "Riddle Me There", self.errormessage[1], {"OK"}, onComplete )
	end
end

function DatabaseMysql:save( text )
	self.path = system.pathForFile("nickname.txt",system.DocumentsDirectory)
	self.file = io.open(self.path,"w")

	if (self.file) then
		self.file:write(text)
		io.close(self.file)
	end
end


function DatabaseMysql:read(filename)
	self.path = system.pathForFile(filename,system.DocumentsDirectory)
	self.file = io.open(self.path,"r")
	
	if (self.file) then
		self.content = self.file:read("*a")
		io.close(self.file)
	end
	
	return self.content
end
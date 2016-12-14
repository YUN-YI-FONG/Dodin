--------------------------------------------
-- Classes.lua
-- this is base class type.
--------------------------------------------

local _class = {}

function class(super)
	local class_type = {}
	class_type.Ctor = false
	class_type.super = super
	class_type.new = function( ... )
		local obj = {}
		do 
			local create 
			create = function (c , ... )
				--  檢測有沒有父類別，有則加入。
				if c.super  then
					create(c.super , ...)
				end
				--  如有建構式則執行建構式
				if c.Ctor then
					c.Ctor(obj , ...)
				end
			end
			create(class_type, ...)
		end
		setmetatable( obj , {__index= _class[class_type] } )
		return obj
	end

	local vtbl = {}
	_class[class_type] = vtbl

	setmetatable(class_type, {__newindex = 
		function (t,k,v)
			vtbl[k]=v
		end
		})

	if super then
		setmetatable(vtbl, {__index= 
			function (t , k )
				-- body
				local ret = _class[super][k]
				vtbl[k] = ret
				return ret
			end
		})
	end
	
	return class_type
end
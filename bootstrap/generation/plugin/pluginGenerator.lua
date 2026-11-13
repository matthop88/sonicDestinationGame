local DIRECTORY_UTIL  = require("lib/util/directoryUtil")
local FILE_UTIL       = require("lib/util/fileUtil")

local COMMENT_CODE    = ""
local ticketID        = __PARAMS["ticketID"]
local pluginName      = __PARAMS["pluginName"]

if ticketID then
	local COMMENT_GENERATOR = require("tracking/app/lib/commentGenerator"):create(ticketID)

	if COMMENT_GENERATOR == nil then
		print("\nTicket not found: " .. ticketID)
	else
		local rendered = COMMENT_GENERATOR:render()
		
		COMMENT_CODE   = rendered.comments
	end
end

local GENERIC_PLUGIN_CODE = [[
return {
    create = function(self, params)
        
        return ({

        	init = function(self, params)
        		-- Operate on params

        		return self
        	end,

        	--draw                = function(self)         end,
        	--update              = function(self, dt)     end,
        	--handleKeypressed    = function(self, key)    end,
        	--handleKeyreleased   = function(self, key)    end,
        	--handleMousepressed  = function(self, mx, my) end,
        	--handleMousereleased = function(self, mx, my) end,

        }):init(params)

    end,
}
]]

print("\nGenerating Plugin: \"" .. pluginName .. "\"\n")

local path = "plugins/modules/" .. pluginName
DIRECTORY_UTIL:createDirectory(path)

local fullPluginPath = path .. "/" .. pluginName .. ".lua"
if not FILE_UTIL:fileExists(fullPluginPath) then
	local file, err = io.open(path .. "/" .. pluginName .. ".lua", "w")

	if file then
		file:write(COMMENT_CODE)
	    file:write(GENERIC_PLUGIN_CODE)
	    file:close() 

	    print("Successfully generated plugin.\n")
	else
	    print("Error creating file: " .. tostring(err) .. "\n")
	end
else
	print("Plugin with name " .. pluginName .. " already exists.\n")
end


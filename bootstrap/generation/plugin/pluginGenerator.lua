local function mkdir(path)
    -- quote the path so spaces and special characters are safe
    local quoted = "'" .. path:gsub("'", "'\\''") .. "'"
    return os.execute("mkdir -p " .. quoted)
end

local function file_exists(path)
    local file = io.open(path, "r")
    if file ~= nil then
        file:close()
        return true
    end
    return false
end

local COMMENT_CODE = ""

if __PARAMS["ticketID"] then
	local TEMPLATE_PARSER = require("tracking/app/lib/templateParser")

	local data, size = love.filesystem.read("tracking/tickets/active/" .. __PARAMS["ticketID"] .. ".md")

	if data == nil then
		print("\nTicket not found: " .. __PARAMS["commentOn"])

		printValidTicketNames()

	else
		local template = require("tracking/app/lib/templateFactory"):create("pluginComments")
		local templateParser = TEMPLATE_PARSER:create("pluginTicketMD")
		
		local kvTable        = templateParser:parse(data)

		local title          = kvTable.title or "[UNTITLED]"

		COMMENT_CODE = template:render(kvTable)
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

print("\nGenerating Plugin: \"" .. __PARAMS["pluginName"] .. "\"\n")

local path = "plugins/modules/" .. __PARAMS["pluginName"]
mkdir(path)

local fullPluginPath = path .. "/" .. __PARAMS["pluginName"] .. ".lua"
if not file_exists(fullPluginPath) then
	local file, err = io.open(path .. "/" .. __PARAMS["pluginName"] .. ".lua", "w")

	if file then
		file:write(COMMENT_CODE)
	    file:write(GENERIC_PLUGIN_CODE)
	    file:close() 

	    print("Successfully generated plugin.\n")
	else
	    print("Error creating file: " .. tostring(err) .. "\n")
	end
else
	print("Plugin with name " .. __PARAMS["pluginName"] .. " already exists.\n")
end


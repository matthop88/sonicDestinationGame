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
	    file:write(GENERIC_PLUGIN_CODE)
	    file:close() 

	    print("Successfully generated plugin.\n")
	else
	    print("Error creating file: " .. tostring(err) .. "\n")
	end
else
	print("Plugin with name " .. __PARAMS["pluginName"] .. " already exists.\n")
end


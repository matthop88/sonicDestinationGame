local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local FILE_UTIL      = require("lib/util/fileUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local COMMENT_CODE   = ""
local ticketID       = __PARAMS["ticketID"]
local toolName       = __PARAMS["toolName"]

if ticketID then
	local COMMENT_GENERATOR = require("tracking/app/lib/commentGenerator"):create(ticketID)

	if COMMENT_GENERATOR == nil then
		print("\nTicket not found: " .. ticketID)
	else
		local rendered = COMMENT_GENERATOR:render()
		
		COMMENT_CODE   = rendered.comments
	end
end

local GENERIC_WINDOW_CODE = [[
return {
    title  = "]] .. toolName .. [[",
    width  = 1200,
    height =  800,
}

]]

local GENERIC_CMD_SCHEMA_CODE = [[
return {
	VERSION  = 0.1,

	COMMANDS = {
		
	},
	
}

]]

local GENERIC_TOOL_CODE = [=[

--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

require("plugins/engine")
    --:add { "plugin1",        { foo = "foo", bar = "bar",  } }
    --:add { "plugin2",        { baz = "baz",               } }
    --:add { "plugin3",        { accessorFn = "getPlugin3", } }


--[[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀(ASCII ART GOES HERE)
--]]
]=]

local generateFile = function(fullPath, contents)
	local file, err = io.open(fullPath, "w")

	if file then
		file:write(contents)
	    file:close() 

	    print("Successfully generated file: " .. fullPath)
	    return true
	else
	    print("Error creating file: " .. tostring(err) .. "\n")
	end
end

local generateConfig = function(path)
	local configPath = path .. "/config"
	DIRECTORY_UTIL:createDirectory(configPath)

	local windowPath    = configPath .. "/window.lua"
	local cmdSchemaPath = configPath .. "/cmdSchema.lua"

	return generateFile(windowPath,    GENERIC_WINDOW_CODE)
	   and generateFile(cmdSchemaPath, GENERIC_CMD_SCHEMA_CODE)
end

local generateTool = function(toolName)
	local ccToolName  = STRING_UTIL:toCamelCase(toolName)
	local toolPath    = "tools/" .. ccToolName
	DIRECTORY_UTIL:createDirectory(toolPath)

	local toolAppPath = toolPath .. "/" .. ccToolName .. "App.lua"

	if FILE_UTIL:fileExists(toolAppPath) then
		print("Tool with name \"" .. toolName .. "\" already exists.\n")
	else
		return generateFile(toolAppPath, COMMENT_CODE .. GENERIC_TOOL_CODE)
	  	   and generateConfig(toolPath)
	end
end
	
print("\nGenerating Tool: \"" .. toolName .. "\"\n")

if generateTool(toolName) then
	print("\nSuccessfully created Tool: \"" .. toolName .. "\"\n")
end


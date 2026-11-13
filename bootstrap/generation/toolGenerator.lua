local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local FILE_UTIL      = require("lib/util/fileUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local COMMENT_CODE   = ""
local ticketID       = __PARAMS["ticketID"]
local toolName       = __PARAMS["toolName"]
local ccToolName     = STRING_UTIL:toCamelCase(toolName)

if ticketID then
	local COMMENT_GENERATOR = require("tracking/app/lib/commentGenerator"):create(ticketID)

	if COMMENT_GENERATOR == nil then
		print("\nTicket not found: " .. ticketID)
	else
		local rendered = COMMENT_GENERATOR:render()
		
		COMMENT_CODE   = rendered.comments
	end
end

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

print("\nGenerating Tool: \"" .. toolName .. "\"\n")

local path = "tools/" .. ccToolName
DIRECTORY_UTIL:createDirectory(path)

local fullToolPath = path .. "/" .. ccToolName .. "App.lua"

if not FILE_UTIL:fileExists(fullToolPath) then
	local file, err = io.open(fullToolPath, "w")

	if file then
		file:write(COMMENT_CODE)
	    file:write(GENERIC_TOOL_CODE)
	    file:close() 

	    print("Successfully generated tool.\n")
	else
	    print("Error creating file: " .. tostring(err) .. "\n")
	end
else
	print("Tool with name \"" .. toolName .. "\" already exists.\n")
end


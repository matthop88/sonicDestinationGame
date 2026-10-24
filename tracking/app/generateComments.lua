local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local printValidTicketNames = function()
    local validTicketNames = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/active", ".md")
    print("\nValid Ticket names are:")
    print("-----------------------")
    for _, validTicketName in ipairs(validTicketNames) do
        print(validTicketName)
    end
    print("")
end

if __PARAMS["commentOn"] == "_" then
	printValidTicketNames()
else
	local TEMPLATE_PARSER = requireRelative("lib/templateParser")

	local data, size = love.filesystem.read("tracking/tickets/active/" .. __PARAMS["commentOn"] .. ".md")

	if data == nil then
		print("\nTicket not found: " .. __PARAMS["commentOn"])

		printValidTicketNames()

	else
		local templateParser = TEMPLATE_PARSER:create("ticketMD")
		local kvTable        = templateParser:parse(data)
		
		local template
		if STRING_UTIL:startsWith(__PARAMS["commentOn"], "plug") then
			template = requireRelative("lib/templateFactory"):create("pluginComments")
		else
			template = requireRelative("lib/templateFactory"):create("comments")
		end

		local title          = kvTable.title or "[UNTITLED]"

		love.system.setClipboardText(template:render(kvTable))

		print("\nComments saved to clipboard (title = " .. title .. ")\n")
	end
end


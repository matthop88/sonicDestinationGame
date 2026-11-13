local DIRECTORY_UTIL = require("lib/util/directoryUtil")

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
	local COMMENT_GENERATOR = requireRelative("lib/commentGenerator"):create(__PARAMS["commentOn"])

	if COMMENT_GENERATOR == nil then
		print("\nTicket not found: " .. __PARAMS["commentOn"])

		printValidTicketNames()
	else
		local rendered = COMMENT_GENERATOR:render()
		love.system.setClipboardText(rendered.comments)

		print("\nComments saved to clipboard (title = " .. rendered.title .. ")\n")
	end
end


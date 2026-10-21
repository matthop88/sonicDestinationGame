local TEMPLATE_PARSER = requireRelative("lib/templateParser")

local data, size = love.filesystem.read("tracking/tickets/active/" .. __PARAMS["commentOn"] .. ".md")

local templateParser = TEMPLATE_PARSER:create("ticketMD")

local kvTable = templateParser:parse(data)

local template = requireRelative("lib/templateFactory"):create("comments")

local title = kvTable.title or "[UNTITLED]"

love.system.setClipboardText(template:render(kvTable))

print("\nComments saved to clipboard (title = " .. title .. ")\n")


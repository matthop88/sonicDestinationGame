print("Generating comments...")

local TEMPLATE_PARSER = requireRelative("lib/templateParser")

local data, size = love.filesystem.read("tracking/tickets/active/" .. __PARAMS["commentOn"] .. ".md")

local templateParser = TEMPLATE_PARSER:create("ticketMD")

local kvTable = templateParser:parse(data)

local template = requireRelative("lib/templateFactory"):create("comments")

print(template:render(kvTable))



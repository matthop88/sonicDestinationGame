print("Generating comments...")

local TEMPLATE_PARSER = requireRelative("lib/templateParser")

local data, size = love.filesystem.read("tracking/tickets/active/" .. __PARAMS["commentOn"] .. ".md")

local templateParser = TEMPLATE_PARSER:create("ticketMD")

local kvTable = templateParser:parse(data)

for k, v in pairs(kvTable) do
	print("Key = " .. k .. ", value = ", v)
end



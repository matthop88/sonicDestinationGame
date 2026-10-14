local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local allTicketNames = {}
local subDirectories = { "active", "backlog", "completed" }

for _, subDirectory in ipairs(subDirectories) do
	local ticketNames = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/" .. subDirectory, ".md")

	for _, name in ipairs(ticketNames) do 
		table.insert(allTicketNames, name) 
	end
end

local maxTicketNum = 0

for _, name in ipairs(allTicketNames) do
	local suffix = STRING_UTIL:dropPrefix(name, string.len(name) - 4)
	maxTicketNum = math.max(maxTicketNum, tonumber(suffix))
end

print(string.upper(__PARAMS["type"]) .. "-" .. STRING_UTIL:padValueLeft("" .. (maxTicketNum + 1), 4, "0"))

love.event.quit()

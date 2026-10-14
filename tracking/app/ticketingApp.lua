local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

print("Welcome to the Ticketing App!")

local activeTicketNames    = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/active",    ".md")
local backlogTicketNames   = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/backlog",   ".md")
local completedTicketNames = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/completed", ".md")

local allTicketNames = {}

for _, name in ipairs(activeTicketNames)    do table.insert(allTicketNames, name) end
for _, name in ipairs(backlogTicketNames)   do table.insert(allTicketNames, name) end
for _, name in ipairs(completedTicketNames) do table.insert(allTicketNames, name) end

local maxTicketNum = 0

for _, name in ipairs(allTicketNames) do
	local suffix = STRING_UTIL:dropPrefix(name, string.len(name) - 4)
	maxTicketNum = math.max(maxTicketNum, tonumber(suffix))
end

print(STRING_UTIL:padValueLeft("" .. (maxTicketNum + 1), 4, "0"))

love.event.quit()

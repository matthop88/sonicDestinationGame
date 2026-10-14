local DIRECTORY_UTIL = require("lib/util/directoryUtil")

print("Welcome to the Ticketing App!")

local activeTicketNames    = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/active",    ".md")
local backlogTicketNames   = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/backlog",   ".md")
local completedTicketNames = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/completed", ".md")

local allTicketNames = {}

for _, name in ipairs(activeTicketNames)    do table.insert(allTicketNames, name) end
for _, name in ipairs(backlogTicketNames)   do table.insert(allTicketNames, name) end
for _, name in ipairs(completedTicketNames) do table.insert(allTicketNames, name) end

for _, name in ipairs(allTicketNames) do
	print(name)
end

love.event.quit()

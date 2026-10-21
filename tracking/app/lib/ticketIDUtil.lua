local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local SUBDIRECTORIES = { "active", "backlog", "completed" }
local TICKET_PATH    = "tracking/tickets/"
	
return {
	getNextID = function(self, type, subdirectories, ticketPath)
		local prefix = type
		local number = STRING_UTIL:padValueLeft("" .. self:getNextNumber(subdirectories, ticketPath), 4, "0")

		return prefix .. "-" .. number
	end,

	getNextNumber = function(self, subdirectories, ticketPath)
		local maxTicketNum = 0

		for _, subDirectory in ipairs(subdirectories or SUBDIRECTORIES) do
			local ticketNames = DIRECTORY_UTIL:getFilesInDirectory((ticketPath or TICKET_PATH) .. subDirectory, ".md")

			for _, name in ipairs(ticketNames) do
				maxTicketNum = math.max(maxTicketNum, self:extractNumber(name))
			end
		end

		return maxTicketNum + 1
	end,

	extractNumber = function(self, filename)
		local suffix = STRING_UTIL:dropPrefix(filename, string.len(filename) - 4) 
		return tonumber(suffix)
	end,

}

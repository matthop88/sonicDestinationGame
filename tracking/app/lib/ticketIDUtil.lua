local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local SUBDIRECTORIES = { "active", "backlog", "completed" }
	
return {
	getNextID = function(self, type)
		local prefix = string.upper(type)
		local number = STRING_UTIL:padValueLeft("" .. self:getNextNumber(), 4, "0")

		return prefix .. "-" .. number
	end,

	getNextNumber = function(self)
		local maxTicketNum = 0

		for _, subDirectory in ipairs(SUBDIRECTORIES) do
			local ticketNames = DIRECTORY_UTIL:getFilesInDirectory("tracking/tickets/" .. subDirectory, ".md")

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

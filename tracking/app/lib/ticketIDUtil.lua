local DIRECTORY_UTIL = require("lib/util/directoryUtil")
local STRING_UTIL    = require("game/util/stringUtil")

local TICKET_PATH    = "tracking/tickets/"
	
return {
	getNextID = function(self, type, subdirectory, ticketPath)
		local prefix = type
		local number = STRING_UTIL:padValueLeft("" .. self:getNextNumber(subdirectory or "", ticketPath), 4, "0")

		return prefix .. "-" .. number
	end,

	getNextNumber = function(self, subdirectory, ticketPath)
		local maxTicketNum = 0
		local ticketNames = DIRECTORY_UTIL:getNestedFilesInDirectory((ticketPath or TICKET_PATH) .. subdirectory, ".md")
		
		for _, name in ipairs(ticketNames) do
			maxTicketNum = math.max(maxTicketNum, self:extractNumber(name))
		end

		return maxTicketNum + 1
	end,

	extractNumber = function(self, filename)
		local suffix = STRING_UTIL:dropPrefix(filename, string.len(filename) - 4) 
		return tonumber(suffix)
	end,

	findObjectName = function(self, objectName, ticketPath)
		local filenames = DIRECTORY_UTIL:getNestedFilesInDirectory(ticketPath or TICKET_PATH, ".md")

		for _, name in ipairs(filenames) do
			local data, size = love.filesystem.read(name .. ".md")
			local s, e = data:find(objectName, 1, true)
			if s ~= nil then return name end
		end		
	end,

}

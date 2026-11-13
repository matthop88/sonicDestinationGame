local DIRECTORY_UTIL  = require("lib/util/directoryUtil")
local STRING_UTIL     = require("game/util/stringUtil")

local TEMPLATE_PARSER = require("tracking/app/lib/templateParser")

return {
	create = function(self, ticketID)
		local data, size = love.filesystem.read("tracking/tickets/active/" .. ticketID .. ".md")

		if data ~= nil then 
			return {
				ticketID = ticketID,
				data     = data,

				render   = function(self)
					local template, templateParser = self:getTemplateAndParser()

					local kvTable = templateParser:parse(self.data)

					local title   = kvTable.title or "[UNTITLED]"

					return {
						title    = title,
						comments = template:render(kvTable),
					}
				end,

				getTemplateAndParser = function(self)
					local template, templateParser

					if STRING_UTIL:startsWith(self.ticketID, "plug") then
						template       = require("tracking/app/lib/templateFactory"):create("pluginComments")
						templateParser = TEMPLATE_PARSER:create("pluginTicketMD")
					else
						template       = require("tracking/app/lib/templateFactory"):create("comments")
						templateParser = TEMPLATE_PARSER:create("ticketMD")
					end

					return template, templateParser
				end,
		

			}
		end
	end,

}

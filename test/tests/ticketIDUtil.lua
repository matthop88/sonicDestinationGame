local ASSERT         = require("test/lib/assert")

local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")
local TICKET_PATH    = "test/tests/resources/ticketIDUtil/"

return {
	NAME          = "Ticket ID Util",

	testScenario1 = function(self)
		local nextID = TICKET_ID_UTIL:getNextID("yeah", { "scenario1", }, TICKET_PATH)

		return ASSERT:EQUALS("Next ID with gap", "yeah-0008", nextID)
	end,

	testScenario2 = function(self)
		local nextID = TICKET_ID_UTIL:getNextID("uggh", { "scenario2", }, TICKET_PATH)

		return ASSERT:EQUALS("Next ID with false file, different prefixes", "uggh-0124", nextID)
	end,

}

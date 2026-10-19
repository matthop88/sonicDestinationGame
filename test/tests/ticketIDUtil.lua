local ASSERT         = require("test/lib/assert")

local TICKET_ID_UTIL = require("tracking/app/lib/ticketIDUtil")

return {
	NAME          = "Ticket ID Util",

	testScenario1 = function(self)
		local nextID = TICKET_ID_UTIL:getNextID("yeah", { "scenario1", }, "test/tests/resources/ticketIDUtil/")

		return ASSERT:EQUALS("Next ID with gap", "yeah-0008", nextID)
	end,

}

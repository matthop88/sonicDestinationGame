local ASSERT  = require("test/lib/assert")

return {
	NAME      = "Dummy",

	testDummy = function(self)
		return ASSERT:EQUALS("DUMMY", "SEGA", "SEGA")
	end,
}

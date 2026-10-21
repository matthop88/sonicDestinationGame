local ASSERT           = require("test/lib/assert")

local NAVIGABLE_STRING = require("game/util/navigableString")

return {
	NAME = "Navigable String",

	testGetC = function(self)
		local navigableString = NAVIGABLE_STRING:create("1234567890ABCDEF")

		local expected        = "1234567890"

		local actual          = ""

		for i = 1, 10 do
			actual = actual .. navigableString:getC()
		end

		return ASSERT:EQUALS("Get Character", expected, actual)
	end,

}

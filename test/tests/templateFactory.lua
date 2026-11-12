local ASSERT           = require("test/lib/assert")

local TEMPLATE_FACTORY = require("tracking/app/lib/templateFactory")
local TEMPLATE_PATH    = "test/tests/resources/templateFactory/"

return {
	NAME          = "Template Factory",

	testTemplate1 = function(self)
		local template = TEMPLATE_FACTORY:create("template1", TEMPLATE_PATH)

		local expected = [[
Name:       Sonic the Hedgehog
Height:     3 foot 3
Age:        35 years
Speed:      120 mph
Mascot For: SEGA
]]

		local actual   = template:render { 
			name    = "Sonic the Hedgehog",
			height  = "3 foot 3",
			age     = "35 years",
			speed   = "120 mph",
			company = "SEGA",
		}

		return ASSERT:EQUALS("Test Template 1", expected, actual)
	end,

	testTemplate1Incomplete = function(self)
		local template = TEMPLATE_FACTORY:create("template1", TEMPLATE_PATH)

		local expected = [[
Name:       Vector the Crocodile
Height:     6 foot 3
Age:        
Speed:      
Mascot For: Chaotix
]]

		local actual   = template:render { 
			name    = "Vector the Crocodile",
			height  = "6 foot 3",
			company = "Chaotix",
		}

		return ASSERT:EQUALS("Test Template 1 Incomplete", expected, actual)
	end,

}

local ASSERT          = require("test/lib/assert")

local TEMPLATE_PARSER = require("tracking/app/lib/templateParser")
local TEMPLATE_PATH   = "tests/resources/templateFactory/"

local DATA_SERIALIZER = require("lib/serialization/dataSerializer")

local TEMPLATE_STRUCTURE = {
	{ key = "",        value = "Name:       "   },
	{ key = "name",    value = "\nHeight:     " },
	{ key = "height",  value = "\nAge:        " },
	{ key = "age",     value = "\nSpeed:      " },
	{ key = "speed",   value = "\nMascot For: " },
	{ key = "company", value = "\n"             },
}

return {
	NAME          = "Template Parser",

	testParseTemplate1 = function(self)
		local templateParser    = TEMPLATE_PARSER:create("template1", TEMPLATE_PATH)

		local templateStructure = templateParser:getTemplateStructure()

		local serializedTestData = DATA_SERIALIZER:serialize(TEMPLATE_STRUCTURE):toString()
		local serializedRealData = DATA_SERIALIZER:serialize(templateStructure):toString()

		return ASSERT:EQUALS("Parse Template 1", serializedTestData, serializedRealData)
	end,

}

local ASSERT          = require("test/lib/assert")

local TEMPLATE_PARSER = require("tracking/app/lib/templateParser")
local TEMPLATE_PATH   = "test/tests/resources/templateFactory/"

local DATA_SERIALIZER = require("lib/serialization/dataSerializer")

local TEMPLATE_STRUCTURE = {
	{ key = "",        value = "Name:       "   },
	{ key = "name",    value = "\nHeight:     " },
	{ key = "height",  value = "\nAge:        " },
	{ key = "age",     value = "\nSpeed:      " },
	{ key = "speed",   value = "\nMascot For: " },
	{ key = "company", value = "\n"             },
}

local OUTPUT1 = [[
Name:       Shadow the Hedgehog
Height:     3'3"
Age:        100+
Speed:      No known limit
Mascot For: Maria
]]


return {
	NAME          = "Template Parser",

	testPreparseTemplate1 = function(self)
		local templateParser    = TEMPLATE_PARSER:create("template1", TEMPLATE_PATH)

		local templateStructure = templateParser:getTemplateStructure()

		local serializedTestData = DATA_SERIALIZER:serialize(TEMPLATE_STRUCTURE):toString()
		local serializedRealData = DATA_SERIALIZER:serialize(templateStructure):toString()

		return ASSERT:EQUALS("Preparse Template 1", serializedTestData, serializedRealData)
	end,

	testParseTemplate1 = function(self)
		local templateParser = TEMPLATE_PARSER:create("template1", TEMPLATE_PATH)

		local kvTable        = templateParser:parse(OUTPUT1)

		local expected = "Shadow the Hedgehog,3'3\",100+,No known limit,Maria"

		local actual   = kvTable.name .. "," .. kvTable.height .. "," .. kvTable.age .. "," .. kvTable.speed .. "," .. kvTable.company

		return ASSERT:EQUALS("Parse Template 1, Output 1", expected, actual)
	end,

}

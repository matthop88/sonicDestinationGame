local ASSERT             = require("test/lib/assert")

local COMMAND_LINE_TOOLS = require("lib/cmd/commandLineTools")

return {
	NAME      = "Command Line Tools",

	testNoArguments = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ })

		local keyCount = 0
		for k, v in pairs(params) do
			keyCount = keyCount + 1
		end

		return ASSERT:TRUE("No command-line Arguments", keyCount == 0)
	end,

	testOneArgument = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ "--silentMode" })

		return ASSERT:EQUALS("One command-line argument (flag)", true, params["silentMode"])
	end,

	testTwoArgumentsWithShorthand = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ "-i", "myFile" })

		return ASSERT:EQUALS("Two command-line arguments w/shorthand", "myFile", params["i"])
	end,

	testTwoArgumentsFullLength = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ "--inMap", "myFile" })

		return ASSERT:EQUALS("Two command-line arguments full-length", "myFile", params["inMap"])
	end,
}

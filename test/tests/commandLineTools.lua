local ASSERT                 = require("test/lib/assert")

local COMMAND_LINE_TOOLS     = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema1")
local COMMAND_LINE_TOOLS_BAD = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema1__BAD__")

require("game/error/errorLogger"):quiet()

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

	testFiveArgumentsMixed = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ "-i", "inFile", "--silentMode", "-o", "outFile" })

		return ASSERT:TRUE("Five command-line arguments mixed style",
							params["silentMode"] == true
						and params["i"]          == "inFile"
						and params["o"]          == "outFile")
	end,

	testCmdSchemaLoading = function(self)
		return ASSERT:EQUALS("Command Schema Loading", "z", COMMAND_LINE_TOOLS.SCHEMA.COMMANDS.zephyrZigguratZone.shortcut)
	end,

	testBadCmdSchemaLoading = function(self)
		return ASSERT:TRUE("Command Schema Loading Bad Path", COMMAND_LINE_TOOLS_BAD.SCHEMA == nil)
	end,

}

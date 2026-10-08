local ASSERT                 = require("test/lib/assert")

require("game/error/errorLogger"):quiet()

local COMMAND_LINE_TOOLS      = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema1", true)
local COMMAND_LINE_TOOLS_BAD  = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema1__BAD__")
local COMMAND_LINE_TOOLS_REQ  = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema2", true)
local COMMAND_LINE_TOOLS_DEF  = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema3", true)
local COMMAND_LINE_TOOLS_HELP = require("lib/cmd/commandLineTools"):create("test/tests/resources/testCmdSchema4", true)

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

	testMixedArgumentNamesWithCmdSchema = function(self)
		local params = COMMAND_LINE_TOOLS:getParams({ "-e", "1", "--windyHillZone", "-z", "7" })

		return ASSERT:TRUE("Mixed argument names based on cmdSchema",
							params["electricJungleZone"] == "1"
						and params["windyHillZone"]      == true
						and params["zephyrZigguratZone"] == "7")
	end,

	testCmdSchemaLoading = function(self)
		return ASSERT:EQUALS("Command Schema Loading", "z", COMMAND_LINE_TOOLS.SCHEMA.COMMANDS.zephyrZigguratZone.shortcut)
	end,

	testBadCmdSchemaLoading = function(self)
		return ASSERT:EQUALS("Command Schema Loading Bad Path", 0.0, COMMAND_LINE_TOOLS_BAD.SCHEMA.VERSION)
	end,

	testShortcutExpansion = function(self)
		local eCmd = COMMAND_LINE_TOOLS:expandShortcut("e")
		local wCmd = COMMAND_LINE_TOOLS:expandShortcut("w")
		local zCmd = COMMAND_LINE_TOOLS:expandShortcut("z")

		return ASSERT:EQUALS("Shortcut Expansion", "electricJungleZone windyHillZone zephyrZigguratZone", eCmd .. " " .. wCmd .. " " .. zCmd)
	end,

	testFindMissingParams = function(self)
		local params = COMMAND_LINE_TOOLS_REQ:getParams({ "-e", "1", "--windyHillZone" })

		local missingParams = COMMAND_LINE_TOOLS_REQ:findMissingParams(params)

		return ASSERT:EQUALS("Find Missing Params", "zephyrZigguratZone", missingParams[1])
	end,

	testDefaults = function(self)
		local params = COMMAND_LINE_TOOLS_DEF:getParams({ })

		return ASSERT:EQUALS("Test Defaults", "123 Boogie!", params["windyHillZone"] .. " " .. params["electricJungleZone"])
	end,

	testValidHelp = function(self)
		local helpString = COMMAND_LINE_TOOLS_HELP:generateHelp()

		local expectedString = [[

Accepted commands include:
  --help,                      -h  Show this help.
  --electricJungleZone,        -e  Customize Time HUD label for Electric Jungle Zone.
                                   (Default value: "Boogie!")

  --windyHillZone,             -w  Customize starting Ring Count for the Windy Hill Zone.
                                   (Default value: 123)

  --zephyrZigguratZone,        -z  Customize starting Act for the Zephyr Ziggurat Zone.
    [REQUIRED]

]]
		return ASSERT:EQUALS("Test Valid Help", expectedString, helpString)
	end,

	testInvalidHelp = function(self)
		local helpString = COMMAND_LINE_TOOLS_REQ:generateHelp()

		local expectedString = [[

XXX The following commands lack documentation:
  --electricJungleZone,        -e
  --windyHillZone,             -w
  --zephyrZigguratZone,        -z
]]

		return ASSERT:EQUALS("Test Invalid Help", expectedString, helpString)
	end,

}

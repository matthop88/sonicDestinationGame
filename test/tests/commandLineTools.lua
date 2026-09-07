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
}

local ASSERT      = require("test/lib/assert")
local STRING_UTIL = require("game/util/stringUtil")

return {
	runTests = function(self)
		-- Run tests for stringUtil.
		-- Test #1: startsWith
		-- Test #2: endsWith

		print("Running StringUtil tests...")

		self:startsWithTest()
	end,

	startsWithTest = function(self)
		local testString = "Zizzer Zazzer Zuzz"
		local prefix     = "Ziz"
		local startsWith = STRING_UTIL:startsWith(testString, prefix)

		ASSERT:TRUE("Starts With Prefix", startsWith)
	end,
}

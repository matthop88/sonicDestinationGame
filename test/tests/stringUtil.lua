local ASSERT      = require("test/lib/assert")
local STRING_UTIL = require("game/util/stringUtil")

return {
	runTests = function(self)
		print("\nRunning StringUtil tests...\n")

		local totalTests  = 2
		local testsPassed = 0
		
		if self:startsWithTest() then testsPassed = testsPassed + 1 end
		if self:endsWithTest()   then testsPassed = testsPassed + 1 end

		print("\nTests Passed: " .. testsPassed .. " out of " .. totalTests.. "\n")
	end,

	startsWithTest = function(self)
		local testString = "Zizzer Zazzer Zuzz"
		local prefix     = "Ziz"
		local startsWith = STRING_UTIL:startsWith(testString, prefix)

		return ASSERT:TRUE("Starts With Prefix", startsWith)
	end,

	endsWithTest   = function(self)
		local testString = "Aaah! It's a Metarex!"
		local suffix     = "Metarex!"
		local endsWith   = STRING_UTIL:endsWith(testString, suffix)

		return ASSERT:TRUE("Ends With Suffix", endsWith)
	end,
}

local ASSERT      = require("test/lib/assert")
local STRING_UTIL = require("game/util/stringUtil")

return {
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

local ASSERT      = require("test/lib/assert")
local STRING_UTIL = require("game/util/stringUtil")

return {
	testStartsWith = function(self)
		local testString = "Zizzer Zazzer Zuzz"
		local prefix     = "Ziz"
		local startsWith = STRING_UTIL:startsWith(testString, prefix)

		return ASSERT:TRUE("Starts With Prefix", startsWith)
	end,

	testEndsWith   = function(self)
		local testString = "Aaah! It's a Metarex!"
		local suffix     = "Metarex!"
		local endsWith   = STRING_UTIL:endsWith(testString, suffix)

		return ASSERT:TRUE("Ends With Suffix", endsWith)
	end,

	testNotEndsWith = function(self)
		local testString = "Welcome to the Next Level"
		local prefix     = "Nintendo Power!"
		local startsWith = STRING_UTIL:startsWith(testString, prefix)

		return ASSERT:FALSE("Doesn't Start With Prefix", startsWith)
	end,
}

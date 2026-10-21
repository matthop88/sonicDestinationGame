local ASSERT      = require("test/lib/assert")
local STRING_UTIL = require("game/util/stringUtil")

return {
	NAME           = "StringUtil",

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

	testDropPrefix = function(self)
		local testString   = "XXXSonic Team Presents"
		local prefixLength = 3

		local expected     = "Sonic Team Presents"
		local actual       = STRING_UTIL:dropPrefix(testString, prefixLength)

		return ASSERT:EQUALS("Drop Prefix", expected, actual)
	end,
	
	testDropSuffix = function(self)
		local testString   = "sonicIsAwesome.exe"
		local suffixLength = 4

		local expected     = "sonicIsAwesome"
		local actual       = STRING_UTIL:dropSuffix(testString, suffixLength)

		return ASSERT:EQUALS("Drop Suffix", expected, actual)
	end,

	testIsUppercaseFalse = function(self)
		local testString = "noT uPPerCasE"

		return ASSERT:FALSE("Is Uppercase (False)", STRING_UTIL:isUppercase(testString))
	end,

	testIsUppercaseTrue = function(self)
		local testString = "REALLY, TRULY, UPPERCASE!"

		return ASSERT:TRUE("Is Uppercase (True)", STRING_UTIL:isUppercase(testString))
	end,

	testAddQuotesIfStringFalse = function(self)
		local testVal  = 37

		local expected = 37
		local actual   = STRING_UTIL:addQuotesIfString(testVal)

		return ASSERT:EQUALS("Add Quotes if String (non-string)", expected, actual)
	end,

	testAddQuotesIfStringTrue = function(self)
		local testVal  = "Thirty-Seven"

		local expected = "\"Thirty-Seven\""
		local actual   = STRING_UTIL:addQuotesIfString(testVal)

		return ASSERT:EQUALS("Add Quotes if String (string)", expected, actual)
	end,

	testPadValueRight = function(self)
		local testVal  = "Make it 40!!!"

		local expected = "Make it 40!!!                           "
		local actual   = STRING_UTIL:padValueRight(testVal, 40)

		return ASSERT:EQUALS("Pad Value Right", expected, actual)
	end,

	testPadValueLeft = function(self)
		local testVal  = "Should take up 30 characters"

		local expected = "  Should take up 30 characters"
		local actual   = STRING_UTIL:padValueLeft(testVal, 30)

		return ASSERT:EQUALS("Pad Value Left", expected, actual)
	end,

	testPadValueLeftZero = function(self)
		local testVal  = "3.14159265358979"

		local expected = "00003.14159265358979"
		local actual   = STRING_UTIL:padValueLeft(testVal, 20, "0")

		return ASSERT:EQUALS("Pad Value Left", expected, actual)
	end,

	testTrim = function(self)
		local testVal  = "\n\t   Hello  \t\n  "

		local expected = "Hello"
		local actual   = STRING_UTIL:trim(testVal)

		return ASSERT:EQUALS("Trim String", expected, actual)
	end,

}

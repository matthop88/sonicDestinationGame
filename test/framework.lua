local STRING_UTIL = require("game/util/stringUtil")

local stringUtilTestClass = require("test/tests/stringUtil")

local testsToRun = {}
local testCount  = 0

for k, v in pairs(stringUtilTestClass) do
	if STRING_UTIL:endsWith(k, "Test") then
		testsToRun[k] = v
		testCount     = testCount + 1
	end
end

print("Total Tests to Run: " .. testCount)

love.event.quit()


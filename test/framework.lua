local STRING_UTIL = require("game/util/stringUtil")

local stringUtilTestClass = require("test/tests/stringUtil")

local testsToRun = {}
local testCount   = 0
local testsPassed = 0

for k, v in pairs(stringUtilTestClass) do
	if STRING_UTIL:endsWith(k, "Test") then
		testsToRun[k] = v
		testCount     = testCount + 1
	end
end

print("\nRunning StringUtil tests...\n")

for testName, testFn in pairs(testsToRun) do
	local result = testFn(stringUtilTestClass)

	if result == true then
		testsPassed = testsPassed + 1
	end
end

print("\nTests Passed: " .. testsPassed .. " out of " .. testCount.. "\n")

love.event.quit()


local LINE_SEPARATOR = string.rep("-", 100) .. "\n"

local STRING_UTIL    = require("game/util/stringUtil")
local TEST_DISCOVERY = require("test/lib/testDiscovery")

local TEST_CLASSES   = TEST_DISCOVERY:findTestClasses()

local totalTestCount   = 0
local totalTestsPassed = 0

for _, testClass in ipairs(TEST_CLASSES) do
	print("\n" .. LINE_SEPARATOR .. "Running " .. testClass.NAME .. " Tests...\n" .. LINE_SEPARATOR)

	local testsToRun = {}
	local testCount   = 0
	local testsPassed = 0

	for k, v in pairs(testClass) do
		if STRING_UTIL:startsWith(k, "test") then
			testsToRun[k]  = v
			testCount      = testCount + 1
			totalTestCount = totalTestCount + 1
		end
	end

	for testName, testFn in pairs(testsToRun) do
		local result = testFn(stringUtilTestClass)

		if result == true then
			testsPassed      = testsPassed      + 1
			totalTestsPassed = totalTestsPassed + 1
		end
	end

	print("\nTests Passed: " .. testsPassed .. " out of " .. testCount)
end

print(LINE_SEPARATOR)

print("Total Tests Passed: " .. totalTestsPassed .. " out of " .. totalTestCount.. "\n")


love.event.quit()


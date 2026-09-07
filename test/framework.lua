local STRING_UTIL    = require("game/util/stringUtil")
local TEST_DISCOVERY = require("test/lib/testDiscovery")

local TEST_CLASSES   = TEST_DISCOVERY:findTestClasses()

print("\nRunning Tests...\n")

for _, testClass in ipairs(TEST_CLASSES) do
	local testsToRun = {}
	local testCount   = 0
	local testsPassed = 0

	for k, v in pairs(testClass) do
		if STRING_UTIL:startsWith(k, "test") then
			testsToRun[k] = v
			testCount     = testCount + 1
		end
	end

	for testName, testFn in pairs(testsToRun) do
		local result = testFn(stringUtilTestClass)

		if result == true then
			testsPassed = testsPassed + 1
		end
	end

	print("\nTests Passed: " .. testsPassed .. " out of " .. testCount.. "\n")
end

love.event.quit()


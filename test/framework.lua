local LINE_SEPARATOR = string.rep("-", 100) .. "\n"

local STRING_UTIL    = require("game/util/stringUtil")
local TEST_DISCOVERY = require("test/lib/testDiscovery")
local testGroups     = TEST_DISCOVERY:createTestGroups()

local totalTestCount   = 0
local totalTestsPassed = 0

for _, testGroup in ipairs(testGroups) do
	print("\n" .. LINE_SEPARATOR .. "Running " .. testGroup:getName() .. " Tests...\n" .. LINE_SEPARATOR)

	testGroup:runTests()

	print("\nTests Passed: " .. testGroup:getTestsPassed() .. " out of " .. testGroup:getTestCount())

	totalTestCount   = totalTestCount   + testGroup:getTestCount()
	totalTestsPassed = totalTestsPassed + testGroup:getTestsPassed()
end

print(LINE_SEPARATOR)

print("Total Tests Passed: " .. totalTestsPassed .. " out of " .. totalTestCount.. "\n")

love.event.quit()


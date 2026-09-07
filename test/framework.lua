local TEST_DISCOVERY     = require("test/lib/testDiscovery")
local TEST_SUITE_FACTORY = require("test/lib/testSuite")

local testGroups         = TEST_DISCOVERY:createTestGroups()
local testSuite          = TEST_SUITE_FACTORY:create(testGroups)

testSuite:runTests()

print("Total Tests Passed: " .. testSuite:getTotalTestsPassed() .. " out of " .. testSuite:getTotalTestCount() .. "\n")

love.event.quit()


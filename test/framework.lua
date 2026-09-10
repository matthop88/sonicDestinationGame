local TEST_DISCOVERY     = requireRelative("lib/testDiscovery")
local TEST_SUITE_FACTORY = requireRelative("lib/testSuite")
local testClasses        = TEST_DISCOVERY:findTestClasses()
local testSuite          = TEST_SUITE_FACTORY:create(testClasses)

testSuite:runTests()

print("Total Tests Passed: " .. testSuite:getTotalTestsPassed() .. " out of " .. testSuite:getTotalTestCount() .. "\n")

love.event.quit()


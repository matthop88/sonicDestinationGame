local STRING_UTIL = require("game/util/stringUtil")
local TEST_GROUP  = require("test/lib/testGroup")

return {
    findTestClasses = function(self)
        local testClasses = {}

        local testFilenames = love.filesystem.getDirectoryItems("test/tests")
        
        for _, testFilename in ipairs(testFilenames) do
            local keyName = STRING_UTIL:dropSuffix(testFilename, 4)
            local filePath = "test/tests/" .. keyName

            table.insert(testClasses, require(filePath))
        end

        return testClasses
    end,

    createTestGroups = function(self)
        local testClasses    = self:findTestClasses()
        local testGroups     = {}
        
        for _, testClass in ipairs(testClasses) do
            local testGroup = TEST_GROUP:create(testClass)
            table.insert(testGroups, testGroup)
        end

        return testGroups
    end,
}

local STRING_UTIL = require("game/util/stringUtil")

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
}

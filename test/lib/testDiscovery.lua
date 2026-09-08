local STRING_UTIL = require("game/util/stringUtil")

return {
    findTestClasses = function(self)
        local testClasses = {}

        local testFilenames = love.filesystem.getDirectoryItems("test/tests")
        
        for _, testFilename in ipairs(testFilenames) do
            if testFilename ~= "resources" then
                local keyName = STRING_UTIL:dropSuffix(testFilename, 4)
                local filePath = "test/tests/" .. keyName

                table.insert(testClasses, require(filePath))
            end
        end

        return testClasses
    end,
}

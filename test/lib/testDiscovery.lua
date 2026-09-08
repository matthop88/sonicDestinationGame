local STRING_UTIL = require("game/util/stringUtil")

return {
    findTestClasses = function(self)
        local testClasses = {}

        local testFilenames = love.filesystem.getDirectoryItems("test/tests")
        
        for _, testFilename in ipairs(testFilenames) do
            if testFilename ~= "resources" then self:addTestClass(testClasses, testFilename) end
        end

        return testClasses
    end,

    addTestClass = function(self, testClasses, testFilename)
        local keyName = STRING_UTIL:dropSuffix(testFilename, 4)
        local filePath = "test/tests/" .. keyName

        if self:qualifiesAsTest(keyName) then table.insert(testClasses, require(filePath)) end
    end,

    qualifiesAsTest = function(self, keyName)
        return __PARAMS == nil or __PARAMS["runTests"] == nil or __PARAMS["runTests"] == keyName
    end,

}

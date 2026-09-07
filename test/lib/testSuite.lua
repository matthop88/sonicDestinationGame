local LINE_SEPARATOR     = string.rep("-", 100) .. "\n"
local TEST_GROUP_FACTORY = require("test/lib/testGroup")

return {
	create = function(self, testClasses)
		return ({
			TEST_GROUPS = {},

			init = function(self, testClasses)
				for _, testClass in ipairs(testClasses) do
            		local testGroup = TEST_GROUP_FACTORY:create(testClass)
            		table.insert(self.TEST_GROUPS, testGroup)
            	end

            	return self
            end,
        
        	runTests = function(self)
				for _, testGroup in ipairs(self.TEST_GROUPS) do
					print("\n" .. LINE_SEPARATOR .. "Running " .. testGroup:getName() .. " Tests...\n" .. LINE_SEPARATOR)
					testGroup:runTests()

					print("\nTests Passed: " .. testGroup:getTestsPassed() .. " out of " .. testGroup:getTestCount())
				end

				print(LINE_SEPARATOR)
			end,

			getTotalTestCount = function(self)
				local totalTestCount = 0

				for _, testGroup in ipairs(self.TEST_GROUPS) do
					totalTestCount = totalTestCount + testGroup:getTestCount()
				end

				return totalTestCount
			end,

			getTotalTestsPassed = function(self)
				local totalTestCount = 0

				for _, testGroup in ipairs(self.TEST_GROUPS) do
					totalTestCount = totalTestCount + testGroup:getTestCount()
				end

				return totalTestCount
			end,

		}):init(testClasses)
	end,
}

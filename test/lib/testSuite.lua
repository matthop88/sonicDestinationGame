local LINE_SEPARATOR = string.rep("-", 100) .. "\n"

return {
	create = function(self, testGroups)
		return {
			TEST_GROUPS = testGroups,

			runTests          = function(self)
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

		}
	end,
}

local STRING_UTIL = require("game/util/stringUtil")

return {
	create = function(self, testClass)
		return ({
			TEST_CLASS  = testClass,

			testsToRun  = {},
			testCount   = 0,
			testsPassed = 0,

			init = function(self)
				for fnName, fn in pairs(self.TEST_CLASS) do
					if STRING_UTIL:startsWith(fnName, "test") then
						self.testsToRun[fnName]  = fn
						self.testCount           = self.testCount + 1
					end
				end

				return self
			end,

			runTests = function(self)
				for testName, testFn in pairs(self.testsToRun) do
					local result
					local status, err = pcall(function() result = testFn(self.TEST_CLASS) end)

					if status ~= true then
						print("EXCEPTION THROWN IN TEST " .. testName .. ",", err)
					elseif result == true then
						self.testsPassed = self.testsPassed + 1
					end
				end
			end,

			getTestCount = function(self)
				return self.testCount
			end,

			getTestsPassed = function(self)
				return self.testsPassed
			end,

			getName        = function(self)
				return self.TEST_CLASS.NAME
			end,
		}):init()
	end,
}

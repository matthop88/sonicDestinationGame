local STRING_UTIL  = require("game/util/stringUtil")

return ({
	jots = {},

	init = function(self)
		local jotNames = love.filesystem.getDirectoryItems("tools/scribbler/lib/jots")
        
		for _, jotName in ipairs(jotNames) do
			local jot = requireRelative("lib/jots/" .. STRING_UTIL:dropSuffix(jotName, 4))

			self:addJot(jot)
		end

		return self
	end,

	addJot = function(self, jot)
		self.jots[jot.name] = jot
	end,

	getJot = function(self, jotName)
		return self.jots[jotName]
	end,
}):init()

local STRING_UTIL  = require("game/util/stringUtil")

local JOT_REPOSITORY = ({
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

	
return {
	create = function(self, jotObj)
		local jot = JOT_REPOSITORY:getJot(jotObj.name)

		if jot ~= nil then
			return jot:fromData(jotObj.data)
		end
	end,
}

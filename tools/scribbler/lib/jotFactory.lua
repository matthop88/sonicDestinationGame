local STRING_UTIL  = require("game/util/stringUtil")

local JOT_REPOSITORY = {
	jots = {},

	addJot = function(self, jot)
		self.jots[jot.name] = jot
	end,

	getJot = function(self, jotName)
		return self.jots[jotName]
	end,
}

local jotNames = love.filesystem.getDirectoryItems("tools/scribbler/lib/jots")
        
for _, jotName in ipairs(jotNames) do
	local jot = requireRelative("lib/jots/" .. STRING_UTIL:dropSuffix(jotName, 4))

	JOT_REPOSITORY:addJot(jot)
end
	
return {
	create = function(self, jotObj)
		local jot = JOT_REPOSITORY:getJot(jotObj.name)

		if jot ~= nil then
			return jot:fromData(jotObj.data)
		end
	end,
}

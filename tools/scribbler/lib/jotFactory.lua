local STRING_UTIL  = require("game/util/stringUtil")

local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")
local LINE_JOT     = requireRelative("lib/jots/line")
local TEXT_JOT     = requireRelative("lib/jots/text")

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
	print(STRING_UTIL:dropSuffix(jotName, 4))
end
	

return {
	create = function(self, jotObj)
		if     jotObj.name == "scribble" then return SCRIBBLE_JOT:fromData(jotObj.data)
		elseif jotObj.name == "line"     then return LINE_JOT:fromData(jotObj.data)
		elseif jotObj.name == "text"     then return TEXT_JOT:fromData(jotObj.data)
		end
	end,
}

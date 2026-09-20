local STRING_UTIL  = require("game/util/stringUtil")

local DUMMY_FN   = function()
    -- do nothing
end

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
		self:enrichJot(jot)

		self.jots[jot.name] = jot
	end,

	enrichJot = function(self, jot)
		if not jot.update      then jot.update      = DUMMY_FN end
	    if not jot.keypressed  then jot.keypressed  = DUMMY_FN end
	    if not jot.keyreleased then jot.keyreleased = DUMMY_FN end
	    if not jot.penDown     then jot.penDown     = DUMMY_FN end
	    if not jot.penUp       then jot.penUp       = DUMMY_FN end
	    if not jot.penMoved    then jot.penMoved    = DUMMY_FN end
	    if not jot.penDragged  then jot.penDragged  = DUMMY_FN end
	end,

	getJot = function(self, jotName)
		return self.jots[jotName]
	end,
}):init()

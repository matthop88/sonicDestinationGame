local GRAFX  = love.graphics
local COLORS = require("game/constants/colors")

return {
	draw = function(self)
		GRAFX.setColor(COLORS.JET_BLACK)
		GRAFX.rectangle("fill", 300, 100, 200, 400)
		GRAFX.setColor(COLORS.PURE_WHITE)
		GRAFX.rectangle("line", 300, 100, 200, 400)
	end,
	
}

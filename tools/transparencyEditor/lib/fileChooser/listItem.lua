local GRAFX  = love.graphics
local COLORS = require("game/constants/colors")

return {
	create = function(self, params)
		return ({
			text     = params.text,
			x        = params.x,
			y        = params.y,
			fontSize = params.fontSize or 20,

			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				GRAFX.setColor(COLORS.PURE_WHITE)
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x, self.y, 200, "left")
			end,

		}):init()
	end,
}

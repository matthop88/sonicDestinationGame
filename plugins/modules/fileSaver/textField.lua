local GRAFX   = love.graphics
local COLORS  = require("game/constants/colors")
local TERNARY = require("lib/util/ternary")

return {
	create = function(self, params)
		return ({
			text     = params.text,
			x        = params.x,
			y        = params.y,
			w        = params.w,
			fontSize = params.fontSize or 20,
			
			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				GRAFX.setColor(COLORS.VERY_DARK_GREY)
				GRAFX.rectangle("fill", self.x, self.y, self.w, 30)
				GRAFX.setColor(COLORS.LIGHT_GREY)
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x + 12, self.y + 3, 1000, "left")
			end,

		}):init()
	end,
}

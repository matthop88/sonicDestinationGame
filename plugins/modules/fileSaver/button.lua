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
			fontSize = params.fontSize or 16,
			
			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				GRAFX.setColor(COLORS.DIALOG_ORANGE)
				GRAFX.rectangle("fill", self.x, self.y, self.w, 30, 10, 10)
				GRAFX.setColor(COLORS.PURE_WHITE)
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x, self.y + 5, self.w, "center")
			end,

		}):init()
	end,
}

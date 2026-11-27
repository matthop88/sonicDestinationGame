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
			highlit  = false,

			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				if self.highlit then
					GRAFX.setColor(COLORS.LIGHT_BLUE)
					GRAFX.rectangle("fill", self.x, self.y, self.w, 23)
				end
				GRAFX.setColor(TERNARY { IF = self.highlit, THEN = COLORS.JET_BLACK, ELSE = COLORS.LIGHT_GREY })
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x + 10, self.y, 1000, "left")
			end,

			update = function(self, dt, mx, my)
				self.highlit = self:isWithinBounds(mx, my)
			end,

			handleMousepressed = function(self, mx, my)
				return self:isWithinBounds(mx, my)
			end,
 
			isWithinBounds = function(self, mx, my)
				return (mx > self.x and mx < self.x + self.w 
							and my > self.y and my < self.y + 20)
			end,

		}):init()
	end,
}

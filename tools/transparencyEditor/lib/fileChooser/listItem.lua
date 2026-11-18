local GRAFX   = love.graphics
local MOUSE   = love.mouse
local COLORS  = require("game/constants/colors")
local TERNARY = require("lib/util/ternary")

return {
	create = function(self, params)
		return ({
			text     = params.text,
			x        = params.x,
			y        = params.y,
			fontSize = params.fontSize or 20,
			highlit  = false,

			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				GRAFX.setColor(TERNARY { IF = self.highlit, THEN = COLORS.GREEN, ELSE = COLORS.PURE_WHITE })
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x, self.y, 200, "left")
			end,

			update = function(self, dt)
				local mx, my = MOUSE.getPosition()
				self.highlit = (mx > self.x and mx < self.x + 200 
							and my > self.y and my < self.y + 20)
			end,

		}):init()
	end,
}

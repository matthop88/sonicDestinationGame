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
			w        = params.w,
			fontSize = params.fontSize or 16,
			color    = params.color    or COLORS.DIALOG_ORANGE,
			highlit  = false,

			init = function(self)
				self.font = GRAFX.newFont(16)
				
				return self
			end,

			draw = function(self)
				GRAFX.setColor(self.color)
				GRAFX.rectangle("fill", self.x, self.y, self.w, 30, 10, 10)
				GRAFX.setColor(COLORS.PURE_WHITE)
				GRAFX.setFont(self.font)
				GRAFX.printf(self.text, self.x, self.y + 5, self.w, "center")
				if self.highlit then
					GRAFX.setColor(COLORS.LIGHT_GREY)
					GRAFX.rectangle("line", self.x, self.y, self.w, 30, 10, 10)
				end
			end,

			update = function(self, dt)
				self.highlit = self:mouseInBounds(MOUSE.getPosition())
			end,

			handleMousepressed = function(self, mx, my)
				return self:mouseInBounds(mx, my)
			end,

			mouseInBounds = function(self, mx, my)
				return mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + 30
			end,

		}):init()
	end,
}

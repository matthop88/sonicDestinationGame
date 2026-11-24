local GRAFX   = love.graphics
local MOUSE   = love.mouse
local COLORS  = require("game/constants/colors")
local ternary = require("lib/util/ternary") 

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
			pressed  = false,

			init = function(self)
				self.font = GRAFX.newFont(16)
				self.pressedColor = self:generatePressedColor()
				return self
			end,

			draw = function(self)
				GRAFX.setColor(ternary { IF = self.pressed, THEN = self.pressedColor, ELSE = self.color })
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
				self.pressed = self:mouseInBounds(mx, my)
				return self.pressed
			end,

			handleMousereleased = function(self, mx, my)
				if self.pressed then
					self.pressed = false
					return true
				end
			end,

			mouseInBounds = function(self, mx, my)
				return mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + 30
			end,

			generatePressedColor = function(self)
				return { self.color[1] / 3, self.color[2] / 3, self.color[3] / 3 }
			end,

		}):init()
	end,
}

local GRAFX   = love.graphics
local MOUSE   = love.mouse
local COLORS  = require("game/constants/colors")
local ternary = require("lib/util/ternary")

return {
	create = function(self, params)
		return ({
			text     = params.text,
			ext      = params.ext,
			fullText = params.text .. ternary { IF = params.ext, THEN = "." .. params.ext, ELSE = "" },
			x        = params.x,
			y        = params.y,
			w        = params.w,
			h        = 30,
			fontSize = params.fontSize or 20,
			inFocus  = false,
			cursorOn = false,
			timer    = 0,

			init = function(self)
				self.font = GRAFX.newFont(self.fontSize)

				return self
			end,

			draw = function(self)
				GRAFX.setColor(COLORS.VERY_DARK_GREY)
				GRAFX.rectangle("fill", self.x, self.y, self.w, self.h)
				GRAFX.setColor(COLORS.LIGHT_GREY)
				GRAFX.setFont(self.font)
				GRAFX.printf(self.fullText, self.x + 12, self.y + 3, 1000, "left")
				if not self.inFocus and self:mouseInBounds(MOUSE.getPosition()) then
					GRAFX.setLineWidth(1)
					GRAFX.setColor(COLORS.LIGHT_GREY)
					GRAFX.rectangle("line", self.x, self.y, self.w, self.h)
				end
				self:drawCursor()
			end,

			drawCursor = function(self)
				local textWidth = self.font:getWidth(self.text)
				if self.cursorOn and self.inFocus then
					GRAFX.setLineWidth(1)
					GRAFX.setColor(COLORS.LIGHT_BLUE)
					GRAFX.rectangle("line", self.x + 12 + textWidth, self.y, 1, self.h)
				end
			end,

			update = function(self, dt)
				self.timer = self.timer + (60 * dt)
				if self.timer > 20 then
					self.timer = 0
					self.cursorOn = not self.cursorOn
				end
			end,

			handleMousepressed = function(self, mx, my)
                if self:mouseInBounds(mx, my) then
                    self.inFocus = true
                end
            end,

			mouseInBounds = function(self, mx, my)
                return mx > self.x and mx < self.x + self.w and my > self.y and my < self.y + self.h
            end,

            setText = function(self, text)
            	self.text = text
            	self.fullText = self.text .. ternary { IF = self.ext, THEN = "." .. self.ext, ELSE = "" }
            end,

		}):init()
	end,
}

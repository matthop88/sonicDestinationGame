local GRAFX          = love.graphics
local MOUSE          = love.mouse

local COLORS         = require("game/constants/colors")

return {
    create = function(self, params)
        return ({
            x       = params.x       or 300,
            y       = params.y       or 100,
            w       = params.w       or 200,
            h       = params.h       or 400,
            caption = params.caption or "Untitled Dialog",
            visible = params.visible,

            FONT    = GRAFX.newFont(20),
                
        	init    = function(self, params)
                self.okButton = require("plugins/modules/fileSaver/button"):create {
                    text = params.okText or "OK",
                    x    = self.x + self.w - 120,
                    y    = self.y + self.h -  50,
                    w    = 100,
                }
                self.cancelButton = require("plugins/modules/fileSaver/button"):create {
                    text  = params.cancelText      or "Cancel",
                    x     = self.x + self.w - 230,
                    y     = self.y + self.h -  50,
                    w     = 100,
                    color = COLORS.MEDIUM_GREY,
                }
        		return self
        	end,

            draw = function(self)
                self:drawPanel()
                self:drawCaption()
                self:drawButtons()
            end,

            drawPanel = function(self)         
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x, self.y, self.w, self.h, 20, 20)
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.setLineWidth(1)
                GRAFX.rectangle("line", self.x, self.y, self.w, self.h, 20, 20)
            end,

            drawCaption = function(self)
                GRAFX.setColor(COLORS.BURNT_ORANGE)
                GRAFX.rectangle("fill", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.JET_BLACK)
                GRAFX.setFont(self.FONT)
                GRAFX.printf(self.caption, self.x, self.y + 3, self.w, "center")
                GRAFX.setColor(COLORS.LIGHT_GREY)
                GRAFX.setLineWidth(1)
                GRAFX.rectangle("line", self.x, self.y, self.w, 45, 20, 20)
                GRAFX.setColor(COLORS.DARK_GREY)
                GRAFX.rectangle("fill", self.x + 1, self.y + 30, self.w - 2, 16)
            end,

            drawButtons = function(self)
                self.cancelButton:draw()
                self.okButton:draw()
            end,

        }):init(params)

    end,
}

local DURATION = 180
local GRAFX    = love.graphics
local FONT     = GRAFX.newFont(40)
local COLOR    = require("game/constants/colors")

return {
    message  = nil,
    
    x  = 0,
    y  = GRAFX.getHeight() - 60,
    w  = GRAFX.getWidth(),
    h  = 70,

    timer   = 0,

    draw = function(self)
        if self.message ~= nil then
            self:drawBox()
            self:drawMessage()
        end
    end,

    drawBox = function(self)
        GRAFX.setColor(COLOR.TRANSLUCENT_BLACK)
        GRAFX.rectangle("fill", 0,  self.y - 10, self.w, self.h)

        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.rectangle("line", 0,  self.y - 10, self.w, self.h) 
    end,

    drawMessage = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setFont(FONT)

        GRAFX.printf(self.message, self.x, self.y, self.w, "center")
    end,

    update = function(self, dt)
        if self.timer > 0 then 
            self.timer = self.timer - (60 * dt)
        else
            self.message = nil
        end
    end,

    print = function(self, message)
        self.message = message
        print("Printing to Readout: ", message)
        self.timer = DURATION
    end,
}

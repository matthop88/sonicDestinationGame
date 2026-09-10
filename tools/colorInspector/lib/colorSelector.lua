local COLOR = require("game/constants/colors")

return {
    color     = nil,
    intensity = 0,

    set = function(self, r, g, b)
        self.color     = { r, g, b }
        self.intensity = (r * r) + (g * g) + (b * b)
    end,

    clear = function(self)
        self.color = nil
        self.intensity = 0
    end,

    draw = function(self)
        if self.color then
            local mx, my = love.mouse.getPosition()

            self:drawBox(mx, my)
            self:drawOutline(mx, my)
        end
    end,

    drawBox = function(self, mx, my)
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", mx - 50, my - 50, 100, 100)
    end,

    drawOutline = function(self, mx, my)
        love.graphics.setColor(self:getBorderColor())

        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", mx - 50, my - 50, 100, 100)
    end,

    getBorderColor = function(self)
        if self.intensity < 0.2 then return COLOR.PURE_WHITE
        else                         return COLOR.JET_BLACK   end
    end,
    
}

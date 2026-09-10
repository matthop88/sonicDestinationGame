local COLOR = require("game/constants/colors")

return {
    color = nil,

    set = function(self, r, g, b)
        self.color = { r, g, b }
    end,

    clear = function(self)
        self.color = nil
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
        if self:getColorIntensity() < 0.2 then 
            return COLOR.PURE_WHITE
        else
            return COLOR.JET_BLACK
        end
    end,

    getColorIntensity = function(self)
        if self.color then
            return (self.color[1] * self.color[1]) + (self.color[2] * self.color[2]) + (self.color[3] * self.color[3])
        else
            return 0
        end
    end,

}

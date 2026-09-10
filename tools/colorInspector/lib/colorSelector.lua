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

            love.graphics.setColor(self.color)
            love.graphics.rectangle("fill", mx - 50, my - 50, 100, 100)

            love.graphics.setColor(COLOR.JET_BLACK)
            love.graphics.setLineWidth(3)
            love.graphics.rectangle("line", mx - 50, my - 50, 100, 100)
        end
    end,

}

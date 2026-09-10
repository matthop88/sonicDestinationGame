local COLOR = require("game/constants/colors")
local GRAFX = love.graphics

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
        GRAFX.setColor(self.color)
        GRAFX.rectangle("fill", mx - 50, my - 50, 100, 100)
    end,

    drawOutline = function(self, mx, my)
        GRAFX.setColor(self:getBorderColor())

        GRAFX.setLineWidth(3)
        GRAFX.rectangle("line", mx - 50, my - 50, 100, 100)
    end,

    getBorderColor = function(self)
        if self.intensity < 0.2 then return COLOR.PURE_WHITE
        else                         return COLOR.JET_BLACK   end
    end,

    identifyColorFromImageAt = function(self, imageView, mx, my)
        local x, y = imageView:screenToImageCoordinates(mx, my)

        x = math.max(0, math.min(imageView:getWidth()  - 1, x))
        y = math.max(0, math.min(imageView:getHeight() - 1, y))

        return imageView:getPixelAt(math.floor(x), math.floor(y))
    end,
    
}

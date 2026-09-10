local COLOR = require("game/constants/colors")
local GRAFX = love.graphics

return {
    create = function(self, params)
        return {
            imageView = params.imageView,

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

            selectColorAt = function(self, mx, my, callback)
                local x, y = self.imageView:screenToImageCoordinates(mx, my)

                x = math.max(0, math.min(self.imageView:getWidth()  - 1, x))
                y = math.max(0, math.min(self.imageView:getHeight() - 1, y))

                local r, g, b = self.imageView:getPixelAt(math.floor(x), math.floor(y))
                self:set(r, g, b)

                if callback then
                    callback(r, g, b)
                end
            end,

        }
        
    end,
    
}

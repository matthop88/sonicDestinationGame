local GRAFX  = love.graphics
local COLOR  = requireRelative("constants/colors")

return ({
    image        = GRAFX.newImage(relativePath("resources/images/spriteSheets/sonic1/sonic1.png")),
    standingRect = { x = 43, y = 257, w = 32, h = 40 },
    standingQuad = nil,

    offset       = { x = 16, y = 20 },
    scale        = 3,

    init = function(self)
        self.standingQuad = GRAFX.newQuad(self.standingRect.x,   self.standingRect.y,
                                          self.standingRect.w,   self.standingRect.h,
                                          self.image:getWidth(), self.image:getHeight())

        self.image:setFilter("nearest", "nearest")

        return self
    end,

    draw = function(self, x, y)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.draw(self.image, self.standingQuad, 
                   self:getImageX(x), self:getImageY(y),
                   0, self.scale, self.scale)
    end,

    getImageX = function(self, x)    return x - (self.offset.x * self.scale) end,
    getImageY = function(self, y)    return y - (self.offset.y * self.scale) end,

}):init()

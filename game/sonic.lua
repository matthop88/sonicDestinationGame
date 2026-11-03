local GRAFX  = love.graphics
local COLOR  = requireRelative("constants/colors")

return ({
    x = 464,   y = 456,
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

    draw = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.draw(self.image, self.standingQuad, 
                   self.x - (self.offset.x * self.scale), 
                   self.y - (self.offset.y * self.scale), 
                   0, self.scale, self.scale)
    end,

    moveTo = function(self, x, y)
        self.x, self.y = x, y
    end,

}):init()

local GRAFX  = love.graphics
local COLOR  = requireRelative("constants/colors")

return ({
    x = 464,   y = 456,
    image        = GRAFX.newImage(relativePath("resources/images/spriteSheets/sonic1/sonic1.png")),
    standingRect = { x = 43, y = 257, w = 32, h = 40 },
    standingQuad = nil,

    init = function(self)
        self.standingQuad = GRAFX.newQuad(self.standingRect.x,   self.standingRect.y,
                                          self.standingRect.w,   self.standingRect.h,
                                          self.image:getWidth(), self.image:getHeight())

        self.image:setFilter("nearest", "nearest")

        return self
    end,

    draw = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.draw(self.image, self.standingQuad, self.x, self.y, 0, 3, 3)
    end,

}):init()

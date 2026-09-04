--------------------------------------------------------------
--                       Private Members                    --
--------------------------------------------------------------

local COLOR = require("game/constants/colors")

--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    image     = love.graphics.newImage("game/resources/images/spriteSheets/sonic1/sonic1.png"),
               -- https://www.spriters-resource.com/sega_genesis_32x/sonicth1/sheet/21628/
    x         = 0,
    y         = 0,

    scale     = 5,

    draw      = function(self)
        love.graphics.setColor(COLOR.PURE_WHITE)
        love.graphics.draw(self.image, self.x * self.scale, self.y * self.scale, 0, self.scale, self.scale)
    end,

    move      = function(self, deltaX, deltaY)
        self.x = self.x + deltaX
        self.y = self.y + deltaY
    end,

    keepInBounds = function(self)
        self.x = math.min(0, math.max(self.x, (love.graphics.getWidth()  / self.scale) - self.image:getWidth()))
        self.y = math.min(0, math.max(self.y, (love.graphics.getHeight() / self.scale) - self.image:getHeight()))
    end,
    
}

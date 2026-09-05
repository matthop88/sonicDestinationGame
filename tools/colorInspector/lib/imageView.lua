--------------------------------------------------------------
--                       Private Members                    --
--------------------------------------------------------------

local COLOR = require("game/constants/colors")
local GRAFX = love.graphics

--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    image     = GRAFX.newImage("game/resources/images/spriteSheets/sonic1/sonic1.png"),
               -- https://www.spriters-resource.com/sega_genesis_32x/sonicth1/sheet/21628/
    x         = 0,
    y         = 0,

    scale     = 1,

    --------------------------------------------------------------------------------------
    draw               = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.draw(self.image, self.x * self.scale, self.y * self.scale, 0, self.scale, self.scale)
    end,

    move               = function(self, deltaX, deltaY)
        self.x = self.x + deltaX
        self.y = self.y + deltaY
    end,

    screenToImageCoordinates = function(self, screenX, screenY)
        local x = screenX / self.scale - self.x
        local y = screenY / self.scale - self.y
        
        return x, y
    end,

    scaleGeometrically = function(self, scaleDelta, px, py)
        -- 1. Translate x, y so that point at (px, py) is at upper left corner of screen
        local dx = px / self.scale
        local dy = py / self.scale

        self:move(-dx, -dy)
        
        -- 2. Scale in same manner as before
        self.scale = self.scale + (scaleDelta * self.scale)

        -- 3. Translate x, y back so that point at upper left corner of screen becomes (px, py)
        dx = px / self.scale
        dy = py / self.scale

        self:move(dx, dy)
        
    end,

    keepInBounds       = function(self)
        self.x = math.min(0, math.max(self.x, (GRAFX.getWidth()  / self.scale) - self.image:getWidth()))
        self.y = math.min(0, math.max(self.y, (GRAFX.getHeight() / self.scale) - self.image:getHeight()))
    end,
    
}

local MOUSE = love.mouse

local ENGINE = requireRelative("lib/engine")

return ({
    init = function(self)
        self.prevX, self.prevY = MOUSE.getPosition()

        if __PARAMS["scribbleFile"] then
            ENGINE:readFromFile(__PARAMS["scribbleFile"])
        end
        
        return self
    end,

    handleDraw          = function(self)
        ENGINE:draw()
    end,

    handleUpdate        = function(self, dt)
        ENGINE:update(dt)

        local x, y = MOUSE.getPosition()

        if self.prevX ~= x or self.prevY ~= y then
            if MOUSE.isDown(1) then ENGINE:mousedragged(x, y)
            else                    ENGINE:mousemoved(x, y)    end

            self.prevX, self.prevY = x, y
        end
    end,

    handleKeypressed    = function(self, key)
        ENGINE:keypressed(key)
    end,

    handleKeyreleased   = function(self, key)
        ENGINE:keyreleased(key)
    end,

    handleMousepressed  = function(self, mx, my)
        ENGINE:mousepressed(mx, my)
    end,

    handleMousereleased = function(self, mx, my)
        ENGINE:mousereleased(mx, my)
    end,

}):init()

local MOUSE = love.mouse

local ENGINE = {
    draw          = function(self)
        -- ...
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        -- ...
    end,

    keyreleased   = function(self, key)
        -- ...
    end,

    mousepressed  = function(self, mx, my)
        -- ...
    end,

    mousereleased = function(self, mx, my)
        -- ...
    end,

    mousemoved    = function(self, mx, my)
        print("Pen moved   to (" .. mx .. ", " .. my .. ")")
    end,

    mousedragged  = function(self, mx, my)
        print("Pen dragged to (" .. mx .. ", " .. my .. ")")
    end,

}

return ({
    init = function(self)
        self.prevX, self.prevY = MOUSE.getPosition()

        return self
    end,

    handleDraw          = function(self)
        ENGINE:draw()
    end,

    handleUpdate        = function(self, dt)
        ENGINE:update(dt)

        local x, y = MOUSE.getPosition()

        if self.prevX ~= x or self.prevY ~= y then
            if MOUSE.isDown(1) then
                ENGINE:mousedragged(x, y)
            else
                ENGINE:mousemoved(x, y)
            end

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

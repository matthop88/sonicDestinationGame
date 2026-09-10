local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

return {
    draw          = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.rectangle("fill", mx - 2, my - 2, 5, 5)
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

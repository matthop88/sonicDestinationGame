local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

return {
    history = { },

    draw          = function(self)
        self:drawHistory()
        self:drawCursor()
    end,

    drawHistory   = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)

        local prevX, prevY = nil, nil
        
        for n, pt in ipairs(self.history) do
            if n == 1 then GRAFX.rectangle("fill", pt.x - 2, pt.y - 2, 5, 5)
            else           GRAFX.line(prevX, prevY, pt.x, pt.y)            end

            prevX, prevY = pt.x, pt.y
        end
    end,

    drawCursor    = function(self)
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
        print("Pen down    at (" .. mx .. ", " .. my .. ")")
        table.insert(self.history, { x = mx, y = my })
    end,

    mousereleased = function(self, mx, my)
        print("Pen up      at (" .. mx .. ", " .. my .. ")")
    end,

    mousemoved    = function(self, mx, my)
        print("Pen moved   to (" .. mx .. ", " .. my .. ")")
    end,

    mousedragged  = function(self, mx, my)
        print("Pen dragged to (" .. mx .. ", " .. my .. ")")
        table.insert(self.history, { x = mx, y = my })
    end,

}

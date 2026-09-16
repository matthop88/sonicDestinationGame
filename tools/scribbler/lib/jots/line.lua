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

        GRAFX.setLineWidth(1)
        
        for n, pt in ipairs(self.history) do
            if n > 1 then 
                GRAFX.line(prevX, prevY, pt.x, pt.y)            
            end

            prevX, prevY = pt.x, pt.y
        end
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(COLOR.PURE_WHITE)

        if #self.history > 0 then
            local lastPt = self.history[#self.history]

            GRAFX.line(lastPt.x, lastPt.y, mx, my)
        end

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

    penDown  = function(self, mx, my)
        print("Pen down    at (" .. mx .. ", " .. my .. ")")
        table.insert(self.history, { x = mx, y = my })
    end,

    penUp = function(self, mx, my)
        print("Pen up      at (" .. mx .. ", " .. my .. ")")
    end,

    penMoved    = function(self, mx, my)
        print("Pen moved   to (" .. mx .. ", " .. my .. ")")
    end,

    penDragged  = function(self, mx, my)
        print("Pen dragged to (" .. mx .. ", " .. my .. ")")
    end,

}

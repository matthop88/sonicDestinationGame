local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local SCRIBBLE_JOT = {
    create = function(self)
        return {
            data = { },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)

                local prevX, prevY = nil, nil
                
                GRAFX.setLineWidth(5)
                
                for n, pt in ipairs(self.data) do
                    if n == 1 then GRAFX.rectangle("fill", pt.x - 2, pt.y - 2, 5, 5)
                    else           GRAFX.line(prevX, prevY, pt.x, pt.y)            end

                    prevX, prevY = pt.x, pt.y
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.data, { x = x, y = y })
            end,

        }
    end,
}

return {
    jot = SCRIBBLE_JOT:create(),

    draw   = function(self)
        self.jot:draw()
        self:drawCursor()
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

    penDown  = function(self, mx, my)
        print("Pen down    at (" .. mx .. ", " .. my .. ")")
        self.jot:addPoint(mx, my)
    end,

    penUp = function(self, mx, my)
        print("Pen up      at (" .. mx .. ", " .. my .. ")")
    end,

    penMoved    = function(self, mx, my)
        print("Pen moved   to (" .. mx .. ", " .. my .. ")")
    end,

    penDragged  = function(self, mx, my)
        print("Pen dragged to (" .. mx .. ", " .. my .. ")")
        self.jot:addPoint(mx, my)
    end,

}

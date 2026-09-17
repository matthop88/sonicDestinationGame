local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local SCRIBBLE_JOT = {
    create = function(self)
        return {
            data = { },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)

                GRAFX.setLineWidth(5)
                
                if #self.data > 0 then
                    if #self.data > 2 then
                        GRAFX.line(self.data)
                    else
                        GRAFX.line(self.data[1], self.data[2], self.data[1], self.data[2])
                    end
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.data, x)
                table.insert(self.data, y)
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
        self.jot:addPoint(mx, my)
    end,

    penUp = function(self, mx, my, publishJot)
        publishJot(self.jot)
        self.jot = SCRIBBLE_JOT:create()
    end,

    penMoved    = function(self, mx, my)
        -- ...
    end,

    penDragged  = function(self, mx, my)
        self.jot:addPoint(mx, my)
    end,

    revert = function(self)
        self.jot = SCRIBBLE_JOT:create()
    end,

}

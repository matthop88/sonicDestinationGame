local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local SCRIBBLE_JOT = {
    create = function(self, data)
        return {
            data = data or { points = {} },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setLineWidth(5)
                
                local points = self.data.points

                if #points > 0 then
                    if   #points > 2 then GRAFX.line(points)
                    else                  GRAFX.line(points[1], points[2], points[1], points[2]) end
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.data.points, x)
                table.insert(self.data.points, y)
            end,

        }
    end,

}

return {
    name = "scribble",
    
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

    penDown  = function(self, mx, my)
        self.jot:addPoint(mx, my)
    end,

    penUp = function(self, mx, my, publishJot)
        publishJot(self.jot)
        self.jot = SCRIBBLE_JOT:create()
    end,

    penDragged  = function(self, mx, my)
        self.jot:addPoint(mx, my)
    end,

    revert = function(self)
        self.jot = SCRIBBLE_JOT:create()
    end,

    fromData = function(self, data)
        return SCRIBBLE_JOT:create(data)
    end,

}

local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local LINE_JOT = {
    create = function(self)
        return {
            data = { points = {} },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)

                GRAFX.setLineWidth(1)
                
                local points = self.data.points

                if #points > 0 then
                    if   #points > 2 then GRAFX.line(points)
                    else GRAFX.line(points[1], points[2], points[1], points[2]) end
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.data.points, x)
                table.insert(self.data.points, y)
            end,

            isEmpty = function(self)
                return #self.data.points == 0
            end,

            getLastPoint = function(self)
                local points = self.data.points

                return { x = points[#points - 1], y = points[#points] }
            end,

        }

    end,


}

return {
    jot = LINE_JOT:create(),

    draw          = function(self)
        self.jot:draw()
        self:drawCursor()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(COLOR.PURE_WHITE)

        if not self.jot:isEmpty() then
            local lastPt = self.jot:getLastPoint()

            GRAFX.line(lastPt.x, lastPt.y, mx, my)
        end

        GRAFX.rectangle("fill", mx - 2, my - 2, 5, 5)
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key, publishJot)
        if key == "return" and not self.jot:isEmpty() then 
            publishJot(self.jot)
            self.jot = LINE_JOT:create()
        end
    end,

    keyreleased   = function(self, key)
        -- ...
    end,

    penDown  = function(self, mx, my)
        self.jot:addPoint(mx, my)
    end,

    penUp = function(self, mx, my)
        -- ...
    end,

    penMoved    = function(self, mx, my)
        -- ...
    end,

    penDragged  = function(self, mx, my)
        -- ...
    end,

    revert = function(self)
        self.jot = LINE_JOT:create()
    end,

}

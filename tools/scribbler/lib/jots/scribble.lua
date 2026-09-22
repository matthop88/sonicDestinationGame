local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local SCRIBBLE_JOT = {
    create = function(self, points)
        return {
            points = points or {},

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setLineWidth(5)

                local prevX, prevY = nil, nil
                
                for n, pt in ipairs(self.points) do
                    if n == 1 then GRAFX.rectangle("fill", pt.x - 2, pt.y - 2, 5, 5)
                    else           GRAFX.line(prevX, prevY, pt.x, pt.y)          end

                    prevX, prevY = pt.x, pt.y
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.points, { x = x, y = y })
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

    fromDataObj = function(self, scribbleJotObj)
        return SCRIBBLE_JOT:create(scribbleJotObj.points)
    end,

}

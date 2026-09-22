local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local LINE_JOT = {
    create = function(self, points)
        return {
            points = points or {},

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setLineWidth(1)
                
                local prevX, prevY = nil, nil

                for n, pt in ipairs(self.points) do
                    if n > 1 then
                        GRAFX.line(prevX, prevY, pt.x, pt.y)
                    end

                    prevX, prevY = pt.x, pt.y
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.points, { x = x, y = y })
            end,

            isEmpty = function(self)
                return #self.points == 0
            end,

            getLastPoint = function(self)
                return self.points[#self.points - 1]
            end,

        }

    end,

}

return {
    name = "line",
    
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

    keypressed    = function(self, key, publishJot)
        if     key == "return" and not self.jot:isEmpty() then 
            publishJot(self.jot)
            self.jot = LINE_JOT:create()
        end
    end,

    penDown  = function(self, mx, my)
        self.jot:addPoint(mx, my)
    end,

    revert = function(self)
        self.jot = LINE_JOT:create()
    end,

    fromDataObj = function(self, lineJotObj)
        return LINE_JOT:create(lineJotObj.points)
    end,

    revert = function(self)
        self.jot = LINE_JOT:create()
    end,

}

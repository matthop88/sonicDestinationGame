local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local SCRIBBLE_JOT = {
    create = function(self, data)
        return {
            NAME = "scribble",
            
            data = data or { points = {} },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setLineWidth(5)
                
                local points = self.data.points

                if #points > 0 then
                    if   #points > 2 then GRAFX.line(points)
                    else                  GRAFX.line(points[1] - 2, points[2] + 0.5, points[1] + 2, points[2] + 0.5) end
                end
            end,

            addPoint = function(self, x, y)
                if self:doWeOptimize(x, y) then
                    self.data.points[#self.data.points - 1] = x
                    self.data.points[#self.data.points]     = y
                else
                    table.insert(self.data.points, x)
                    table.insert(self.data.points, y)
                end
            end,

            doWeOptimize = function(self, x, y)
                local numPoints = #self.data.points

                if numPoints < 6 then return false end

                return (self:isCloseEnough(self.data.points[numPoints - 3], self.data.points[numPoints - 1])
                   and  self:isCloseEnough(self.data.points[numPoints - 1], x))
                    or (self:isCloseEnough(self.data.points[numPoints - 2], self.data.points[numPoints])
                   and  self:isCloseEnough(self.data.points[numPoints],     y))
            end,

            isCloseEnough = function(self, p1, p2) 
                return math.abs(p1 - p2) < 3 
            end,

        }
    end,

}

return {
    name = "scribble",
    
    jot = SCRIBBLE_JOT:create(),

    draw   = function(self)
        self.jot:draw()
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

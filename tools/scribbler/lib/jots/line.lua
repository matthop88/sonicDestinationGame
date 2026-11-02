local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local LINE_JOT = {
    create = function(self, data)
        return {
            NAME  = "line",
            
            data  = data or { points = {} },
            color = COLOR.PURE_WHITE,

            draw = function(self)
                GRAFX.setColor(self.color)
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

            setColor = function(self, color)
                self.color = color
            end,

        }

    end,

}

return {
    name  = "line",
    
    jot   = LINE_JOT:create(),
    color = COLOR.PURE_WHITE,

    draw          = function(self)
        self.jot:draw()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(self.color)

        if not self.jot:isEmpty() then
            local lastPt = self.jot:getLastPoint()

            GRAFX.line(lastPt.x, lastPt.y, mx, my)
        end

        GRAFX.setLineWidth(1)
        GRAFX.line(mx - 25, my, mx -  5, my)
        GRAFX.line(mx, my - 25, mx, my -  5)
        GRAFX.line(mx +  5, my, mx + 25, my)
        GRAFX.line(mx, my +  5, mx, my + 25)
        GRAFX.rectangle("line", mx - 5, my - 5, 11, 11)
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

    revert   = function(self)       self.jot = LINE_JOT:create() end,
    fromData = function(self, data) return LINE_JOT:create(data) end,

    setColor = function(self, color)
        self.color = color
        if self.jot then self.jot:setColor(color) end
    end,

}

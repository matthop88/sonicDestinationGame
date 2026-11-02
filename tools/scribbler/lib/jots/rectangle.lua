local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local RECTANGLE_JOT = {
    create = function(self, data)
        return {
            NAME  = "rectangle",
            
            data  = data,
            color = COLOR.PURE_WHITE,

            draw = function(self)
                if self.data ~= nil then
                    GRAFX.setColor(self.color)
                    GRAFX.setLineWidth(3)
                    
                    GRAFX.rectangle("line", self.data.x, self.data.y, self.data.w, self.data.h)
                end
            end,

            create = function(self, x, y)
                self.data = { x = x, y = y, w = 0, h = 0 }
            end,

            resize = function(self, x, y)
                if self.data ~= nil then
                    self.data.w, self.data.h = x - self.data.x, y - self.data.y
                end
            end,

            setColor = function(self, color)
                self.color = color
            end,

        }
    end,

}

return {
    name  = "rectangle",
    
    jot   = RECTANGLE_JOT:create(),
    color = COLOR.PURE_WHITE,

    draw   = function(self)
        self.jot:draw()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(self.color)

        GRAFX.setLineWidth(1)

        GRAFX.line(mx - 45, my, mx -  5, my)
        GRAFX.line(mx, my - 45, mx, my -  5)
        GRAFX.line(mx +  5, my, mx + 45, my)
        GRAFX.line(mx, my +  5, mx, my + 45)
        GRAFX.circle("line", mx, my, 17, 17)
    end,

    penDown  = function(self, mx, my)
        self.jot:create(mx, my)
    end,

    penUp = function(self, mx, my, publishJot)
        publishJot(self.jot)
        self.jot = RECTANGLE_JOT:create()
    end,

    penDragged  = function(self, mx, my)
        self.jot:resize(mx, my)
    end,

    revert   = function(self)       self.jot = RECTANGLE_JOT:create() end,
    fromData = function(self, data) return RECTANGLE_JOT:create(data) end,

    setColor = function(self, color)
        self.color = color
        if self.jot then self.jot:setColor(color) end
    end,

}

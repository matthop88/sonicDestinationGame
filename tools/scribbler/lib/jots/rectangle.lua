local GRAFX = love.graphics
local MOUSE = love.mouse
local COLOR = require("game/constants/colors")

local RECTANGLE_JOT = {
    create = function(self, data)
        return {
            NAME = "rectangle",
            
            data = data,

            draw = function(self)
                if self.data ~= nil then
                    GRAFX.setColor(COLOR.PURE_WHITE)
                    GRAFX.setLineWidth(5)
                    
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

        }
    end,

}

return {
    name = "rectangle",
    
    jot = RECTANGLE_JOT:create(),

    draw   = function(self)
        self.jot:draw()
    end,

    drawCursor    = function(self)
        if not love.mouse.isDown(1) then
            local mx, my = MOUSE.getPosition()

            MOUSE.setVisible(false)
            GRAFX.setColor(COLOR.PURE_WHITE)

            GRAFX.rectangle("fill", mx - 2, my - 2, 5, 5)
        end
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

    revert = function(self)
        self.jot = RECTANGLE_JOT:create()
    end,

    fromData = function(self, data)
        return RECTANGLE_JOT:create(data)
    end,

}

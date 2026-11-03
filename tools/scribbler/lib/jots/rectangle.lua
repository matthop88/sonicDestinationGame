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
                    if self.data.fill == true then 
                        GRAFX.setColor(self.data.fillColor or COLOR.PURE_WHITE)
                        GRAFX.rectangle("fill", self.data.x, self.data.y, self.data.w, self.data.h)
                    end
                    
                    GRAFX.setColor(self.data.color or COLOR_PURE_WHITE)
                    GRAFX.setLineWidth(self.data.thickness or 3)
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

            setColor     = function(self, color)     if self.data ~= nil then self.data.color     = color     end end,
            setFill      = function(self, fill)      if self.data ~= nil then self.data.fill      = fill      end end,
            setThickness = function(self, thickness) if self.data ~= nil then self.data.thickness = thickness end end,
            setFillColor = function(self, fillColor) if self.data ~= nil then self.data.fillColor = fillColor end end,

        }
    end,

}

return {
    name      = "rectangle",
    
    jot       = RECTANGLE_JOT:create(),
    color     = COLOR.PURE_WHITE,
    fill      = false,
    fillColor = COLOR.PURE_WHITE,
    thickness = 3,

    draw   = function(self)
        self.jot:draw()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(self.color)

        GRAFX.setLineWidth(self.thickness / 3)

        GRAFX.line(mx - 45, my, mx -  5, my)
        GRAFX.line(mx, my - 45, mx, my -  5)
        GRAFX.line(mx +  5, my, mx + 45, my)
        GRAFX.line(mx, my +  5, mx, my + 45)
        if self.fill then
            GRAFX.setColor(self.fillColor[1], self.fillColor[2], self.fillColor[3], 0.5)
            GRAFX.circle("fill", mx, my, 17, 17)
        else
            GRAFX.circle("line", mx, my, 17, 17)
        end
    end,

    penDown  = function(self, mx, my)
        self.jot:create(mx, my)
        self.jot:setFill(self.fill)
        self.jot:setThickness(self.thickness)
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
        if self.fill then self.fillColor = color
        else              self.color = color  end
        
        if self.jot then 
            self.jot:setFillColor(self.fillColor) 
            self.jot:setColor(self.color)
        end
    end,

    toggleFill = function(self)
        if self.jot then 
            self.fill = not self.fill
            self.jot:setFill(self.fill) 
        end
    end,

    setThickness = function(self, thickness)
        self.thickness = thickness
        if self.jot then self.jot:setThickness(thickness) end
    end,    

}

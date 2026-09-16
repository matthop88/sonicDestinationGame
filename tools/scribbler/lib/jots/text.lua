local GRAFX      = love.graphics
local MOUSE      = love.mouse
local KEYBOARD   = love.keyboard

local COLOR      = require("game/constants/colors")

local FONT_CACHE = requireRelative("lib/util/fontCache")
local MESSAGE    = "Hello There!"

local TEXT_JOT = {
    create = function(self)
        return {
            data = nil,

            draw = function(self)
                if self.data ~= nil then
                    GRAFX.setColor(COLOR.PURE_WHITE)
                    GRAFX.setFont(FONT_CACHE:getFont(self.data.size))
                    GRAFX.printf(self.data.message, self.data.x, self.data.y, 1000, "left")
                end
            end,

            addText = function(self, x, y, size, message)
                self.data = { x = x, y = y, size = size, message = message, }
            end,

        }
    end,
}

return {
    jot = TEXT_JOT:create(),

    fontSize = 32,
    
    draw   = function(self)
        self.jot:draw()
        self:drawCursor()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setFont(FONT_CACHE:getFont(self.fontSize))
        GRAFX.printf(MESSAGE, mx, my, 1000, "left")
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        if      key == "-"                                         then 
            self.fontSize = math.max(9,   self.fontSize - 1)
        elseif  key == "=" and KEYBOARD.isDown("lshift", "rshift") then
            self.fontSize = math.min(128, self.fontSize + 1)
        end
    end,

    keyreleased   = function(self, key)
        -- ...
    end,

    penDown  = function(self, mx, my, publishJot)
        self.jot:addText(mx, my, self.fontSize, MESSAGE)
        publishJot(self.jot)
        self.jot = TEXT_JOT:create()
    end,

    penUp = function(self, mx, my, publishJot)
        -- ...
    end,

    penMoved    = function(self, mx, my)
        -- ...
    end,

    penDragged  = function(self, mx, my)
        -- ...
    end,

    revert = function(self)
        self.jot = TEXT_JOT:create()
    end,

}

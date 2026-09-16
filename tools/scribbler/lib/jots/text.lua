local GRAFX      = love.graphics
local MOUSE      = love.mouse

local COLOR      = require("game/constants/colors")

local FONT_CACHE = requireRelative("lib/util/fontCache")
local FONT       = FONT_CACHE:getFont(32)
local MESSAGE    = "Hello There!"

local TEXT_JOT = {
    create = function(self)
        return {
            data = nil,

            draw = function(self)
                if self.data ~= nil then
                    GRAFX.setColor(COLOR.PURE_WHITE)
                    GRAFX.setFont(FONT)
                    GRAFX.printf(MESSAGE, self.data.x, self.data.y, 1000, "left")
                end
            end,

            addPoint = function(self, x, y)
                self.data = { x = x, y = y }
            end,

        }
    end,
}

return {
    jot = TEXT_JOT:create(),

    draw   = function(self)
        self.jot:draw()
        self:drawCursor()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setFont(FONT)
        GRAFX.printf(MESSAGE, mx, my, 1000, "left")
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        -- ...
    end,

    keyreleased   = function(self, key)
        -- ...
    end,

    penDown  = function(self, mx, my, publishJot)
        self.jot:addPoint(mx, my)
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

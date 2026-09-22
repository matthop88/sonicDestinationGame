local GRAFX      = love.graphics
local MOUSE      = love.mouse
local KEYBOARD   = love.keyboard

local COLOR      = require("game/constants/colors")

local FONT_CACHE = requireRelative("lib/util/fontCache")
local MESSAGES   = require("game/util/navigableList"):create { 
                                                                "Hello There!",
                                                                "YOSHI!!!",
                                                                "Six, Seven!",
                                                             }

local TEXT_JOT = {
    create = function(self, x, y, fontSize, message)
        return {
            x        = x,
            y        = y,
            fontSize = fontSize,
            message  = message,

            draw = function(self)
                if self.message ~= nil then
                    GRAFX.setColor(COLOR.PURE_WHITE)
                    GRAFX.setFont(FONT_CACHE:getFont(self.fontSize))
                    GRAFX.printf(self.message, self.x, self.y, 1000, "left")
                end
            end,

            addText = function(self, x, y, fontSize, message)
                self.x, self.y, self.fontSize, self.message = x, y, fontSize, message
            end,

        }
    end,
}

return {
    name = "text",
  
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
        GRAFX.printf(MESSAGES:get(), mx, my, 1000, "left")
    end,

    keypressed    = function(self, key, publishJot)
        if      key == "-"                          then self.fontSize = math.max(9,   self.fontSize - 1)
        elseif  key == "=" 
            and KEYBOARD.isDown("lshift", "rshift") then self.fontSize = math.min(128, self.fontSize + 1)
        elseif  key == "tab"                        then self.changeMessage()
        end
    end,

    penDown  = function(self, mx, my, publishJot)
        self.jot:addText(mx, my, self.fontSize, MESSAGES:get())
        publishJot(self.jot)
        self.jot = TEXT_JOT:create()
    end,

    revert = function(self)
        self.jot = TEXT_JOT:create()
    end,

    changeMessage = function(self)
        if KEYBOARD.isDown("lshift", "rshift") then MESSAGES:prev()
        else                                        MESSAGES:next()  end
    end,

    fromDataObj = function(self, textJotObj)
        return TEXT_JOT:create(textJotObj.x, textJotObj.y, textJotObj.fontSize, textJotObj.message)
    end,

}

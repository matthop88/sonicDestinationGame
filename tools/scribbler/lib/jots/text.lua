local GRAFX      = love.graphics
local MOUSE      = love.mouse
local KEYBOARD   = love.keyboard

local COLOR      = require("game/constants/colors")

local FONT_CACHE = requireRelative("lib/util/fontCache")
local MESSAGES   = require("game/util/navigableList"):create { 
                                                                "OH, NO!!!",
                                                                "The picture you requested",
                                                                "could NOT be found!",
                                                                "Yikes!",
                                                             }

local TEXT_JOT = {
    create = function(self, data)
        return {
            NAME  = "text",
      
            data  = data,
            color = COLOR.PURE_WHITE,

            draw = function(self)
                if self.data ~= nil then
                    GRAFX.setColor(self.color)
                    GRAFX.setFont(FONT_CACHE:getFont(self.data.fontSize))
                    GRAFX.printf(self.data.message, self.data.x, self.data.y, 1000, "left")
                end
            end,

            addText = function(self, x, y, size, message)
                self.data = { x = x, y = y, fontSize = size, message = message, }
            end,

            setColor = function(self, color)
                self.color = color
            end,

        }
    end,
}

return {
    name  = "text",
  
    jot   = TEXT_JOT:create(),
    color = COLOR.PURE_WHITE,

    fontSize = 32,
    
    draw   = function(self)
        self.jot:draw()
    end,

    drawCursor    = function(self)
        local mx, my = MOUSE.getPosition()

        MOUSE.setVisible(false)
        GRAFX.setColor(self.color)
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

    changeMessage = function(self)
        if KEYBOARD.isDown("lshift", "rshift") then MESSAGES:prev()
        else                                        MESSAGES:next()  end
    end,

    revert   = function(self)       self.jot = TEXT_JOT:create() end,
    fromData = function(self, data) return TEXT_JOT:create(data) end,

    setColor = function(self, color)
        self.color = color
        if self.jot then self.jot:setColor(color) end
    end,

}

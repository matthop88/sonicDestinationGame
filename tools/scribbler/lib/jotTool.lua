local KEYBOARD       = love.keyboard
local MOUSE          = love.mouse

local JOT_FACTORY    = requireRelative("lib/serialization/jotFactory")
local JOT_REPOSITORY = requireRelative("lib/serialization/jotRepository")

local JOT_COLORS     = require("game/util/navigableList"):create { 
                            { 1, 1, 1 },
                            { 1, 0, 0 },
                            { 0, 1, 0 },
                            { 0, 0, 1 },
                            { 1, 1, 0 },
                            { 1, 0, 1 },
                            { 0, 1, 1 },
                            { 0, 0, 0 },
                        }

return {
    currentJot = JOT_REPOSITORY:getJot("scribble"),

    draw       = function(self)
        self.currentJot:draw()
    end,

    drawCursor = function(self)
        self.currentJot:drawCursor()
    end,

    update        = function(self, dt)
        self.currentJot:setColor(JOT_COLORS:get())
        self.currentJot:update(dt)
    end,

    keypressed    = function(self, key, addToHistoryCallback)
        self.currentJot:keypressed(key, addToHistoryCallback)

        local previousJot = self.currentJot

        if     key == "l"                    then self.currentJot = JOT_REPOSITORY:getJot("line")
        elseif key == "t"                    then self.currentJot = JOT_REPOSITORY:getJot("text")
        elseif key == "r"                    then self.currentJot = JOT_REPOSITORY:getJot("rectangle")
        elseif key == "c"                    then 
            if KEYBOARD.isDown("lshift", "rshift") then JOT_COLORS:prev()
            else                                        JOT_COLORS:next() end
        elseif key == "f"                    then self.currentJot:toggleFill()
        elseif key >= "1" and key <= "9"     then self.currentJot:setThickness(tonumber(key))
        elseif key == "s" or key == "escape" then self.currentJot = JOT_REPOSITORY:getJot("scribble")
        end

        if previousJot ~= self.currentJot then previousJot:revert() end
    end,

    keyreleased   = function(self, key, addToHistoryCallback)
        self.currentJot:keyreleased(key, addToHistoryCallback)
    end,

    penDown       = function(self, mx, my, addToHistoryCallback)
        self.currentJot:penDown(mx, my, addToHistoryCallback)
    end,

    penUp         = function(self, mx, my, addToHistoryCallback)
        self.currentJot:penUp(mx, my, addToHistoryCallback)
    end,

    penMoved      = function(self, mx, my, addToHistoryCallback)
        self.currentJot:penMoved(mx, my, addToHistoryCallback)
    end,

    penDragged    = function(self, mx, my, addToHistoryCallback)
        self.currentJot:penDragged(mx, my, addToHistoryCallback)
    end,
}

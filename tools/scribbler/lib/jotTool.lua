local KEYBOARD       = love.keyboard
local MOUSE          = love.mouse

local JOT_FACTORY    = requireRelative("lib/serialization/jotFactory")
local JOT_REPOSITORY = requireRelative("lib/serialization/jotRepository")

return {
    currentJot = JOT_REPOSITORY:getJot("scribble"),
    
    draw       = function(self)
        self.currentJot:draw()
    end,

    drawCursor = function(self)
        self.currentJot:drawCursor()
    end,

    update        = function(self, dt)
        self.currentJot:update(dt)
    end,

    keypressed    = function(self, key, addToHistoryCallback)
        self.currentJot:keypressed(key, addToHistoryCallback)

        local previousJot = self.currentJot

        if     key == "l"                    then self.currentJot = JOT_REPOSITORY:getJot("line")
        elseif key == "t"                    then self.currentJot = JOT_REPOSITORY:getJot("text")
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

local KEYBOARD     = love.keyboard

local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")
local LINE_JOT     = requireRelative("lib/jots/line")
local TEXT_JOT     = requireRelative("lib/jots/text")

return {
    currentJot = SCRIBBLE_JOT,

    draw       = function(self)
        self.currentJot:draw()
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key, addToHistoryCallback)
        self.currentJot:keypressed(key, addToHistoryCallback)

        local previousJot = self.currentJot

        if     key == "l"                    then self.currentJot = LINE_JOT
        elseif key == "t"                    then self.currentJot = TEXT_JOT
        elseif key == "s" or key == "escape" then self.currentJot = SCRIBBLE_JOT  end

        if previousJot ~= self.currentJot then
            previousJot:revert()
        end
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

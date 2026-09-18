local DUMMY_FN   = function()
    -- do nothing
end

local requireJot = function(jotName)
    local jot = requireRelative("lib/jots/" .. jotName)

    if not jot.update      then jot.update      = DUMMY_FN end
    if not jot.keypressed  then jot.keypressed  = DUMMY_FN end
    if not jot.keyreleased then jot.keyreleased = DUMMY_FN end
    if not jot.penDown     then jot.penDown     = DUMMY_FN end
    if not jot.penUp       then jot.penUp       = DUMMY_FN end
    if not jot.penMoved    then jot.penMoved    = DUMMY_FN end
    if not jot.penDragged  then jot.penDragged  = DUMMY_FN end

    return jot
end

local KEYBOARD     = love.keyboard

local SCRIBBLE_JOT = requireJot("scribble")
local LINE_JOT     = requireJot("line")
local TEXT_JOT     = requireJot("text")


return {
    currentJot = SCRIBBLE_JOT,

    draw       = function(self)
        self.currentJot:draw()
    end,

    update        = function(self, dt)
        self.currentJot:update(dt)
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

local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")
local LINE_JOT     = requireRelative("lib/jots/line")

local CURRENT_JOT = SCRIBBLE_JOT

local addToHistoryCallback

local ENGINE = {
    history = { },

    draw          = function(self)
        for _, jot in ipairs(self.history) do
            jot:draw()
        end

        CURRENT_JOT:draw()
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        if     key == "l"                    then CURRENT_JOT = LINE_JOT
        elseif key == "s" or key == "escape" then CURRENT_JOT = SCRIBBLE_JOT
        else                                      CURRENT_JOT:keypressed(key, addToHistoryCallback)
        end
    end,

    keyreleased   = function(self, key)
        CURRENT_JOT:keyreleased(key, addToHistoryCallback)
    end,

    mousepressed  = function(self, mx, my)
        CURRENT_JOT:penDown(mx, my, addToHistoryCallback)
    end,

    mousereleased = function(self, mx, my)
        CURRENT_JOT:penUp(mx, my, addToHistoryCallback)
    end,

    mousemoved    = function(self, mx, my)
        CURRENT_JOT:penMoved(mx, my, addToHistoryCallback)
    end,

    mousedragged  = function(self, mx, my)
        CURRENT_JOT:penDragged(mx, my, addToHistoryCallback)
    end,

    addToHistory  = function(self, jot)
        table.insert(self.history, jot)
    end,

}

addToHistoryCallback = function(jot)
    ENGINE:addToHistory(jot)
end

return ENGINE

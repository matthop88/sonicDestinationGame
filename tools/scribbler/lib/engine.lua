local KEYBOARD     = love.keyboard

local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")
local LINE_JOT     = requireRelative("lib/jots/line")

local CURRENT_JOT = SCRIBBLE_JOT

local addToHistoryCallback

local ENGINE = {
    history = { 
        TAIL_INDEX = 0,

        draw = function(self)
            for n, jot in ipairs(self) do
                if n <= self.TAIL_INDEX then 
                    jot:draw()
                end

            end

        end,

        addJot = function(self, jot)
            self.TAIL_INDEX = self.TAIL_INDEX + 1
            self[self.TAIL_INDEX] = jot
        end,

        undo   = function(self)
            self.TAIL_INDEX = math.max(0, self.TAIL_INDEX - 1)
        end,

        redo   = function(self)
            self.TAIL_INDEX = math.min(#self, self.TAIL_INDEX + 1)
        end,

    },

    draw          = function(self)
        self.history:draw()

        CURRENT_JOT:draw()
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        if key == "z" and KEYBOARD.isDown("lgui", "rgui") then
            self:undo()
        else
            CURRENT_JOT:keypressed(key, addToHistoryCallback)
            if     key == "l"                    then CURRENT_JOT = LINE_JOT
            elseif key == "s" or key == "escape" then CURRENT_JOT = SCRIBBLE_JOT
            end
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
        self.history:addJot(jot)
    end,

    undo          = function(self)
        self.history:undo()
    end,

    redo          = function(self)
        self.history:redo()
    end,

}

addToHistoryCallback = function(jot)
    ENGINE:addToHistory(jot)
end

return ENGINE

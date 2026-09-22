local KEYBOARD     = love.keyboard

local JOT_TOOL     = requireRelative("lib/jotTool")
local DATA_READER  = requireRelative("lib/serialization/dataReader")
local addToHistoryCallback

local ENGINE = {
    history = { 
        TAIL_INDEX = 0,
        data       = {},

        draw = function(self)
            for n, jot in ipairs(self.data) do
                if n <= self.TAIL_INDEX then 
                    jot:draw()
                end
            end
        end,

        addJot = function(self, jot)
            self.TAIL_INDEX = self.TAIL_INDEX + 1
            self.data[self.TAIL_INDEX] = jot
        end,

        undo   = function(self)
            self.TAIL_INDEX = math.max(0, self.TAIL_INDEX - 1)
        end,

        redo   = function(self)
            self.TAIL_INDEX = math.min(#self.data, self.TAIL_INDEX + 1)
        end,

        clear  = function(self)
            self.TAIL_INDEX = 0
            self.data = {}
        end,

    },

    draw          = function(self)
        self.history:draw()

        JOT_TOOL:draw()
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        if     key == "z" and KEYBOARD.isDown("lgui", "rgui") then
            self:undoOrRedo()
        else
            JOT_TOOL:keypressed(key, addToHistoryCallback)
        end
    end,

    keyreleased   = function(self, key)
        JOT_TOOL:keyreleased(key, addToHistoryCallback)
    end,

    mousepressed  = function(self, mx, my)
        JOT_TOOL:penDown(mx, my, addToHistoryCallback)
    end,

    mousereleased = function(self, mx, my)
        JOT_TOOL:penUp(mx, my, addToHistoryCallback)
    end,

    mousemoved    = function(self, mx, my)
        JOT_TOOL:penMoved(mx, my, addToHistoryCallback)
    end,

    mousedragged  = function(self, mx, my)
        JOT_TOOL:penDragged(mx, my, addToHistoryCallback)
    end,

    addToHistory  = function(self, jot)
        self.history:addJot(jot)
    end,

    undoOrRedo    = function(self)
        if KEYBOARD.isDown("lshift", "rshift") then self:redo()
        else                                        self:undo()   end
    end,

    readFromFile  = function(self, filename)
        self.history:clear()
            
        for jot in DATA_READER:eachJot(filename) do 
            self.history:addJot(jot) 
        end
    end,

    undo          = function(self) self.history:undo()            end,
    redo          = function(self) self.history:redo()            end,

}

addToHistoryCallback = function(jot)
    ENGINE:addToHistory(jot)
end

return ENGINE

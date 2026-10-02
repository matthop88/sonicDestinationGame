local KEYBOARD     = love.keyboard

local JOT_TOOL     = requireRelative("lib/jotTool")
local DATA_READER  = requireRelative("lib/serialization/dataReader")
local DATA_WRITER  = require("lib/serialization/dataSerializer")

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

        eachJot = function(self)
            local index = 0
            local size  = self.TAIL_INDEX
            local data  = self.data

            return function()
                index = index + 1
                if index <= size then return data[index]
                else                  return nil         end               
            end
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
        elseif key == "s" and KEYBOARD.isDown("lgui", "rgui") then
            self:performSave()
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

    performSave = function(self)
        if KEYBOARD.isDown("lalt", "ralt") then self:captureScreenshot()
        else                                    self:saveScribbling()    end
    end,

    captureScreenshot = function(self)
        local filename = (__PARAMS["captureFile"] or "screenShot") .. ".png"
        love.graphics.captureScreenshot(filename)
        print("Captured image saved to " .. love.filesystem.getSaveDirectory() .. "/" .. filename)
    end,

    saveScribbling = function(self)
        local serializedData = DATA_WRITER:serialize(self:getSerializable())
        local filename = __PARAMS["outFile"] or "myNewScribble"
        local success, message = serializedData:writeToFile("tools/scribbler/data", filename)
        print(message)
    end,

    readFromFile  = function(self, filename)
        self.history:clear()
            
        for jot in DATA_READER:eachJot(filename) do 
            self.history:addJot(jot) 
        end
    end,

    undo          = function(self) self.history:undo()            end,
    redo          = function(self) self.history:redo()            end,

    getSerializable = function(self)
        local jots = {}
        for jot in self.history:eachJot() do 
            table.insert(jots, jot)
        end

        return {
            VERSION = "0.1",

            jots = jots,
        }
    end,

}

addToHistoryCallback = function(jot)
    ENGINE:addToHistory(jot)
end

return ENGINE

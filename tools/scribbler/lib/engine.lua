local KEYBOARD     = love.keyboard

local JOT_TOOL     = requireRelative("lib/jotTool")
local DATA_READER  = requireRelative("lib/serialization/dataReader")
local DATA_WRITER  = require("lib/serialization/dataSerializer")

local addToHistoryCallback

local ENGINE = {
    saving  = false,

    history = requireRelative("lib/history"),

    draw          = function(self)
        self.history:draw()

        JOT_TOOL:draw()
        
        if not self:isSaving() then JOT_TOOL:drawCursor() 
        else                        self:performSave()   end
    end,

    update        = function(self, dt)
        -- Do nothing
    end,

    keypressed    = function(self, key)
        if     key == "z" and KEYBOARD.isDown("lgui", "rgui") then
            self:undoOrRedo()
        elseif key == "s" and KEYBOARD.isDown("lgui", "rgui") then
            self:beginSave()
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

    undoOrRedo    = function(self)
        if KEYBOARD.isDown("lshift", "rshift") then self:redo()
        else                                        self:undo()   end
    end,

    readFromFile  = function(self, filename)
        self.history:clear()
            
        for jot in DATA_READER:eachJot(filename) do 
            self.history:addEntry(jot) 
        end
    end,

    undo          = function(self)      self.history:undo()        end,
    redo          = function(self)      self.history:redo()        end,

    addToHistory  = function(self, jot) self.history:addEntry(jot) end,
    
    getSerializable = function(self)
        local jots = {}
        for jot in self.history:eachEntry() do table.insert(jots, jot) end

        return {
            VERSION = "0.1",
            
            jots    = jots,
        }
    end,

    isSaving      = function(self) return self.saving              end,
    beginSave     = function(self) self.saving = true              end,

    performSave   = function(self)
        if KEYBOARD.isDown("lalt", "ralt") then self:captureScreenshot()
        else                                    self:saveScribbling()    end
        self.saving = false
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
 
}

addToHistoryCallback = function(jot)
    ENGINE:addToHistory(jot)
end

return ENGINE

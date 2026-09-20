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
local MOUSE        = love.mouse

local SCRIBBLE_JOT = requireJot("scribble")
local LINE_JOT     = requireJot("line")
local TEXT_JOT     = requireJot("text")

local JOT_FACTORY  = requireRelative("lib/jotFactory")


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
        elseif key == "s" or key == "escape" then self.currentJot = SCRIBBLE_JOT  
        elseif key == "/"                    then
            if previousJot == TEXT_JOT then
                local mx, my = MOUSE.getPosition()
                addToHistoryCallback(JOT_FACTORY:create { name = "text",
                    data = {
                        x        = mx, 
                        y        = my, 
                        fontSize = 24, 
                        message  = "Test, test, test!", 
                    }
                })
            elseif previousJot == LINE_JOT then
                local mx, my = MOUSE.getPosition()
                addToHistoryCallback(JOT_FACTORY:create { name = "line",
                    data = {
                        points = {
                            mx,       my,      --358, 373,
                            mx +  57, my - 68, --415, 305,
                            mx + 250, my - 67, --608, 306,
                            mx + 275, my +  6, --633, 379,
                        }
                    }
                })
            elseif previousJot == SCRIBBLE_JOT then
                local mx, my = MOUSE.getPosition()
                addToHistoryCallback(JOT_FACTORY:create { name = "scribble",
                    data = {
                        points = {
                            mx,       my,       --360, 375,
                            mx +  79, my +   7, --439, 382,
                            mx + 119, my +  11, --479, 386,
                            mx + 189, my +  12, --549, 387,
                            mx + 219, my +   8, --579, 383,
                            mx + 240, my +   4, --600, 379,
                            mx + 274, my +   3, --634, 378,
                        }
                    }
                })
            end
        end

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

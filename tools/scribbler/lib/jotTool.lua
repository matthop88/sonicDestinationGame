local KEYBOARD       = love.keyboard
local MOUSE          = love.mouse

local JOT_FACTORY    = requireRelative("lib/serialization/jotFactory")
local JOT_REPOSITORY = requireRelative("lib/serialization/jotRepository")

return {
    currentJot = JOT_REPOSITORY:getJot("scribble"),

    draw       = function(self)
        self.currentJot:draw()
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
        elseif key == "/"                    then
            if previousJot.name == "text" then
                local mx, my = MOUSE.getPosition()
                addToHistoryCallback(JOT_FACTORY:create { name = "text",
                    data = {
                        x        = mx, 
                        y        = my, 
                        fontSize = 24, 
                        message  = "Test, test, test!", 
                    }
                })
            elseif previousJot.name == "line" then
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
            elseif previousJot.name == "scribble" then
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

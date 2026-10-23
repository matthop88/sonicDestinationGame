--------------------------------------------------------------
--                       Private Methods                    --
--------------------------------------------------------------

local handleDraw = function(self) 
    for _, e in ipairs(self) do
        if e.draw then e:draw() end
    end
end

local handleUpdate = function(self, dt)
    for _, e in ipairs(self) do
        if e.update then e:update(dt) end
    end
end

local handleKeypressed = function(self, key)
    for _, e in ipairs(self) do
        if e.handleKeypressed then e:handleKeypressed(key) end
    end
end

local handleKeyreleased = function(self, key)
    for _, e in ipairs(self) do
        if e.handleKeyreleased then e:handleKeyreleased(key) end
    end
end

local handleMousepressed = function(self, mx, my)
    for _, e in ipairs(self) do
        if e.handleMousepressed then e:handleMousepressed(mx, my) end
    end
end

local handleMousereleased = function(self, mx, my)
    for _, e in ipairs(self) do
        if e.handleMousereleased then e:handleMousereleased(mx, my) end
    end
end

--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    create = function(self, libraryList)
        local libClasses = {
            handleDraw          = handleDraw,
            handleUpdate        = handleUpdate,
            handleKeypressed    = handleKeypressed,
            handleKeyreleased   = handleKeyreleased,
            handleMousepressed  = handleMousepressed,
            handleMousereleased = handleMousereleased,
        }

        for _, e in ipairs(libraryList) do
            table.insert(libClasses, e)
        end

        return libClasses
    end,
}

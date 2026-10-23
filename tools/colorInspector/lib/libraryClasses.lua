return {
    create = function(self, libraryList)
        local libClasses = {
            handleDraw = function(self) 
                for _, e in ipairs(self) do
                    if e.draw then e:draw() end
                end
            end,

            handleUpdate = function(self, dt)
                for _, e in ipairs(self) do
                    if e.update then e:update(dt) end
                end
            end,

            handleKeypressed = function(self, key)
                for _, e in ipairs(self) do
                    if e.handleKeypressed then e:handleKeypressed(key) end
                end
            end,

            handleKeyreleased = function(self, key)
                for _, e in ipairs(self) do
                    if e.handleKeyreleased then e:handleKeyreleased(key) end
                end
            end,

            handleMousepressed = function(self, mx, my)
                for _, e in ipairs(self) do
                    if e.handleMousepressed then e:handleMousepressed(mx, my) end
                end
            end,

            handleMousereleased = function(self, mx, my)
                for _, e in ipairs(self) do
                    if e.handleMousereleased then e:handleMousereleased(mx, my) end
                end
            end,
        }

        for _, e in ipairs(libraryList) do
            table.insert(libClasses, e)
        end

        return libClasses
    end,
}

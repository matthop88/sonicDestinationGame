--------------------------------------------------------------
--                       Plugin Engine                      --
--                        Version 0.1                       --
--                                                          --
--                 Functional Specifications                --
--                         INFR-0008                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Plugin Engine allows plugins to be added to an application.
Plugins may override the standard love2D functions.
Plugins accept a number of parameters to allow them to function.

                           Features
                           --------
- [X] Color Inspector Lib classes converted to Plugins
- [X] Plugin engine accepts name and parameters to create plugins internally
- [X] Plugin engine overrides LOVE2D functions
- [X] Plugin engine automatically creates global accessor functions as needed

--]]

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

local addPlugin = function(self, pluginData)
    local pluginName   = pluginData[1]
    local pluginParams = pluginData[2] or {}

    local plugin = require("plugins/modules/" .. pluginName .. "/" .. pluginName):create(pluginParams)

    if pluginParams.accessorFn then
        _G[pluginParams.accessorFn] = function() return plugin end
    end
    
    table.insert(self, plugin)

    return self
end


--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

local ENGINE = {
    handleDraw          = handleDraw,
    handleUpdate        = handleUpdate,
    handleKeypressed    = handleKeypressed,
    handleKeyreleased   = handleKeyreleased,
    handleMousepressed  = handleMousepressed,
    handleMousereleased = handleMousereleased,

    add                 = addPlugin,

}

--------------------------------------------------------------
--                      LOVE2D Overrides                    --
--------------------------------------------------------------

local oldDraw          = love.draw
local oldUpdate        = love.update
local oldKeypressed    = love.keypressed
local oldKeyreleased   = love.keyreleased
local oldMousepressed  = love.mousepressed
local oldMousereleased = love.mousereleased

function love.draw()                
    ENGINE:handleDraw()

    if oldDraw then oldDraw() end
end

function love.update(dt)                
    ENGINE:handleUpdate(dt)

    if oldUpdate then oldUpdate(dt) end
end

function love.keypressed(key)                
    ENGINE:handleKeypressed(key)

    if oldKeypressed then oldKeypressed(key) end
end

function love.keyreleased(key)                
    ENGINE:handleKeyreleased(key)

    if oldKeyreleased then oldKeyreleased(key) end
end

function love.mousepressed(mx, my)                
    ENGINE:handleMousepressed(mx, my)

    if oldMousepressed then oldMousepressed(mx, my) end
end

function love.mousereleased(mx, my)                
    ENGINE:handleMousereleased(mx, my)

    if oldMousereleased then oldMousereleased(mx, my) end
end

return ENGINE


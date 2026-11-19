--------------------------------------------------------------
--                       Plugin Engine                      --
--                        Version 0.2                       --
--                                                          --
--                 Functional Specifications                --
--                         INFR-0031                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Plugin Engine allows plugins to be added to an application.
Plugins may override the standard love2D functions.
Plugins accept a number of parameters to allow them to function.

The Events of the Plugin Engine (keyboard and mouse events)
need to be iterated through in reverse so that the most recent
plugins handle events first.

In addition, keyboard and mouse methods should return a boolean;
if true, the plugin engine should not propagate the event to
any other plugins.

                            Features
                           --------
- [X] Reverse event order of plugins
- [X] Add blocking capability to plugin events

--]]

--------------------------------------------------------------
--                       Private Methods                    --
--------------------------------------------------------------

local reverse_ipairs = function(t)
    local i = #t + 1
    return function()
        i = i - 1
        if i > 0 then return i, t[i] end
    end
end

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
    local handled = false
    for _, e in reverse_ipairs(self) do
        if e.handleKeypressed then 
            handled = e:handleKeypressed(key) 
            if handled then return true end
        end
    end
end

local handleKeyreleased = function(self, key)
    local handled = false
    for _, e in reverse_ipairs(self) do
        if e.handleKeyreleased then 
            handled = e:handleKeyreleased(key)
            if handled then return true end
        end
    end
end

local handleMousepressed = function(self, mx, my)
    local handled = false
    for _, e in reverse_ipairs(self) do
        if e.handleMousepressed then 
            handled = e:handleMousepressed(mx, my) 
            if handled then return true end
        end
    end
end

local handleMousereleased = function(self, mx, my)
    local handled = false
    for _, e in reverse_ipairs(self) do
        if e.handleMousereleased then 
            handled = e:handleMousereleased(mx, my) 
            if handled then return true end
        end
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
    local handled = ENGINE:handleKeypressed(key)

    if oldKeypressed and not handled then oldKeypressed(key) end
end

function love.keyreleased(key)                
    local handled = ENGINE:handleKeyreleased(key)

    if oldKeyreleased and not handled then oldKeyreleased(key) end
end

function love.mousepressed(mx, my)                
    local handled = ENGINE:handleMousepressed(mx, my)

    if oldMousepressed and not handled then oldMousepressed(mx, my) end
end

function love.mousereleased(mx, my)                
    local handled = ENGINE:handleMousereleased(mx, my)

    if oldMousereleased and not handled then oldMousereleased(mx, my) end
end

return ENGINE


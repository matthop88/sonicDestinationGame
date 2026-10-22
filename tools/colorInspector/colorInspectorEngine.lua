local loadImage = function(path)
    local image
    local status, err = pcall(function() image = requireRelative("lib/imageView"):create { imagePath = path } end)

    if status ~= true then
        image = requireRelative("lib/imageView"):create { imagePath = "tools/colorInspector/resources/fileNotFound.png" }
    end

    return image
end

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local IMAGE_PATH     = "game/resources/images/spriteSheets/sonic1/" .. __PARAMS["imageFile"] .. ".png"
local IMAGE          = loadImage(IMAGE_PATH)
    
local DOUBLE_TAP     = requireRelative("lib/doubleTap")

local ZOOMING        = requireRelative("lib/zooming"):create { imageView = IMAGE }
local READOUT        = requireRelative("lib/readout"):create { fontSize = 48, ySpeed = 600, silent = true }

local SCROLLING      = requireRelative("lib/scrolling"):create { imageView = IMAGE, DOUBLE_TAP = DOUBLE_TAP, ZOOMING = ZOOMING }

local SELECTED_COLOR = requireRelative("lib/colorSelector"):create { imageView = IMAGE }

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

------------------------- INSPECTION -------------------------

local printRGBToConsole = function(r, g, b)
    print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
end

local printRGBToReadout = function(r, g, b)
    local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
    READOUT:print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

local onColorSelected = function(r, g, b)
    printRGBToConsole(r, g, b)
    printRGBToReadout(r, g, b)
end

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    IMAGE:draw()
    READOUT:draw()
    SELECTED_COLOR:draw()
end

local handleUpdate        = function(dt)
    ZOOMING:update(dt)
    SCROLLING:update(dt)
    READOUT:update(dt)
end

local handleKeypressed    = function(key)
    DOUBLE_TAP:handleKeypressed(key)
    SCROLLING:handleKeypressed(key)
    ZOOMING:handleKeypressed(key)
end

local handleKeyreleased   = function(key)
    SCROLLING:handleKeyreleased(key)
    ZOOMING:handleKeyreleased(key)
end

local handleMousepressed  = function(mx, my)
    SELECTED_COLOR:selectColorAt(mx, my, onColorSelected)
end

local handleMousereleased = function(mx, my)
    SELECTED_COLOR:clear()
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()                handleDraw()               end
function love.update(dt)            handleUpdate(dt)           end
function love.keypressed(key)       handleKeypressed(key)      end
function love.keyreleased(key)      handleKeyreleased(key)     end
function love.mousepressed(mx, my)  handleMousepressed(mx, my) end
function love.mousereleased(mx, my) handleMousereleased(mx, my) end



--------------------------------------------------------------
--                      Local Functions                     --
--------------------------------------------------------------

local printRGBToConsole
local printRGBToReadout

local onColorSelected = function(r, g, b)
    printRGBToConsole(r, g, b)
    printRGBToReadout(r, g, b)
end

--------------------------------------------------------------
--                       Library Classes                    --
--------------------------------------------------------------

local IMAGE_PATH     = "game/resources/images/spriteSheets/sonic1/" .. __PARAMS["imageFile"] .. ".png"
local BAD_IMAGE_PATH = "tools/colorInspector/resources/fileNotFound.png"

local IMAGE_VIEW      = requireRelative("lib/imageView"):create { imagePath = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH }
local DOUBLE_TAP      = requireRelative("lib/doubleTap")
local ZOOMING         = requireRelative("lib/zooming"):create { imageView = IMAGE_VIEW }
local READOUT         = requireRelative("lib/readout"):create { fontSize = 48, ySpeed = 600, silent = true }
local SCROLLING       = requireRelative("lib/scrolling"):create { imageView = IMAGE_VIEW, DOUBLE_TAP = DOUBLE_TAP, ZOOMING = ZOOMING }
local SELECTED_COLOR  = requireRelative("lib/colorSelector"):create { imageView = IMAGE_VIEW, onColorSelected = onColorSelected }

local LIBRARY_CLASSES = requireRelative("lib/libraryClasses"):create {
    IMAGE_VIEW,
    DOUBLE_TAP,
    ZOOMING,
    READOUT,
    SCROLLING,
    SELECTED_COLOR,
}

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

------------------------- INSPECTION -------------------------

printRGBToConsole = function(r, g, b)
    print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
end

printRGBToReadout = function(r, g, b)
    local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
    READOUT:print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    LIBRARY_CLASSES:handleDraw()
end

local handleUpdate        = function(dt)
    LIBRARY_CLASSES:handleUpdate(dt)
end

local handleKeypressed    = function(key)
    LIBRARY_CLASSES:handleKeypressed(key)
end

local handleKeyreleased   = function(key)
    LIBRARY_CLASSES:handleKeyreleased(key)
end

local handleMousepressed  = function(mx, my)
    LIBRARY_CLASSES:handleMousepressed(mx, my)
end

local handleMousereleased = function(mx, my)
    LIBRARY_CLASSES:handleMousereleased(mx, my)
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

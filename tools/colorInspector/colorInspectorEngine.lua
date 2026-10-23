--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

------------------------- INSPECTION -------------------------

local printRGBToConsole = function(r, g, b)
    print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
end

local printRGBToReadout = function(r, g, b)
    local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
    getReadout():print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

local onColorSelected = function(r, g, b)
    printRGBToConsole(r, g, b)
    printRGBToReadout(r, g, b)
end

--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

local IMAGE_PATH     = "game/resources/images/spriteSheets/sonic1/" .. __PARAMS["imageFile"] .. ".png"
local BAD_IMAGE_PATH = "tools/colorInspector/resources/fileNotFound.png"

local PLUGINS = require("plugins/engine")
    :add { "imageView",     { imagePath  = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, accessorFn = "getImageView", } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 48, ySpeed = 600, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    :add { "colorSelector", { imageView  = getImageView(), onColorSelected = onColorSelected, } }

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.update(dt)            PLUGINS:handleUpdate(dt)            end
function love.keypressed(key)       PLUGINS:handleKeypressed(key)       end
function love.keyreleased(key)      PLUGINS:handleKeyreleased(key)      end
function love.mousepressed(mx, my)  PLUGINS:handleMousepressed(mx, my)  end
function love.mousereleased(mx, my) PLUGINS:handleMousereleased(mx, my) end

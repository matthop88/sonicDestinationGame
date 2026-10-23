
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

local PLUGINS = require("plugins/engine"):create {
    require("plugins/modules/imageView/imageView"        ):create { imagePath = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, accessorFn = "getImageView", },
    require("plugins/modules/doubleTap/doubleTap"        ):create { accessorFn = "getDoubleTap", },
    require("plugins/modules/zooming/zooming"            ):create { imageView = getImageView(), accessorFn = "getZooming", },
    require("plugins/modules/readout/readout"            ):create { fontSize = 48, ySpeed = 600, silent = true, accessorFn = "getReadout",  },
    require("plugins/modules/scrolling/scrolling"        ):create { imageView = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), },
    require("plugins/modules/colorSelector/colorSelector"):create { imageView = getImageView(), onColorSelected = onColorSelected, },
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
    getReadout():print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()                PLUGINS:handleDraw()                end
function love.update(dt)            PLUGINS:handleUpdate(dt)            end
function love.keypressed(key)       PLUGINS:handleKeypressed(key)       end
function love.keyreleased(key)      PLUGINS:handleKeyreleased(key)      end
function love.mousepressed(mx, my)  PLUGINS:handleMousepressed(mx, my)  end
function love.mousereleased(mx, my) PLUGINS:handleMousereleased(mx, my) end

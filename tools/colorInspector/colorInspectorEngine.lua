
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

local LIBRARY_CLASSES = requireRelative("lib/libraryClasses"):create {
    requireRelative("lib/imageView"    ):create { imagePath = IMAGE_PATH, badImagePath = BAD_IMAGE_PATH, accessorFn = "getImageView", },
    requireRelative("lib/doubleTap"    ):create { accessorFn = "getDoubleTap", },
    requireRelative("lib/zooming"      ):create { imageView = getImageView(), accessorFn = "getZooming", },
    requireRelative("lib/readout"      ):create { fontSize = 48, ySpeed = 600, silent = true, accessorFn = "getReadout",  },
    requireRelative("lib/scrolling"    ):create { imageView = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), },
    requireRelative("lib/colorSelector"):create { imageView = getImageView(), onColorSelected = onColorSelected, },
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

function love.draw()                LIBRARY_CLASSES:handleDraw()                end
function love.update(dt)            LIBRARY_CLASSES:handleUpdate(dt)            end
function love.keypressed(key)       LIBRARY_CLASSES:handleKeypressed(key)       end
function love.keyreleased(key)      LIBRARY_CLASSES:handleKeyreleased(key)      end
function love.mousepressed(mx, my)  LIBRARY_CLASSES:handleMousepressed(mx, my)  end
function love.mousereleased(mx, my) LIBRARY_CLASSES:handleMousereleased(mx, my) end

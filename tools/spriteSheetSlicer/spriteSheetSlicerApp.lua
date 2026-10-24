--------------------------------------------------------------
--                 Functional Specifications                --
--                         TOOL-0006                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
A Sprite Sheet is selected and drawn to the screen.
It can be scrolled and zoomed in the same fashion as the Color Inspector.
Initially, the borders of all sprite frames are automatically detected.
Thereafter, any time the mouse enters a sprite frame and the button is clicked, the attributes of the sprite frame (x, y, width, height) are displayed to the screen.

                           Features
                           --------
- [X] Image can be scrolled using the up, down, left and right arrow keys.
- [X] Double-tapping speeds up image scrolling.
- [X] Image can be zoomed in using the 'z' key and zoomed out using the 'a' key
- [ ] Initially, image is scanned and all subimage boundaries are found.
- [ ] When mouse hovers over a subimage, its border lights up
- [ ] When mouse button is clicked, attributes of the subimage (x, y, width, height) are displayed on the screen.
- [X] Image can be chosen from the command-line.
- [X] List of possible images can be viewed with "-i" underscore.
- [ ] Stand-in image is loaded when image cannot be found.

--]]

--------------------------------------------------------------
--                     Local Variables                      --
--------------------------------------------------------------

local SPRITE_RECTS = {
    { x = 50, y = 50, w = 200, h = 200 },
}

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    local imageView = getImageView()
    local scale     = imageView:getScale()

    love.graphics.setColor { 1, 1, 1 }
    love.graphics.setLineWidth(imageView:getScale())

    for _, spriteRect in ipairs(SPRITE_RECTS) do
        local x1, y1 = imageView:imageToScreenCoordinates(spriteRect.x, spriteRect.y)
    
        love.graphics.rectangle("line", x1, y1, spriteRect.w * scale, spriteRect.h * scale)
    end
end

function love.mousepressed(mx, my)  
    local imageView = getImageView()

    local imageX, imageY = imageView:screenToImageCoordinates(mx, my)

    getReadout():print("Mouse Pressed at " .. math.floor(imageX) .. ", " .. math.floor(imageY))
end

--------------------------------------------------------------
--                          Plugins                         --
--------------------------------------------------------------

local FILE_PATH      = "game/resources/images/spriteSheets/sonic1"
local IMAGE_PATH     = FILE_PATH .. "/" .. __PARAMS["imageFile"] .. ".png"

local PLUGINS = require("plugins/engine")
    :add { "showValidFilenames", { filePath  = FILE_PATH, extension = ".png", 
                                   fileType  = "Image",   
                                   condition = function() return __PARAMS["imageFile"] == "_" end, } }
     --------------------------------------------------------------------------------------------------
    :add { "imageView",     { imagePath  = IMAGE_PATH, accessorFn = "getImageView", } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 48, ySpeed = 600, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    

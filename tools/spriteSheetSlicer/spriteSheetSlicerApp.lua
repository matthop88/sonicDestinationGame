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
- [X] When mouse hovers over a subimage, its border lights up
- [X] When mouse button is clicked, attributes of the subimage (x, y, width, height) are displayed on the screen.
- [X] Image can be chosen from the command-line.
- [X] List of possible images can be viewed with "-i" underscore.
- [ ] Stand-in image is loaded when image cannot be found.

--]]

--------------------------------------------------------------
--                     Local Variables                      --
--------------------------------------------------------------

local SPRITE_RECTS = {
    { x =  50, y =  50, w = 200, h = 200 },
    { x = 300, y =  50, w = 200, h = 200 },
    { x =  50, y = 300, w = 200, h = 200 },
    { x = 300, y = 300, w = 200, h = 200 },
}

--------------------------------------------------------------
--                  Specialized Functions                   --
--------------------------------------------------------------

local drawSpriteRect = function(spriteRect, imageView)
    local x, y = imageView:imageToScreenCoordinates(spriteRect.x, spriteRect.y)

    local scale = imageView:getScale()
    love.graphics.setColor { 1, 1, 1 }
    love.graphics.setLineWidth(scale)

    love.graphics.rectangle("line", x, y, spriteRect.w * scale, spriteRect.h * scale)
end

local drawHighlightedSpriteRect = function(spriteRect, imageView)
    local x, y = imageView:imageToScreenCoordinates(spriteRect.x, spriteRect.y)

    local scale = imageView:getScale()
    love.graphics.setColor { 1, 1, 0 }
    love.graphics.setLineWidth(scale * 3)

    love.graphics.rectangle("line", x, y, spriteRect.w * scale, spriteRect.h * scale)
    if love.mouse.isDown(1) then
        love.graphics.setColor { 1, 1, 1, 0.4 }
        love.graphics.rectangle("fill", x, y, spriteRect.w * scale, spriteRect.h * scale)
    end
end

local ptInSpriteRect = function(px, py, spriteRect)
    return px > spriteRect.x and px < spriteRect.x + spriteRect.w and py > spriteRect.y and py < spriteRect.y + spriteRect.h
end

local drawSpriteRects = function()
    local imageView = getImageView()
    
    local imageX, imageY = imageView:screenToImageCoordinates(love.mouse.getPosition())

    for _, spriteRect in ipairs(SPRITE_RECTS) do
        if ptInSpriteRect(imageX, imageY, spriteRect) then drawHighlightedSpriteRect(spriteRect, imageView)
        else                                               drawSpriteRect(spriteRect, imageView)        end
    end
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.mousepressed(mx, my)  
    local imageView = getImageView()

    local imageX, imageY = imageView:screenToImageCoordinates(mx, my)

    for _, spriteRect in ipairs(SPRITE_RECTS) do
        if ptInSpriteRect(imageX, imageY, spriteRect) then
            getReadout():print("{ x = " .. spriteRect.x .. ", y = " .. spriteRect.y .. ", w = " .. spriteRect.w .. ", h = " .. spriteRect.h .. " }")
        end
    end
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
    :add { "drawingLayer",  { drawingFn  = drawSpriteRects, } }
    :add { "doubleTap",     { accessorFn = "getDoubleTap", } }
    :add { "zooming",       { imageView  = getImageView(), accessorFn = "getZooming", } }
    :add { "readout",       { fontSize   = 48, ySpeed = 600, silent = true, accessorFn = "getReadout", } }
    :add { "scrolling",     { imageView  = getImageView(), DOUBLE_TAP = getDoubleTap(), ZOOMING = getZooming(), } }
    

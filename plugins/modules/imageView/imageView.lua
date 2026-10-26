--------------------------------------------------------------
--                     Image View Plugin                    --
--                         PLUG-0009                        --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
The Image View plugin provides an easy way to display an image on the screen; simply pass in an image path.
In addition, the image view can be used in concert with scrolling and zooming (as well as color selector) plugins.

                          Parameters
                          ----------
The Image View Plugin takes the following parameters:
* imagePath    - a string comprising the full path to the image, including image name and extension
* badImagePath - an optional string comprising the full path to the "bad" image, including image name and extension. This image is loaded if the image at imagePath cannot be found.

--]]

--------------------------------------------------------------
--                       Private Members                    --
--------------------------------------------------------------

local COLOR      = require("game/constants/colors")
local GRAFX      = love.graphics

--------------------------------------------------------------
--                      Private Functions                   --
--------------------------------------------------------------

local loadImage  = function(imagePath, badImagePath)
    local imageData = nil

    local status, err = pcall(function() imageData = love.image.newImageData(imagePath) end)

    if status ~= true then
        local status, err = pcall(function() imageData = love.image.newImageData(badImagePath) end)
    end

    return imageData
end

--------------------------------------------------------------
--                        Public Object                     --
--------------------------------------------------------------

return {
    create = function(self, params)
        local IMAGE_DATA = loadImage(params.imagePath, params.badImagePath)

        if IMAGE_DATA == nil then
            print("\nERROR: Cannot find image: " .. params.imagePath .. "\n")
            love.event.quit()
            return {}
        end
    
        return {
            imageData = IMAGE_DATA,
            image     = GRAFX.newImage(IMAGE_DATA),
            
            x         = 0,
            y         = 0,
            scale     = 1,
            
            --------------------------------------------------------------------------------------
            draw               = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.draw(self.image, self.x * self.scale, self.y * self.scale, 0, self.scale, self.scale)
            end,

            move               = function(self, deltaX, deltaY)
                self.x = self.x + deltaX
                self.y = self.y + deltaY
            end,

            imageToScreenCoordinates = function(self, imageX, imageY)
                local screenX = (imageX + self.x) * self.scale
                local screenY = (imageY + self.y) * self.scale
                
                return screenX, screenY
            end,

            screenToImageCoordinates = function(self, screenX, screenY)
                local imageX = screenX / self.scale - self.x
                local imageY = screenY / self.scale - self.y
                
                return imageX, imageY
            end,

            scaleGeometrically = function(self, scaleDelta, px, py)
                local oldScale = self.scale
                
                self.scale = oldScale + (scaleDelta * oldScale)

                self:move(-px / oldScale,  -py / oldScale)
                self:move( px / self.scale, py / self.scale)
                
            end,

            keepInBounds       = function(self)
                self.x = math.min(0, math.max(self.x, (GRAFX.getWidth()  / self.scale) - self.image:getWidth()))
                self.y = math.min(0, math.max(self.y, (GRAFX.getHeight() / self.scale) - self.image:getHeight()))
            end,

            getPixelAt         = function(self, imageX, imageY)
                return self.imageData:getPixel(imageX, imageY)
            end,

            getWidth           = function(self) return self.image:getWidth()  end,
            getHeight          = function(self) return self.image:getHeight() end,
            getScale           = function(self) return self.scale             end,
            
        }

    end,
    
}

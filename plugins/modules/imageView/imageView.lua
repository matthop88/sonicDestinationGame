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
                -- ???
                
                return screenX, screenY
            end,

            screenToImageCoordinates = function(self, screenX, screenY)
                local x = screenX / self.scale - self.x
                local y = screenY / self.scale - self.y
                
                return x, y
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

            getWidth           = function(self)
                return self.image:getWidth()
            end,

            getHeight          = function(self)
                return self.image:getHeight()
            end,

            getPixelAt         = function(self, imageX, imageY)
                return self.imageData:getPixel(imageX, imageY)
            end,
        }

    end,
    
}

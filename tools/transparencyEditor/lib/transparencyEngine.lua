local selectedColor = nil

local colorMatchesRGB = function(color, r, g, b)
    return color ~= nil and color.r == r and color.g == g and color.b == b
end

local createTransparency = function(x, y, r, g, b, a)
    if colorMatchesRGB(selectedColor, r, g, b) then return 0, 0, 0, 0
    else                                            return r, g, b, a end
end

return {
    handleKeypressed   = function(self, key)
        if key == "space" and selectedColor ~= nil then
            self:makeSelectedColorTransparent()
        else
            -- If color has been made transparent and 
            -- return is pressed, save to disk

            -- If color has been made transparent and
            -- escape key is pressed, revert to previous
        end
    end,

    makeSelectedColorTransparent = function()
        local imageView = getImageView()
        imageView.imageData:mapPixel(createTransparency)
        imageView.image = love.graphics.newImage(imageView.imageData)
        if imageView.pixelated then
            imageView.image:setFilter("nearest", "nearest")
        end
        getReadout():print("Press 'escape' to revert all changes, or 'return' to save.")
    end,
    
    onColorSelected = function(self, r, g, b)
        selectedColor = { r = r, g = g, b = b }
        print("Color selected: r = " .. r .. ", g = " .. g .. ", b = " .. b)
        getReadout():print("Press 'space' to make selected color transparent.")
    end,

}

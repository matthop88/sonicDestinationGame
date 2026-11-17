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
        elseif key == "escape" then
            self:revertTransparencies()
        else
            -- If color has been made transparent and 
            -- return is pressed, save to disk
        end
    end,

    makeSelectedColorTransparent = function()
        local imageView = getImageView()
        imageView:editPixels(createTransparency)
        getReadout():print("Press 'escape' to revert all changes, or 'return' to save.")
    end,

    revertTransparencies = function()
        local imageView = getImageView()
        imageView:reload()
        selectedColor = nil
        getReadout():print("Click on any color in the image to select it.")
    end,
    
    onColorSelected = function(self, r, g, b)
        selectedColor = { r = r, g = g, b = b }
        print("Color selected: r = " .. r .. ", g = " .. g .. ", b = " .. b)
        getReadout():print("Press 'space' to make selected color transparent.")
    end,

}

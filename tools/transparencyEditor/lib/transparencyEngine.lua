local FILE_UTIL = require("lib/util/fileUtil")

local selectedColor = nil

local colorMatchesRGB = function(color, r, g, b)
    return color ~= nil and color.r == r and color.g == g and color.b == b
end

local createTransparency = function(x, y, r, g, b, a)
    if colorMatchesRGB(selectedColor, r, g, b) then return 0, 0, 0, 0
    else                                            return r, g, b, a end
end

return {
    fileChanged = false,

    handleKeypressed   = function(self, key)
        if key == "space" and selectedColor ~= nil then
            self:makeSelectedColorTransparent()
        elseif key == "escape" and self.fileChanged then
            self:revertTransparencies()
        elseif key == "return" and self.fileChanged then
            self:saveImage()
        elseif key == "l" then
            getFileChooserPanel():show()
        end
    end,

    makeSelectedColorTransparent = function(self)
        local imageView = getImageView()
        imageView:editPixels(createTransparency)
        self.fileChanged = true
        getReadout():print("Press 'escape' to revert all changes, or 'return' to save.", 40)
    end,

    revertTransparencies = function(self)
        local imageView = getImageView()
        imageView:reload()
        selectedColor = nil
        self.fileChanged = false
        getReadout():print("Click on any color in the image to select it.", 40)
    end,

    saveImage = function(self)
        local imageView = getImageView()
        local filePath  = "game/resources/images/spriteSheets/sonic1/" .. __PARAMS["inFile"]
        local destFname = FILE_UTIL:getSafeDestinationFilename(filePath .. "Transparent", "png")
        if destFname == nil then
            getReadout():print("ERROR: Cannot save to file " .. filePath, 36)
        else
            local saveResult = FILE_UTIL:saveImageToCustomPath(imageView.imageData, destFname)
            if saveResult then
                getReadout():print("Saved to " .. destFname, 32)
            end
        end
        self.fileChanged = false
        selectedColor = nil
    end,

    onColorSelected = function(self, r, g, b)
        selectedColor = { r = r, g = g, b = b }
        getReadout():print("Press 'space' to make selected color transparent.", 40)
    end,

    onFileSelected = function(self, text)
        print("Selected: " .. text)
        getFileChooserPanel():hide()
    end,
                    
}

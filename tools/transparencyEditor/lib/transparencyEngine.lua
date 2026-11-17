return {
    handleKeypressed   = function(self, key)
        print("Key pressed: " .. key)

        -- If color is selected and space bar is pressed,
        -- make selected color transparent

        -- If color has been made transparent and 
        -- command-S is pressed, save to disk

        -- If color has been made transparent and
        -- escape key is pressed, revert to previous
    end,

    handleMousepressed = function(self, mx, my)
        print("Mouse pressed at: " .. mx .. ", " .. my)
        
        -- Mark color as selected
    end,

    onColorSelected = function(self, r, g, b)
        print("Color selected: r = " .. r .. ", g = " .. g .. ", b = " .. b)
    end,

}

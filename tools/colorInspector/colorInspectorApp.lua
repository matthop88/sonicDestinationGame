--------------------------------------------------------------
--                 Functional Specifications                --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
          An image of choice is drawn to the screen.
          Clicking on any pixel of the image prints
          an RGB description of the color both to
          the screen and to the text console.

                           Features
                           --------
       [-] Image can be scrolled using the up, down,
           left and right arrow keys.
       [ ] Image can be zoomed in using the 'z' key
           and zoomed out using the 'a' key
       [ ] Clicking on any pixel of the image prints
           an RGB description of the color both to
           the screen and to the text console.

--]]

--------------------------------------------------------------
--                      Global Variables                    --
--------------------------------------------------------------

COLOR = require("game/constants/colors")

IMAGE = love.graphics.newImage("game/resources/images/spriteSheets/sonic1/sonic1.png")
        -- https://www.spriters-resource.com/sega_genesis_32x/sonicth1/sheet/21628/
-- ...

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local imageX, imageY = 0, 0

-- ...
-- ...

--------------------------------------------------------------
--               Static code - is executed first            --
--------------------------------------------------------------

-- ...
-- ...
-- ...

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

local scrollUp    = function() imageY = imageY + 100 end
local scrollDown  = function() imageY = imageY - 100 end
local scrollLeft  = function() imageX = imageX + 100 end
local scrollRight = function() imageX = imageX - 100 end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    love.graphics.setColor(COLOR.PURE_WHITE)
    love.graphics.draw(IMAGE, imageX, imageY)
end

function love.keypressed(key)
    if     key == "up"    then scrollUp()
    elseif key == "down"  then scrollDown() 
    elseif key == "left"  then scrollLeft()
    elseif key == "right" then scrollRight()
    end
end

-- ... 

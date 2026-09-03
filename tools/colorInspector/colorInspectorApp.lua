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

SCROLL_SPEED = 500

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local imageX, imageY = 0, 0
local xSpeed, ySpeed = 0, 0
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

local scrollUp           = function() ySpeed =  SCROLL_SPEED end
local scrollDown         = function() ySpeed = -SCROLL_SPEED end
local scrollLeft         = function() xSpeed =  SCROLL_SPEED end
local scrollRight        = function() xSpeed = -SCROLL_SPEED end

local stopScrollingUp    = function() 
    if ySpeed > 0 then ySpeed = 0 end
end

local stopScrollingDown  = function() 
    if ySpeed < 0 then ySpeed = 0 end
end

local stopScrollingLeft  = function() 
    if xSpeed > 0 then xSpeed = 0 end
end

local stopScrollingRight = function() 
    if xSpeed < 0 then xSpeed = 0 end
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    love.graphics.setColor(COLOR.PURE_WHITE)
    love.graphics.draw(IMAGE, imageX, imageY)
end

function love.update(dt)
    imageX = imageX + (xSpeed * dt)
    imageY = imageY + (ySpeed * dt)
end

function love.keypressed(key)
    if     key == "up"    then scrollUp()
    elseif key == "down"  then scrollDown() 
    elseif key == "left"  then scrollLeft()
    elseif key == "right" then scrollRight()
    end
end

function love.keyreleased(key)
    if     key == "up"    then stopScrollingUp()
    elseif key == "down"  then stopScrollingDown()
    elseif key == "left"  then stopScrollingLeft()
    elseif key == "right" then stopScrollingRight()
    end
end

-- ... 

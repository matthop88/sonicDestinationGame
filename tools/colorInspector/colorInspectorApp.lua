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

WINDOW       = require("tools/colorInspector/config/window")
COLOR        = require("game/constants/colors")

IMAGE        = love.graphics.newImage("game/resources/images/spriteSheets/sonic1/sonic1.png")
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

local updateImage        = function(dt)
    imageX = imageX + (xSpeed * dt)
    imageY = imageY + (ySpeed * dt)
end

local keepImageInBounds  = function()
    imageX = math.min(0, math.max(imageX, WINDOW.width  - IMAGE:getWidth()))
    imageY = math.min(0, math.max(imageY, WINDOW.height - IMAGE:getHeight()))
end

local scrollUp           = function() ySpeed =  SCROLL_SPEED       end
local scrollDown         = function() ySpeed = -SCROLL_SPEED       end
local scrollLeft         = function() xSpeed =  SCROLL_SPEED       end
local scrollRight        = function() xSpeed = -SCROLL_SPEED       end

local stopScrollingUp    = function() ySpeed = math.min(0, ySpeed) end
local stopScrollingDown  = function() ySpeed = math.max(0, ySpeed) end
local stopScrollingLeft  = function() xSpeed = math.min(0, xSpeed) end
local stopScrollingRight = function() xSpeed = math.max(0, xSpeed) end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    love.graphics.setColor(COLOR.PURE_WHITE)
    love.graphics.draw(IMAGE, imageX, imageY)
end

function love.update(dt)
    updateImage(dt)
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
    keepImageInBounds()
end

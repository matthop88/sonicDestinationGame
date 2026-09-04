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
       [X] Image can be scrolled using the up, down,
           left and right arrow keys.
       [-] Image can be zoomed in using the 'z' key
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

IMAGE = {
    image    = love.graphics.newImage("game/resources/images/spriteSheets/sonic1/sonic1.png"),
               -- https://www.spriters-resource.com/sega_genesis_32x/sonicth1/sheet/21628/
    x        = 0,
    y        = 0,

    scale    = 5,

    draw     = function(self)
        love.graphics.setColor(COLOR.PURE_WHITE)
        love.graphics.draw(self.image, self.x * self.scale, self.y * self.scale, 0, self.scale, self.scale)
    end,

}

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local imageX, imageY     = 0, 0
local xSpeed, ySpeed     = 0, 0

local scale              = 5

local DOUBLE_TAP   = require("tools/colorInspector/lib/doubleTap")

local SCROLL_SPEED = {
    VALUE      = 500,
    isDashing  = false,

    get        = function(self)
        if self.isDashing then 
            return self.VALUE * 2
        else                   
            return self.VALUE   
        end
    end,

    setDashing = function(self, dashing)
        self.isDashing = dashing
    end,

}

--------------------------------------------------------------
--               Static code - is executed first            --
--------------------------------------------------------------

-- ...
-- ...
-- ...

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

---------------------------- IMAGE ---------------------------

local updateImage         = function(dt)
    IMAGE.x = IMAGE.x + (xSpeed * dt)
    IMAGE.y = IMAGE.y + (ySpeed * dt)    
end

local keepImageInBounds   = function()
    IMAGE.x = math.min(0, math.max(IMAGE.x, (WINDOW.width  / IMAGE.scale) - IMAGE.image:getWidth()))
    IMAGE.y = math.min(0, math.max(IMAGE.y, (WINDOW.height / IMAGE.scale) - IMAGE.image:getHeight()))
end

----------------------- DOUBLE TAPPING -----------------------

local handleDoubleTapping = function(key)
    if   DOUBLE_TAP:qualify(key) then SCROLL_SPEED:setDashing(true)
    else                              SCROLL_SPEED:setDashing(false)    
    end
end

-------------------------- SCROLLING -------------------------

local scrollUp            = function() ySpeed =  SCROLL_SPEED:get() end
local scrollDown          = function() ySpeed = -SCROLL_SPEED:get() end
local scrollLeft          = function() xSpeed =  SCROLL_SPEED:get() end
local scrollRight         = function() xSpeed = -SCROLL_SPEED:get() end

local stopScrollingUp     = function() ySpeed = math.min(0, ySpeed) end
local stopScrollingDown   = function() ySpeed = math.max(0, ySpeed) end
local stopScrollingLeft   = function() xSpeed = math.min(0, xSpeed) end
local stopScrollingRight  = function() xSpeed = math.max(0, xSpeed) end

local handleScrolling     = function(key)
    if     key == "up"    then scrollUp()
    elseif key == "down"  then scrollDown() 
    elseif key == "left"  then scrollLeft()
    elseif key == "right" then scrollRight()
    end
end

local handleStopScrolling = function(key)
    if     key == "up"    then stopScrollingUp()
    elseif key == "down"  then stopScrollingDown()
    elseif key == "left"  then stopScrollingLeft()
    elseif key == "right" then stopScrollingRight()
    end
end

--------------------------- ZOOMING --------------------------

local zoomIn              = function()                     end
local zoomOut             = function()                     end

local stopZoomingIn       = function()                     end
local stopZoomingOut      = function()                     end

local handleZooming       = function(key)
    if     key == "z"     then zoomIn()
    elseif key == "a"     then zoomOut()
    end
end

local handleStopZooming   = function(key)
    if     key == "z" then stopZoomingIn()
    elseif key == "a" then stopZoomingOut()
    end 
end

----------------------- EVENT HANDLING -----------------------

local handleUpdate        = function(dt)
    updateImage(dt)
    if xSpeed == 0 and ySpeed == 0 and not DOUBLE_TAP:withinThreshold() then
        keepImageInBounds()
    end
end

local handleKeypressed    = function(key)
    handleDoubleTapping(key)
    handleScrolling(key)
    handleZooming(key)
end

local handleKeyreleased   = function(key)
    handleStopScrolling(key)
    handleStopZooming(key)
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()
    IMAGE:draw()
end

function love.update(dt)
    handleUpdate(dt)
end

function love.keypressed(key)
    handleKeypressed(key)
end

function love.keyreleased(key)
    handleKeyreleased(key)
end



--[[

          *************     ******************    ******************           *****           
      *****************   ********************  ********************         **********      
     ******              ******                *****                        ************            
    ****   ************  ***** *************** **** ****************       *****   ******           
   ****  **************  ***** *************** **** ****************      *****  ** *****           
   **** ****             ***** ***             **** ****                  ***** ***  *****          
    ***  **********      ***** *************   **** **** ***********     ***** ***** ******         
     ****    ********    ***** *************   **** **** ***********    ****** ****** *****         
      *******     ****   ***** *************   **** **** ****** ****    ***** ******* ******        
        **********  ***  ***** *************   **** **** ****** ****   *****  *** **** *****        
               **** **** ***** ***             **** ****   **** ****  ****** ****  **** *****       
    **************  ***  ***** *************** **** *********** ****  ***** *********** ******      
    ************   ****  ***** *************** **** *********** **** ****** ************ *****      
                ******   ******                *****            **** ***** ***            *****     
    ****************      ********************  ************************* ***  *****************    
    *************           ******************    *********************** ***  *****************   

--]]

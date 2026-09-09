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
       [X] Image can be zoomed in using the 'z' key
           and zoomed out using the 'a' key
       [ ] Clicking on any pixel of the image prints
           an RGB description of the color both to
           the screen and to the text console.

--]]

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local IMAGE_PATH     = "game/resources/images/spriteSheets/sonic1/" .. __PARAMS["imageFile"] .. ".png"
local IMAGE          = require("tools/colorInspector/lib/imageView"):create { imagePath = IMAGE_PATH }

local DOUBLE_TAP     = require("tools/colorInspector/lib/doubleTap")

local ZOOMING        = require("tools/colorInspector/lib/zooming"):create   { imageView = IMAGE }
local READOUT        = require("tools/colorInspector/lib/readout"):create   { fontSize = 48, ySpeed = 600 }

local SCROLLING      = require("tools/colorInspector/lib/scrolling"):create { imageView = IMAGE, DOUBLE_TAP = DOUBLE_TAP, ZOOMING = ZOOMING }

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

----------------------- DOUBLE TAPPING -----------------------

local handleDoubleTapping = function(key)
    if   DOUBLE_TAP:qualify(key) then SCROLLING:setDashing(true)
    else                              SCROLLING:setDashing(false)    
    end
end

-------------------------- SCROLLING -------------------------

local handleScrolling     = function(key)
    if     key == "up"    then SCROLLING:scrollUp()
    elseif key == "down"  then SCROLLING:scrollDown() 
    elseif key == "left"  then SCROLLING:scrollLeft()
    elseif key == "right" then SCROLLING:scrollRight()
    end
end

local handleStopScrolling = function(key)
    if     key == "up"    then SCROLLING:stopScrollingUp()
    elseif key == "down"  then SCROLLING:stopScrollingDown()
    elseif key == "left"  then SCROLLING:stopScrollingLeft()
    elseif key == "right" then SCROLLING:stopScrollingRight()
    end
end

--------------------------- ZOOMING --------------------------

local handleZooming       = function(key)
    if     key == "z" then ZOOMING:zoomIn()
    elseif key == "a" then ZOOMING:zoomOut()
    end
end

local handleStopZooming   = function(key)
    if     key == "z" then ZOOMING:stopZoomingIn()
    elseif key == "a" then ZOOMING:stopZoomingOut()
    end 
end

------------------------- INSPECTION -------------------------

local identifyColorAt  = function(mx, my)
    local x, y = IMAGE:screenToImageCoordinates(mx, my)

    x = math.max(0, math.min(IMAGE:getWidth()  - 1, x))
    y = math.max(0, math.min(IMAGE:getHeight() - 1, y))

    local r, g, b = love.math.colorToBytes(IMAGE:getPixelAt(math.floor(x), math.floor(y)))
    READOUT:print("R = " .. r .. ", G = " .. g .. ", B = " .. b)
end

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    IMAGE:draw()
    READOUT:draw()
end

local handleUpdate        = function(dt)
    ZOOMING:update(dt)
    SCROLLING:update(dt)
    READOUT:update(dt)
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

local handleMousepressed  = function(mx, my)
    identifyColorAt(mx, my)
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()               handleDraw()               end
function love.update(dt)           handleUpdate(dt)           end
function love.keypressed(key)      handleKeypressed(key)      end
function love.keyreleased(key)     handleKeyreleased(key)     end
function love.mousepressed(mx, my) handleMousepressed(mx, my) end


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

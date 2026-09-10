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
       [-] Clicking on any pixel of the image prints
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
local READOUT        = require("tools/colorInspector/lib/readout"):create   { fontSize = 48, ySpeed = 600, silent = true }

local SCROLLING      = require("tools/colorInspector/lib/scrolling"):create { imageView = IMAGE, DOUBLE_TAP = DOUBLE_TAP, ZOOMING = ZOOMING }

local SELECTED_COLOR = require("tools/colorInspector/lib/colorSelector")

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

local printRGBToConsole = function(r, g, b)
    print(string.format("{ %.2f, %.2f, %.2f }", r, g, b))
end

local printRGBToReadout = function(r, g, b)
    local rByte, gByte, bByte = love.math.colorToBytes(r, g, b)
    READOUT:print("R = " .. rByte .. ", G = " .. gByte .. ", B = " .. bByte)
end

local selectColorAt = function(mx, my)
    local r, g, b = SELECTED_COLOR:identifyColorFromImageAt(IMAGE, mx, my)

    SELECTED_COLOR:set(r, g, b)

    printRGBToConsole(r, g, b)
    printRGBToReadout(r, g, b)
end

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    IMAGE:draw()
    READOUT:draw()
    SELECTED_COLOR:draw()
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
    selectColorAt(mx, my)
end

local handleMousereleased = function(mx, my)
    SELECTED_COLOR:clear()
end

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()                handleDraw()               end
function love.update(dt)            handleUpdate(dt)           end
function love.keypressed(key)       handleKeypressed(key)      end
function love.keyreleased(key)      handleKeyreleased(key)     end
function love.mousepressed(mx, my)  handleMousepressed(mx, my) end
function love.mousereleased(mx, my) handleMousereleased(mx, my) end


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

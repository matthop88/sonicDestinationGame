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

local IMAGE          = require("tools/colorInspector/lib/imageView")
local DOUBLE_TAP     = require("tools/colorInspector/lib/doubleTap")

local xSpeed, ySpeed = 0, 0

local SCROLL_SPEED   = {
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

local ZOOM_FACTORY = {
    create = function(self, params)
        return {
            zoomSpeed = params.zoomSpeed or 2,
            imageView = params.imageView,
    
            scaleDelta = 0,

            zoomIn  = function(self) 
                self.scaleDelta = self.zoomSpeed              
            end,

            zoomOut = function(self) 
                self.scaleDelta = -self.zoomSpeed
            end,

            stopZoomingIn = function(self) 
                self.scaleDelta = math.min(0, self.scaleDelta) 
            end,

            stopZoomingOut = function(self) 
                self.scaleDelta = math.max(0, self.scaleDelta) 
            end,

            update = function(self, dt)
                local mx, my = love.mouse.getPosition()

                self.imageView:scaleGeometrically(self.scaleDelta * dt, mx, my)
            end,
        }
    end,
}

local ZOOMING = ZOOM_FACTORY:create { imageView = IMAGE }

local READOUT        = require("tools/colorInspector/lib/readout"):create { fontSize = 48, ySpeed = 600 }

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

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

local updateScrolling     = function(dt)
    IMAGE:move(xSpeed * dt, ySpeed * dt)
    if xSpeed == 0 and ySpeed == 0 and not DOUBLE_TAP:withinThreshold() and ZOOMING.scaleDelta <= 0 then
        IMAGE:keepInBounds()
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

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    IMAGE:draw()
    READOUT:draw()
end

local handleUpdate        = function(dt)
    ZOOMING:update(dt)
    updateScrolling(dt)
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
    local x, y = IMAGE:screenToImageCoordinates(mx, my)

    READOUT:print("Mouse Pressed at (" .. math.floor(x) .. ", " .. math.floor(y) .. ")")
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

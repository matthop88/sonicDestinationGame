--------------------------------------------------------------
--                 Functional Specifications                --
--------------------------------------------------------------

--[[
                       Short Description
                       -----------------
    Can make simple, single-color drawings or "scribblings",
    with undo/redo functionality and saving and loading from disk.
    Stretch goal: straight line, rectangle and text support

                           Features
                           --------
        [ ] Mouse-down draws lines between mouse position 
            and previous mouse position
        [ ] Mouse-up allows movement without drawing
        [ ] Command Z undoes one action at a time
        [ ] Shift Command Z redoes one action at a time
        [ ] 'G' shows a grid
        [ ] Shift allows snapping to grid
        [ ] File name entered as command-line parameter
            loads from file
        [ ] Command-S saves to disk in custom object format
        [ ] Command-Option-S saves to disk via image capture
        
                         Stretch Goals
                         -------------
        [ ] 'L' draws a line from pt 1 to pt 2; 
                can be used to create polygons
        [ ] 'R' draws a rect with upper-left corner at pt 1, 
            lower left at pt 2
        [ ] 'T' allows typing of text at mouse position.
            Left-justified
        [ ] 'C' allows cycling through various colors

--]]

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

-- ...
-- ...
-- ...

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

----------------------- EVENT HANDLING -----------------------

local handleDraw          = function()
    -- do something awesome
end

local handleUpdate        = function(dt)
    -- do something else awesome
end

local handleKeypressed    = function(key)
    -- more awesomeness
end

local handleKeyreleased   = function(key)
    -- even more awesomeness
end

local handleMousepressed  = function(mx, my)
    -- is there no end to the awesomeness?
end

local handleMousereleased = function(mx, my)
    -- ANSWER: NO.
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


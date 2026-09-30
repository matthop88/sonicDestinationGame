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
        [X] Mouse-down draws lines between mouse position 
            and previous mouse position
        [X] Mouse-up allows movement without drawing
        [X] 'L' draws a line from pt 1 to pt 2; 
                can be used to create polygons
        [X] 'T' allows typing of text at mouse position.
            Left-justified
        [X] Command Z undoes one action at a time
        [X] Shift Command Z redoes one action at a time
        [X] File name entered as command-line parameter
            loads from file
        [X] Command-S saves to disk in custom object format
        [ ] Command-Option-S saves to disk via image capture
        
                         Stretch Goals
                         -------------
        [ ] 'R' draws a rect with upper-left corner at pt 1, 
            lower left at pt 2
        [ ] 'C' allows cycling through various colors
        [ ] 'G' shows a grid
        [ ] Shift allows snapping to grid

--]]

--------------------------------------------------------------
--                       Local Variables                    --
--------------------------------------------------------------

local SCRIBBLER = requireRelative("lib/scribbler")

-- ...
-- ...

--------------------------------------------------------------
--                   Specialized Functions                  --
--------------------------------------------------------------

-- ...
-- ...
-- ...

--------------------------------------------------------------
--                     LOVE2D Functions                     --
--------------------------------------------------------------

function love.draw()                SCRIBBLER:handleDraw()                end
function love.update(dt)            SCRIBBLER:handleUpdate(dt)            end
function love.keypressed(key)       SCRIBBLER:handleKeypressed(key)       end
function love.keyreleased(key)      SCRIBBLER:handleKeyreleased(key)      end
function love.mousepressed(mx, my)  SCRIBBLER:handleMousepressed(mx, my)  end
function love.mousereleased(mx, my) SCRIBBLER:handleMousereleased(mx, my) end


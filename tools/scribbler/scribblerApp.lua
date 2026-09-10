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

local ENGINE = {
    draw          = function(self)
        -- ...
    end,

    update        = function(self, dt)
        -- ...
    end,

    keypressed    = function(self, key)
        -- ...
    end,

    keyreleased   = function(self, key)
        -- ...
    end,

    mousepressed  = function(self, mx, my)
        -- ...
    end,

    mousereleased = function(self, mx, my)
        -- ...
    end,

    mousemoved    = function(self, mx, my)
        print("Pen moved   to (" .. mx .. ", " .. my .. ")")
    end,

    mousedragged  = function(self, mx, my)
        print("Pen dragged to (" .. mx .. ", " .. my .. ")")
    end,

}

local SCRIBBLER = ({
    init = function(self)
        self.MOUSE = love.mouse

        self.prevX, self.prevY = self.MOUSE.getPosition()

        return self
    end,

    handleDraw          = function(self)
        ENGINE:draw()
    end,

    handleUpdate        = function(self, dt)
        ENGINE:update(dt)

        local x, y = self.MOUSE.getPosition()

        if self.prevX ~= x or self.prevY ~= y then
            if self.MOUSE.isDown(1) then
                ENGINE:mousedragged(x, y)
            else
                ENGINE:mousemoved(x, y)
            end

            self.prevX, self.prevY = x, y
        end
    end,

    handleKeypressed    = function(self, key)
        ENGINE:keypressed(key)
    end,

    handleKeyreleased   = function(self, key)
        ENGINE:keyreleased(key)
    end,

    handleMousepressed  = function(self, mx, my)
        ENGINE:mousepressed(mx, my)
    end,

    handleMousereleased = function(self, mx, my)
        ENGINE:mousereleased(mx, my)
    end,

}):init()

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


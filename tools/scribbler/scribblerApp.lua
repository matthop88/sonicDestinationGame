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

local SCRIBBLER = {
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

local CONTROLLER = ({
    init = function(self)
        self.MOUSE = love.mouse

        self.prevX, self.prevY = self.MOUSE.getPosition()

        return self
    end,

    handleDraw          = function(self)
        SCRIBBLER:draw()
    end,

    handleUpdate        = function(self, dt)
        SCRIBBLER:update(dt)

        local x, y = self.MOUSE.getPosition()

        if self.prevX ~= x or self.prevY ~= y then
            if self.MOUSE.isDown(1) then
                SCRIBBLER:mousedragged(x, y)
            else
                SCRIBBLER:mousemoved(x, y)
            end

            self.prevX, self.prevY = x, y
        end
    end,

    handleKeypressed    = function(self, key)
        SCRIBBLER:keypressed(key)
    end,

    handleKeyreleased   = function(self, key)
        SCRIBBLER:keyreleased(key)
    end,

    handleMousepressed  = function(self, mx, my)
        SCRIBBLER:mousepressed(mx, my)
    end,

    handleMousereleased = function(self, mx, my)
        SCRIBBLER:mousereleased(mx, my)
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

function love.draw()                CONTROLLER:handleDraw()                end
function love.update(dt)            CONTROLLER:handleUpdate(dt)            end
function love.keypressed(key)       CONTROLLER:handleKeypressed(key)       end
function love.keyreleased(key)      CONTROLLER:handleKeyreleased(key)      end
function love.mousepressed(mx, my)  CONTROLLER:handleMousepressed(mx, my)  end
function love.mousereleased(mx, my) CONTROLLER:handleMousereleased(mx, my) end


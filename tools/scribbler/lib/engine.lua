local CURRENT_JOT = requireRelative("lib/jots/scribble")

return {
    history = { },

    draw          = function(self)
        CURRENT_JOT:draw()
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
        CURRENT_JOT:penDown(mx, my)
    end,

    mousereleased = function(self, mx, my)
        CURRENT_JOT:penUp(mx, my)
    end,

    mousemoved    = function(self, mx, my)
        CURRENT_JOT:penMoved(mx, my)
    end,

    mousedragged  = function(self, mx, my)
        CURRENT_JOT:penDragged(mx, my)
    end,

}

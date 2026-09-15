local SCRIBBLE_JOT = requireRelative("lib/jots/scribble")

return {
    history = { },

    draw          = function(self)
        self:drawHistory()
        self:drawCursor()
    end,

    drawHistory   = function(self)
        SCRIBBLE_JOT:drawHistory()
    end,

    drawCursor    = function(self)
        SCRIBBLE_JOT:drawCursor()
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
        SCRIBBLE_JOT:penDown(mx, my)
    end,

    mousereleased = function(self, mx, my)
        SCRIBBLE_JOT:penUp(mx, my)
    end,

    mousemoved    = function(self, mx, my)
        SCRIBBLE_JOT:penMoved(mx, my)
    end,

    mousedragged  = function(self, mx, my)
        SCRIBBLE_JOT:penDragged(mx, my)
    end,

}

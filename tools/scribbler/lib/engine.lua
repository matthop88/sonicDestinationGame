local CURRENT_JOT = requireRelative("lib/jots/line")

return {
    history = { },

    draw          = function(self)
        self:drawHistory()
        self:drawCursor()
    end,

    drawHistory   = function(self)
        CURRENT_JOT:drawHistory()
    end,

    drawCursor    = function(self)
        CURRENT_JOT:drawCursor()
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

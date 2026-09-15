local LINE_JOT = requireRelative("lib/jots/line")

return {
    history = { },

    draw          = function(self)
        self:drawHistory()
        self:drawCursor()
    end,

    drawHistory   = function(self)
        LINE_JOT:drawHistory()
    end,

    drawCursor    = function(self)
        LINE_JOT:drawCursor()
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
        LINE_JOT:mousepressed(mx, my)
    end,

    mousereleased = function(self, mx, my)
        LINE_JOT:mousereleased(mx, my)
    end,

    mousemoved    = function(self, mx, my)
        LINE_JOT:mousemoved(mx, my)
    end,

    mousedragged  = function(self, mx, my)
        LINE_JOT:mousedragged(mx, my)
    end,

}

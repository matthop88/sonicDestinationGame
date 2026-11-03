local GRAFX = love.graphics
local COLOR = requireRelative("constants/colors")

return {
    draw = function(self)
        self:drawBackground()
        self:drawHorizontalLine()
        --self:drawVerticalLines()
    end,

    drawBackground = function(self)
        GRAFX.clear(COLOR.GREEN)
    end,

    drawHorizontalLine = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setLineWidth(3)
        GRAFX.line(0, GRAFX.getHeight() * 3 / 4, GRAFX.getWidth(), GRAFX.getHeight() * 3 / 4)
    end,

    drawVerticalLines  = function(self)
        GRAFX.setColor(COLOR.PURE_WHITE)
        GRAFX.setLineWidth(1)
        GRAFX.line(GRAFX.getWidth() / 2,      0, GRAFX.getWidth() / 2,      GRAFX.getHeight())
        GRAFX.line(GRAFX.getWidth() / 2 - 48, 0, GRAFX.getWidth() / 2 - 48, GRAFX.getHeight())
        GRAFX.line(GRAFX.getWidth() / 2 + 48, 0, GRAFX.getWidth() / 2 + 48, GRAFX.getHeight())
    end,

}

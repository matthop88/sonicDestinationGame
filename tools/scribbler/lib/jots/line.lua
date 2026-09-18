local LINE_JOT = {
    create = function(self)
        return {
            data = { points = {} },

            draw = function(self)
                GRAFX.setColor(COLOR.PURE_WHITE)
                GRAFX.setLineWidth(1)
                
                local points = self.data.points

                if #points > 0 then
                    if   #points > 2 then GRAFX.line(points)
                    else GRAFX.line(points[1], points[2], points[1], points[2]) end
                end
            end,

            addPoint = function(self, x, y)
                table.insert(self.data.points, x)
                table.insert(self.data.points, y)
            end,

            isEmpty = function(self)
                return #self.data.points == 0
            end,

            getLastPoint = function(self)
                local points = self.data.points

                return { x = points[#points - 1], y = points[#points] }
            end,

        }

    end,

}

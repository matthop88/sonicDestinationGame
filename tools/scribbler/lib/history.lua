return { 
    TAIL_INDEX = 0,
    data       = {},

    draw = function(self)
        for n, jot in ipairs(self.data) do
            if n <= self.TAIL_INDEX then 
                jot:draw()
            end
        end
    end,

    addJot = function(self, jot)
        self.TAIL_INDEX = self.TAIL_INDEX + 1
        self.data[self.TAIL_INDEX] = jot
    end,

    undo   = function(self)
        self.TAIL_INDEX = math.max(0, self.TAIL_INDEX - 1)
    end,

    redo   = function(self)
        self.TAIL_INDEX = math.min(#self.data, self.TAIL_INDEX + 1)
    end,

    clear  = function(self)
        self.TAIL_INDEX = 0
        self.data = {}
    end,

    eachJot = function(self)
        local index = 0
        local size  = self.TAIL_INDEX
        local data  = self.data

        return function()
            index = index + 1
            if index <= size then return data[index]
            else                  return nil         end               
        end
    end,

}

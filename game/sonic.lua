return {
    x = 512,
    y = 516,
    
    sprite = requireRelative("sprite"),

    draw = function(self)
        self.sprite:draw(self:getX(), self:getY())
    end,

    moveTo    = function(self, x, y) self.x, self.y = x, y end,

    getX      = function(self)       return self.x         end,
    getY      = function(self)       return self.y         end,
    
}

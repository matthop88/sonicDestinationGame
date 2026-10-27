local ptInRect = function(self, px, py)
	return px > self.x and px < self.x + self.w and py > self.y and py < self.y + self.h
end

local updateRect = function(self, mx, my)
	self.isHighlighted = self:contains(mx, my)
end

return {
	create = function(self, x, y, w, h)
		return {
			x = x,
			y = y,
			w = w,
			h = h,

			isHighlighted = false,

			contains = ptInRect,
			update   = updateRect,
		}
		
	end,

}

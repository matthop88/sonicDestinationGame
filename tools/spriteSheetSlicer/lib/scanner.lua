local rgbsMatch = function(r1, g1, b1, r2, g2, b2)
	return math.abs(r2 - r1) < 0.01 and math.abs(b2 - b1) < 0.01 and math.abs(g2 - g1) < 0.01
end

local rgbsMatchWithColor = function(color, r, g, b)
	return rgbsMatch(r, g, b, color.r, color.g, color.b)
end

return {
	create = function(self, params)
		return ({
			imageView = params.imageView,
			bgColor   = params.bgColor,
			spColor   = params.spColor,

			init      = function(self)
				self.imageWidth  = self.imageView:getWidth()
				self.imageHeight = self.imageView:getHeight()

				return self
			end,

			scan = function(self, callback)
				for y = 1, self.imageHeight - 1 do
					for x = 1, self.imageWidth - 1 do
						if self:isSPColorPixel(x, y) and self:isToRightOfAndBelowBGColorPixel(x, y) then
							callback(x, y)
						end
					end
				end
			end,

			isSPColorPixel = function(self, x, y)
				local r, g, b = self.imageView:getPixelAt(x, y)
				return rgbsMatchWithColor(self.spColor, r, g, b)
			end,

			isToRightOfAndBelowBGColorPixel = function(self, x, y)
				return self:isToRightOfBGColorPixel(x, y) and self:isBelowBGColorPixel(x, y)
			end,

			isToRightOfBGColorPixel = function(self, x, y)
				local rL, gL, bL = self.imageView:getPixelAt(x - 1, y)
				return rgbsMatchWithColor(self.bgColor, rL, gL, bL)
			end,

			isBelowBGColorPixel = function(self, x, y)
				local rU, gU, bU = self.imageView:getPixelAt(x, y - 1)
				return rgbsMatchWithColor(self.bgColor, rU, gU, bU)
			end,			

    	}):init()
    end,
}

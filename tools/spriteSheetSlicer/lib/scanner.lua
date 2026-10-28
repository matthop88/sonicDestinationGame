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

			scanRectUpperLefts = function(self, upperLeftCallback)
				for y = 1, self.imageHeight - 1 do
					for x = 1, self.imageWidth - 1 do
						if self:isSPColorPixel(x, y) and self:isToRightOfAndBelowBGColorPixel(x, y) then
							upperLeftCallback(x, y)
						end
					end
				end
			end,

			determineRectWidth = function(self, rectX, rectY)
				for x = rectX, self.imageWidth - 2 do
					if self:isToLeftOfBGColorPixel(x, rectY) then
						return x - rectX + 1
					end
				end
			end,

			determineRectHeight = function(self, rectX, rectY)
				for y = rectY, self.imageHeight - 2 do
					if self:isAboveBGColorPixel(rectX, y) then
						return y - rectY + 1
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

			isToLeftOfBGColorPixel = function(self, x, y)
				local rR, gR, bR = self.imageView:getPixelAt(x + 1, y)
				return rgbsMatchWithColor(self.bgColor, rR, gR, bR)
			end,

			isAboveBGColorPixel = function(self, x, y)
				local rD, gD, bD = self.imageView:getPixelAt(x, y + 1)
				return rgbsMatchWithColor(self.bgColor, rD, gD, bD)
			end,	

    	}):init()
    end,
}

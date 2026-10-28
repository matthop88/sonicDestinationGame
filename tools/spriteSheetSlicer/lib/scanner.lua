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

			scan = function(self, spriteRects)
				self:scanRectUpperLefts(function(x, y) spriteRects:add(x, y, 50, 50) end)

				for _, spriteRect in ipairs(spriteRects) do
					spriteRect.w = self:determineRectWidth(spriteRect.x, spriteRect.y)
					spriteRect.h = self:determineRectHeight(spriteRect.x, spriteRect.y)
				end
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
					if self:isToLeftOfBGColorPixel(x, rectY) then return x - rectX + 1 end
				end
			end,

			determineRectHeight = function(self, rectX, rectY)
				for y = rectY, self.imageHeight - 2 do
					if self:isAboveBGColorPixel(rectX, y) then    return y - rectY + 1 end
				end
			end,
 
 			isBGColorPixel          = function(self, x, y) return self:pixelMatches(x, y,     self.bgColor) end,
			isSPColorPixel          = function(self, x, y) return self:pixelMatches(x, y,     self.spColor) end,

			isToRightOfBGColorPixel = function(self, x, y) return self:pixelMatches(x - 1, y, self.bgColor) end,
			isBelowBGColorPixel     = function(self, x, y) return self:pixelMatches(x, y - 1, self.bgColor) end,	
			isToLeftOfBGColorPixel  = function(self, x, y) return self:pixelMatches(x + 1, y, self.bgColor) end,
			isAboveBGColorPixel     = function(self, x, y) return self:pixelMatches(x, y + 1, self.bgColor) end,	

			isToRightOfAndBelowBGColorPixel = function(self, x, y)
				return self:isToRightOfBGColorPixel(x, y) and self:isBelowBGColorPixel(x, y)
			end,

			pixelMatches = function(self, x, y, color)
 				return rgbsMatchWithColor(color, self.imageView:getPixelAt(x, y))
			end,

    	}):init()
    end,
}

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

			drawScanLine = function(self)
				if self.scanLineY then
					local x, y  = self.imageView:imageToScreenCoordinates(0, self.scanLineY)
					local scale = self.imageView:getScale()

					love.graphics.setColor(1, 1, 1)
					love.graphics.setLineWidth(scale)
					
					love.graphics.line(x, y, self.imageWidth * scale, y)
				end
			end,

			scan = function(self, spriteRects)
				local spriteLineScanned = function(x, y, w)
					spriteRects:addLine(x, y, w)
				end

				for y = 1, self.imageHeight - 1 do
					self.scanLineY = y
					self:scanLine(y, spriteLineScanned)
					coroutine.yield()
				end

				self.scanLineY = nil
			end,

			scanLine = function(self, y, spriteLineScannedCallback)
				local leftX = nil
				for x = 0, self.imageWidth - 1 do
					if     self:isSPColorPixel(x, y) and not leftX then
						leftX = x
					elseif self:isBGColorPixel(x, y) and     leftX then
						spriteLineScannedCallback(leftX, y, x - leftX)
						leftX = nil
					end
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

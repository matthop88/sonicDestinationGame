local rgbsMatch = function(r1, g1, b1, r2, g2, b2)
	return math.abs(r2 - r1) < 0.01 and math.abs(b2 - b1) < 0.01 and math.abs(g2 - g1) < 0.01
end

local rgbsMatchWithColor = function(color, r, g, b)
	return rgbsMatch(r, g, b, color.r, color.g, color.b)
end

return {
	create = function(self, params)
		return ({
			imageView  = params.imageView,
			bgColor    = params.bgColor,
			spColor    = params.spColor,

			yieldCount = 0,

			init      = function(self, spriteRects)
				self.imageWidth  = self.imageView:getWidth()
				self.imageHeight = self.imageView:getHeight()

				self.scanProcess = coroutine.create(function() self:scan(spriteRects) end)

				coroutine.resume(self.scanProcess)
    			
				return self
			end,

			update = function(self, dt)
				if self.scanProcess and coroutine.status(self.scanProcess) ~= "dead" then
    				coroutine.resume(self.scanProcess)
    			end
    		end,

			drawScanLine = function(self)
				if self.scanLineY then
					local x0, y0 = self.imageView:imageToScreenCoordinates(0, 0)
					local x,  y  = self.imageView:imageToScreenCoordinates(self.imageWidth, self.scanLineY)
					local scale = self.imageView:getScale()

					love.graphics.setColor(1, 0, 0, 0.1)
					love.graphics.rectangle("fill", x0, y0, self.imageWidth * scale, (y - y0) * scale)
					love.graphics.setColor(1, 0, 0)
					love.graphics.setLineWidth(scale)
					
					love.graphics.line(x0, y, x, y)
				end
			end,

			scan = function(self, spriteRects)
				local spriteLineScanned = function(x, y, w)
					spriteRects:addLine(x, y, w)
				end

				for y = 1, self.imageHeight - 1 do
					self.scanLineY = y
					self:scanLine(y, spriteLineScanned)

					self:yield()
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

			yield = function(self)
				self.yieldCount = self.yieldCount + 1
				if self.yieldCount % 2 == 0 then
					coroutine.yield()
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

    	}):init(params.spriteRects)
    end,
}

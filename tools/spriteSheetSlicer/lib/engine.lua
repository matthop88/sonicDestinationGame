return {
	create = function(self, params)
		return ({
			imageView   = params.imageView,
			readout     = nil,
			
			drawRects   = true,

			spriteRects = requireRelative("lib/spriteRects"):create(params),

			init = function(self)
				local bgColor = self:loadColor(__PARAMS["backgroundColor"])
				local spColor = self:loadColor(__PARAMS["spriteColor"])

				if params.isImageBad then
					bgColor = { r = 1, g = 1, b = 1 }
					spColor = { r = 0, g = 1, b = 1 }
				end

				self.scanner = requireRelative("lib/scanner"):create {
					imageView   = params.imageView,
	
					bgColor     = bgColor,
					spColor     = spColor,

					spriteRects = self.spriteRects,
				}

				return self
    		end,

    		loadColor = function(self, str)
    			local rgbValues = load("return " .. str)()

    			return { r = rgbValues[1], g = rgbValues[2], b = rgbValues[3] }
    		end,

    		draw = function(self)
    			if self.drawRects then self.spriteRects:draw() end
    			self.scanner:drawScanLine()
			end,

			update = function(self, dt)
    			self.spriteRects:update(dt)
    			self.scanner:update(dt)
    		end,

    		handleKeypressed = function(self, key)
    			if key == "r" then self.drawRects = not self.drawRects end
    		end,

			handleMousepressed = function(self, mx, my) 
    			local spriteRect = self.spriteRects:getHighlighted()
    			if spriteRect then 
        			self:getReadout():print("{ x = " .. spriteRect.x .. ", y = " .. spriteRect.y .. ", w = " .. spriteRect.w .. ", h = " .. spriteRect.h .. " }")
        			print("{ x = " .. spriteRect.x .. ", y = " .. spriteRect.y .. ", w = " .. spriteRect.w .. ", h = " .. spriteRect.h .. " }")
				end
        	end,

        	getReadout = function(self)
        		self.readout = self.readout or getReadout()
        		return self.readout
        	end,

    	}):init()

    end,

}

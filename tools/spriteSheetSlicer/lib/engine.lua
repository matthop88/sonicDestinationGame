return {
	create = function(self, params)
		return ({
			imageView   = params.imageView,
			readout     = nil,

			spriteRects = requireRelative("lib/spriteRects"):create(params.imageView),

			init = function(self)
				self.scanner = requireRelative("lib/scanner"):create {
					imageView = params.imageView,
	
					bgColor   = { r = 0.05, g = 0.28, b = 0.03 },
					spColor   = { r = 0.26, g = 0.60, b = 0.19 },
				}

				self.scanner:scan(function(x, y) self.spriteRects:add(x, y, 50, 50) end)
				
    			return self
    		end,

    		draw = function(self)
    			self.spriteRects:draw()
			end,

			update = function(self, dt)
    			self.spriteRects:update(dt)
    		end,

			handleMousepressed = function(self, mx, my) 
    			local spriteRect = self.spriteRects:getHighlighted()
    			if spriteRect then 
        			self:getReadout():print("{ x = " .. spriteRect.x .. ", y = " .. spriteRect.y .. ", w = " .. spriteRect.w .. ", h = " .. spriteRect.h .. " }")
        		end
        	end,

        	getReadout = function(self)
        		self.readout = self.readout or getReadout()
        		return self.readout
        	end,

    	}):init()

    end,

}

return {
	create = function(self, params)
		return ({
			imageView   = params.imageView,
			readout     = nil,

			spriteRects = requireRelative("lib/spriteRects"):create(params.imageView),

			init = function(self)
				self.spriteRects:add( 50,  50, 200, 200)
    							:add(300,  50, 200, 200)
    							:add( 50, 300, 200, 200)
    							:add(300, 300, 200, 200)

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

return {
	create = function(self, params)
		return ({
			imageView   = params.imageView,
			readout     = nil,
			timer       = 1,

			spriteRects = requireRelative("lib/spriteRects"):create(params.imageView),

			init = function(self)
				self.scanner = requireRelative("lib/scanner"):create {
					imageView = params.imageView,
	
					bgColor   = { r = 0.05, g = 0.28, b = 0.03 },
					spColor   = { r = 0.26, g = 0.60, b = 0.19 },
				}

				self.scanProcess = coroutine.create(function() self.scanner:scan(self.spriteRects) end)

				coroutine.resume(self.scanProcess)
				
    			return self
    		end,

    		draw = function(self)
    			self.spriteRects:draw()
			end,

			update = function(self, dt)
    			self.spriteRects:update(dt)
    			self.timer = self.timer - (dt * 30)
    			if self.timer <= 0 then
    				self.timer = 1
    				if self.scanProcess and coroutine.status(self.scanProcess) ~= "dead" then
    					coroutine.resume(self.scanProcess)
    				end
    			end
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

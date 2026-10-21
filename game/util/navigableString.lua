return {
	create = function(self, str)
		return {
			STRING  = str,
			index   = 1,

			get     = function(self)
				return self.STRING
			end,
			
			getC    = function(self)
				if self.index > #self.STRING then
					return nil
				else
					self.index = self.index + 1
					return self.STRING:sub(self.index - 1, self.index - 1)
				end
			end,

			skipC   = function(self)
		    	self.index = math.min(self.index + 1, #self.STRING + 1)
			end,

			ungetC  = function(self)
		    	self.index = math.max(self.index - 1, 1)
			end,

			splitAtIndex = function(self)
				return self.STRING:sub(1, self.index - 1), self.STRING:sub(self.index, #self.STRING)
			end,
		}

	end,
}

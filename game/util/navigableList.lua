return {
	create = function(self, list)
		return {
			list  = list,
			index = 1,

			get   = function(self)
		    	return self.list[self.index]
			end,

			next  = function(self)
		    	self.index = self.index + 1
		    	if self.index > #self.list then self.index = 1 end
			end,

			prev  = function(self)
		    	self.index = self.index - 1
		    	if self.index < 1 then self.index = #self.list end
			end,
		}

	end,

}

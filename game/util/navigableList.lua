return {
	create = function(self, list)
		list.index = 1

		list.get   = function(self)
		    return self[self.index]
		end

		list.next  = function(self)
		    self.index = self.index + 1
		    if self.index > #self then self.index = 1 end
		end

		list.prev  = function(self)
		    self.index = self.index - 1
		    if self.index < 1 then self.index = #self end
		end

		return list
	end,

}

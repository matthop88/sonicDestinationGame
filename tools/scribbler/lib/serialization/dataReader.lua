JOT_FACTORY = requireRelative("lib/serialization/jotFactory")

return {
	eachJot = function(self, name)
		local pictureData = requireRelative("data/" .. name)

		local index = 0
		local size  = #pictureData.jots
      
      	return function(self)
      		index = index + 1
      		if index <= size then 
      			return JOT_FACTORY:create(pictureData.jots[index])
      		else                  
      			return nil                 
      		end
      	end
    end,
      
}

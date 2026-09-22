JOT_FACTORY = requireRelative("lib/serialization/jotFactory")

return {
	eachJot = function(self, name)
		local pictureData = requireRelative("data/" .. name)

		local index = 0
		local size  = #pictureData
      
      	return function(self)
      		index = index + 1
      		if index <= size then 
      			return JOT_FACTORY:create(pictureData[index])
      		else                  
      			return nil                 
      		end
      	end
    end,
      
}

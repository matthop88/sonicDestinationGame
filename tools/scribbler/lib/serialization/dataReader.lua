JOT_FACTORY = requireRelative("lib/serialization/jotFactory")

return {
	eachJot = function(self, name)
		local pictureData
		local status, err = pcall(function() pictureData = requireRelative("data/" .. name) end)

		if status ~= true then
			pictureData = requireRelative("lib/serialization/scribblerNoFile")
		end

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

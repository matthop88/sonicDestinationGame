local JOT_FACTORY    = requireRelative("lib/serialization/jotFactory")
local DIRECTORY_UTIL = requireRelative("lib/util/directoryUtil")

return {
	eachJot = function(self, name)
		local pictureData
		local status, err = pcall(function() pictureData = requireRelative("data/" .. name) end)

		if status ~= true then
			pictureData = requireRelative("lib/serialization/scribblerNoFile")
			local validFilenames = DIRECTORY_UTIL:getFilesInDirectory("tools/scribbler/data", "lua")
			print("Valid filenames are:")
			print("--------------------")
			for _, validFilename in ipairs(validFilenames) do
				print(validFilename)
			end
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

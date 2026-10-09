local JOT_FACTORY    = requireRelative("lib/serialization/jotFactory")
local DIRECTORY_UTIL = require("lib/util/directoryUtil")

return {
	eachJot = function(self, name)
		local pictureData = self:loadPictureData(name)

		local index = 0
		local size  = #pictureData.jots
      
      	return function(self)
      		index = index + 1
      		if index <= size then return JOT_FACTORY:create(pictureData.jots[index])
      		else                  return nil                                     end
      	end
    end,

    loadPictureData = function(self, name)
    	local status, err = pcall(function() pictureData = requireRelative("data/" .. name) end)

		if status ~= true then
			pictureData = requireRelative("lib/serialization/scribblerNoFile")
			self:printValidScribbleNames()

			if name == "_" then love.event.quit() end
		end

		return pictureData
	end,

	printValidScribbleNames = function(self)
		local validFilenames = DIRECTORY_UTIL:getFilesInDirectory("tools/scribbler/data", "lua")
		print("\nValid Scribble names are:")
		print("-------------------------")
		for _, validFilename in ipairs(validFilenames) do
			print(validFilename)
		end
	end,
      
}

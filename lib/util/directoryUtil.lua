local STRING_UTIL  = require("game/util/stringUtil")

return {
	getFilesInDirectory = function(self, directoryName, extension)
		local filenames = love.filesystem.getDirectoryItems(directoryName)

		local filteredNames = {}

		for _, filename in ipairs(filenames) do
			if STRING_UTIL:endsWith(filename, extension) then
				table.insert(filteredNames, STRING_UTIL:dropSuffix(filename, 4))
			end
		end

		return filteredNames
        
	end,
}

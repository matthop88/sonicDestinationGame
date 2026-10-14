local STRING_UTIL  = require("game/util/stringUtil")

return {
	getFilesInDirectory = function(self, directoryName, extension)
		local filenames = love.filesystem.getDirectoryItems(directoryName)

		if not STRING_UTIL:startsWith(extension, ".") then
			extension = "." .. extension
		end

		return self:filterFilenames(filenames, extension)
        
	end,

	filterFilenames = function(self, filenames, extension)
		local filteredNames = {}

		for _, filename in ipairs(filenames) do
			if STRING_UTIL:endsWith(filename, extension) then
				table.insert(filteredNames, STRING_UTIL:dropSuffix(filename, string.len(extension)))
			end
		end

		return filteredNames
	end,

}

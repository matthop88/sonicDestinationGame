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

	getNestedFilesInDirectory = function(self, directoryName, extension)
		local filenames = love.filesystem.getDirectoryItems(directoryName)

		local validFiles = {}

		for _, filename in ipairs(filenames) do
			filename = directoryName .. "/" .. filename
			if love.filesystem.getInfo(filename, "directory") then
				local newFiles = self:getNestedFilesInDirectory(filename, extension)
				for _, newFile in ipairs(newFiles) do
					table.insert(validFiles, newFile)
				end
			elseif STRING_UTIL:endsWith(filename, extension) then
				table.insert(validFiles, STRING_UTIL:dropSuffix(filename, string.len(extension)))
			end
		end

		return validFiles
	end,

	createDirectory = function(self, path)
    	-- quote the path so spaces and special characters are safe
    	local quoted = "'" .. path:gsub("'", "'\\''") .. "'"
    	return os.execute("mkdir -p " .. quoted)
	end,

}

return {
	fileExists = function(self, path)
    	local file = io.open(path, "r")
	    if file ~= nil then
	        file:close()
	        return true
	    end
    	return false
    end,
    
}

local ERROR_LOGGER = {
	echoLogs = true,

	quiet = function(self) self.echoLogs = false end,
	loud  = function(self) self.echoLogs = true  end,

	logError = function(self, message)
		table.insert(self, message)

		if self.echoLogs then print("XXX " .. message) end
	end,
}

return ERROR_LOGGER

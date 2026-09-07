return {
	TRUE = function(self, name, expression)
		if expression == true then
			print("PASSED => " .. name)
			return true
		else
			print("FAILED => " .. name)
			return false
		end
	end,
}

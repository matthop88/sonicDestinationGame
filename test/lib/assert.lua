return {
	TRUE = function(self, name, expression)
		if expression == true then
			print("PASSED => " .. name)
		else
			print("FAILED => " .. name)
		end
	end,
}

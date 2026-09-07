local ASTERISKS = string.rep("*", 100) .. "\n"

return {
	TRUE = function(self, name, expression)
		if expression == true then
			print("PASSED => " .. name)
			return true
		else
			print("\n" .. ASTERISKS .. "FAILED => " .. name .. "\n" .. ASTERISKS)
            return false
		end
	end,
}

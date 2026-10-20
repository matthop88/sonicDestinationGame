local ASTERISKS = string.rep("*", 100) .. "\n"

return {
	TRUE   = function(self, name, expression)
		if expression == true then
			print("PASSED => " .. name)
			return true
		else
			print("\n" .. ASTERISKS .. "FAILED => " .. name .. "\n" .. ASTERISKS)
            return false
		end
	end,

	FALSE  = function(self, name, expression)
		return self:TRUE(name, not expression)
	end,

	EQUALS = function(self, name, expected, actual)
        if expected == actual then
            print("PASSED => " .. name)
            return true
        else
            print("\n" .. ASTERISKS .. "FAILED => " .. name)
            print("  Expected: ", expected)
            print("  Actual: ",   actual)
            print(ASTERISKS)
            return false
        end
    end,

    UNIMPLEMENTED = function(self, name)
    	print("UNIMPLEMENTED => " .. name)
    	return false
    end,
}

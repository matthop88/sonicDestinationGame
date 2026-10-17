local contains = function(self, v)
    for _, value in ipairs(self) do
        if v == value then return true end
    end

    return false
end

return {
	create = function(self, list)
		list.contains = contains

		return list
	end,
}

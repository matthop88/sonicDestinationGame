local contains = function(self, v)
    for _, value in ipairs(self) do
        if v == value then return true end
    end

    return false
end

return {
	create = function(self, list)
		local newList = {}

		for _, elem in ipairs(list) do table.insert(newList, elem) end

		newList.contains = contains

		return newList
	end,
}

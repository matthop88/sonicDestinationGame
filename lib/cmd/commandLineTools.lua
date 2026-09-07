local STRING_UTIL = require("game/util/stringUtil")

return {
    listArgs = function(self, args)
        key = nil
        params = {}

        for n, arg in ipairs(args) do
            if key ~= nil then
            	params[key] = arg
                key = nil
            elseif STRING_UTIL:startsWith(arg, "-") then
                key = STRING_UTIL:dropPrefix(arg, 1)
			end
		end

		for k, v in pairs(params) do
			print(k .. " = " .. v)
		end
	end,
}

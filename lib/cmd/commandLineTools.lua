local STRING_UTIL  = require("game/util/stringUtil")
local ERROR_LOGGER = require("game/error/errorLogger")

return {
    listParams = function(self, args)
    	local params = self:getParams(args)

    	for k, v in pairs(params) do
			print(k .. " = " .. v)
		end
	end,

    getParams = function(self, args)
        key = nil
        params = {}

        for n, arg in ipairs(args) do
            if     STRING_UTIL:startsWith(arg, "--") then
            	key = STRING_UTIL:dropPrefix(arg, 2)
                params[key] = true
            elseif STRING_UTIL:startsWith(arg, "-")  then
                key = STRING_UTIL:dropPrefix(arg, 1)
                params[key] = true
            elseif key ~= nil then
                params[key] = arg
                key = nil
			end
		end

		return params
	end,

    getSchema = function(self, path)
        local cmdSchema

        local status, err = pcall(function() cmdSchema = require(path .. "/cmdSchema") end)

        if status == true then
            return cmdSchema
        else
            ERROR_LOGGER:logError("Command Schema not found for path " .. path .. "!")
            return nil
        end
    end,
}


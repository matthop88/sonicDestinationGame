local STRING_UTIL  = require("game/util/stringUtil")
local ERROR_LOGGER = require("game/error/errorLogger")

local getSchema = function(path)
    local cmdSchema

    local status, err = pcall(function() cmdSchema = require(path .. "/cmdSchema") end)

    if status == true then
        return cmdSchema
    else
        ERROR_LOGGER:logError("Command Schema not found for path " .. path .. "!")
        return nil
    end
end

return {
    create = function(self, appDirectory)
        return {
            SCHEMA     = getSchema(appDirectory),
        
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

        		return self:transformParams(params)
        	end,

            transformParams = function(self, params)
                params2 = {}
                for k, v in pairs(params) do
                    if string.len(k) == 1 then
                        local fullCmd = self:expandShortcut(k)
                        if fullCmd ~= nil then params2[fullCmd] = v
                        else                   params2[k]       = v
                        end
                    else
                        params2[k] = v
                    end
                end
                
                return params2
            end,

            expandShortcut = function(self, shortcut)
                for k, v in pairs(self.SCHEMA.COMMANDS) do
                    if v.shortcut == shortcut then return k end
                end
            end,

        }
    end,

}


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
                local params = self:createParams(args)

        		return self:transformParams(params)
        	end,

            createParams = function(self, args, params)
                local params, prevKey = {}, nil
                
                for _, arg in ipairs(args) do
                    local key = self:createKey(arg)
                    if     key     ~= nil then params[key]     = true
                    elseif prevKey ~= nil then params[prevKey] = arg   end
                    
                    prevKey = key
                end

                return params
            end,

            createKey = function(self, arg)
                if     STRING_UTIL:startsWith(arg, "--") then return STRING_UTIL:dropPrefix(arg, 2)
                elseif STRING_UTIL:startsWith(arg, "-")  then return STRING_UTIL:dropPrefix(arg, 1)
                else                                          return nil                            end
            end,

            transformParams = function(self, params)
                params2 = {}

                for k, v in pairs(params) do
                    if string.len(k) == 1 then params2[self:expandShortcut(k) or k] = v
                    else                       params2[k] = v                           end
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


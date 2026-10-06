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

local DEFAULT_SCHEMA = {
    VERSION = 0.0,
    
    COMMANDS = {
        
    },
}

local convertKey = function(arg)
    if     STRING_UTIL:startsWith(arg, "--") then return { type = "key",    data = STRING_UTIL:dropPrefix(arg, 2) }
    elseif STRING_UTIL:startsWith(arg, "-")  then return { type = "key",    data = STRING_UTIL:dropPrefix(arg, 1) }
    else                                          return { type = "value",  data = arg }                        end
end

local KV_ARGS = {
    new = function()
        return {
            add = function(self, element)
                if element.type == "key" then self:addKey(element["data"])
                else                          self:addValue(element["data"]) end
            end,

            getLastElement = function(self)
                if #self > 0 then return self[#self] end
            end,

            addKey = function(self, element)
                table.insert(self, { key = element, value = true })
            end,

            addValue = function(self, element)
                local lastElement = self:getLastElement()
                if lastElement and lastElement.value == true then
                    lastElement.value = element
                end
            end,
        }
    end,
}

local ARG_EXPANDER = {
    expand = function(self, args)
        local expandedArgs = KV_ARGS.new()
                
        for _, arg in ipairs(args) do
            expandedArgs:add(convertKey(arg))
        end

        return expandedArgs
    end,

}

local PARAMS_BUILDER = {
    build = function(self, args, schema)
        local params = {}
        local expandedArgs = ARG_EXPANDER:expand(args)
        
        for _, arg in ipairs(expandedArgs) do
            local k, v = arg.key, arg.value

            if string.len(k) == 1 then params[self:expandShortcut(k, schema) or k] = v
            else                       params[k] = v                                 end
        end
                
        return params
    end,

    expandShortcut = function(self, shortcut, schema)
        for k, v in pairs(schema.COMMANDS) do
            if v.shortcut == shortcut then return k end
        end
    end,
}

return {
    create = function(self, appDirectory)
        return {
            SCHEMA     = getSchema(appDirectory) or DEFAULT_SCHEMA,

            getParams = function(self, args)
                return PARAMS_BUILDER:build(args, self.SCHEMA)
        	end,

            validateParams = function(self, args)
                local params = self:getParams(args)

                local missingParams = self:findMissingParams(params)

                if #missingParams > 0 then
                    self:printOutMissingParams(missingParams)
                    love.event.quit()
                else
                    return true
                end
            end,

            findMissingParams = function(self, params)
                local missingParams = {}

                for k, v in pairs(self.SCHEMA.COMMANDS) do
                    if v.required and params[k] == nil then
                        table.insert(missingParams, k)
                    end
                end

                return missingParams
            end,

            printOutMissingParams = function(self, params)
                print("\nERROR! The following parameters are missing:")
                for _, p in ipairs(params) do
                    self:printOutMissingParam(p)
                end

                print("\n")
            end,

            printOutMissingParam = function(self, p)
                local s = p
                if self.SCHEMA.COMMANDS[p].shortcut then
                    s = s .. " (shortcut: '-" .. self.SCHEMA.COMMANDS[p].shortcut .. "')"
                end
                print(s)
            end,

            expandShortcut = function(self, shortcut)
                return PARAMS_BUILDER:expandShortcut(shortcut, self.SCHEMA)
            end,

        }
    end,

}

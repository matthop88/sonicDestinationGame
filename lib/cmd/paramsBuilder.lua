local STRING_UTIL  = require("game/util/stringUtil")

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

return {
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

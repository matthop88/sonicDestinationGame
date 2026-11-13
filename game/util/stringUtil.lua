return {
	startsWith = function(self, str, header)
        return type(str) == "string" and str:sub(1, header:len()) == header
    end,

    endsWith = function(self, str, tail)
        return type(str) == "string" and str:sub(-tail:len()) == tail
    end,

    dropSuffix = function(self, str, suffixLength)
        return str:sub(1, str:len() - suffixLength)
    end,

    dropPrefix = function(self, str, prefixLength)
        return str:sub(prefixLength + 1, -1)
    end,

    isUppercase = function(self, str)
        return type(str) == "string" and str:upper() == str
    end,

    addQuotesIfString = function(self, v)
        if type(v) == "string" then return "\"" .. v .. "\""
        else                        return         v          end
    end,

    padValueRight = function(self, v, maxLength, padChar)
        return v .. string.rep(padChar or " ", maxLength - v:len())
    end,

    padValueLeft  = function(self, v, maxLength, padChar)
        return string.rep(padChar or " ", maxLength - v:len()) .. v
    end,

    trim = function(self, str)
        return str:match("^%s*(.-)%s*$")
    end,

    toCamelCase = function(self, str)
        local result = str:lower():gsub("%s+(%a)", function(letter)
            return letter:upper()
        end)
        return (result:gsub("%s+", ""))
    end,
}

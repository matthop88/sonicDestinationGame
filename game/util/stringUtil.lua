return {
	startsWith = function(self, str, header)
        return type(str) == "string" and string.sub(str, 1, string.len(header)) == header
    end,

    endsWith = function(self, str, tail)
        return type(str) == "string" and string.sub(str, -string.len(tail)) == tail
    end,

    dropSuffix = function(self, str, suffixLength)
        return string.sub(str, 1, string.len(str) - suffixLength)
    end,

    dropPrefix = function(self, str, prefixLength)
        return string.sub(str, prefixLength + 1, -1)
    end,

    isUppercase = function(self, str)
        return type(str) == "string" and string.upper(str) == str
    end,

    addQuotesIfString = function(self, v)
        if type(v) == "string" then return "\"" .. v .. "\""
        else                        return         v          end
    end,

    padValueRight = function(self, v, maxLength, padChar)
        return v .. string.rep(padChar or " ", maxLength - string.len(v))
    end,

    padValueLeft  = function(self, v, maxLength, padChar)
        return string.rep(padChar or " ", maxLength - string.len(v)) .. v
    end,

    trim = function(self, str)
        return str:match("^%s*(.-)%s*$")
    end,
}

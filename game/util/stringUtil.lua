return {
	startsWith = function(self, str, header)
        return string.sub(str, 1, string.len(header)) == header
    end,

    endsWith = function(self, str, tail)
        return string.sub(str, -string.len(tail)) == tail
    end,
}

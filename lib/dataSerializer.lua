local sortKVData = function(kvData)
    local sortedKVData = {}

    for k, v in pairs(kvData) do
        if type(k) ~= "number" then
            table.insert(sortedKVData, { key = k, value = v })
        end
    end

    table.sort(sortedKVData, function(a, b) return a.key < b.key end)
    return sortedKVData
end

local SERIALIZED_DATA = {
    create = function(self, objData)
        return ({
            objData       = objData,
            resultStrings = { "return {", },

            convert       = function(self)
                self:convertArrayData()
                self:convertKVData()

                self:addToResult("    ")
                self:addToResult("}")

                self:printResult()
                return self:getResult()
            end,

            convertArrayData = function(self)
                for n, _ in ipairs(self.objData) do
                    if n % 2 == 0 then
                        self:addToResult("    " .. self.objData[n - 1] .. ", " .. self.objData[n] .. ",")
                    elseif n == #self.objData then
                        self:addToResult("    " .. self.objData[n]     .. ",")
                    end
                end
            end,

            convertKVData = function(self)
                local sortedKVData = sortKVData(self.objData)
                for _, elt in ipairs(sortedKVData) do
                    local k, v = elt.key, elt.value
                    local vString = v
                    if type(v) == "string" then vString = "\"" .. v .. "\"" end
                    self:addToResult("    " .. k .. " = " .. vString .. ",")
                end
            end,

            addToResult = function(self, line)
                table.insert(self.resultStrings, line)
            end,

            getResult   = function(self)
                return self.resultStrings
            end,

            printResult = function(self)
                for _, s in ipairs(self.resultStrings) do
                    print(s)
                end
            end,


        }):convert()
    end,
}

return {
    serialize = function(self, objData)
        return SERIALIZED_DATA:create(objData)
    end,

}

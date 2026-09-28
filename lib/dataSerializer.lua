local STRING_UTIL = require("game/util/stringUtil")       

local sortKVData = function(kvData)
    local sortedKVData1 = {}
    local sortedKVData2 = {}

    for k, v in pairs(kvData) do
        if type(k) == "string" then
            if STRING_UTIL:isUppercase(k) then table.insert(sortedKVData1, { key = k, value = v })
            else                               table.insert(sortedKVData2, { key = k, value = v })
            end
        end
    end

    table.sort(sortedKVData1, function(a, b) return a.key < b.key end)
    table.sort(sortedKVData2, function(a, b) return a.key < b.key end)

    local sortedTable = {}
    for _, e in ipairs(sortedKVData1) do table.insert(sortedTable, e) end
    for _, e in ipairs(sortedKVData2) do table.insert(sortedTable, e) end
    
    return sortedTable
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

                local maxKeyLength = 0
                for _, elt in ipairs(sortedKVData) do
                    maxKeyLength = math.max(maxKeyLength, string.len(elt.key))
                end

                for _, elt in ipairs(sortedKVData) do
                    local k, v = elt.key, elt.value
                    local vString = v
                    if type(v) == "string" then vString = "\"" .. v .. "\"" end
                    local paddingSize = maxKeyLength - string.len(k)
                    self:addToResult("    " .. k .. string.rep(" ", paddingSize) .. " = " .. vString .. ",")
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

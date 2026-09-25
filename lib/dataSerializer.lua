local SERIALIZED_DATA = {
    create = function(self, objData)
        return ({
            objData       = objData,
            resultStrings = { "return {", },

            convert       = function(self)
                self:convertArrayData()

                self:addToResult("    ")
                self:addToResult("}")

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

            addToResult = function(self, line)
                table.insert(self.resultStrings, line)
            end,

            getResult   = function(self)
                return self.resultStrings
            end,


        }):convert()
    end,
}

return {
    serialize = function(self, objData)
        return SERIALIZED_DATA:create(objData)
    end,

}

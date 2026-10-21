local STRING_UTIL = require("game/util/stringUtil")

return {
	create = function(self, templateName, templatePath)
		return {
			template = requireRelative((templatePath or "templates/") .. templateName),

			parse = function(self, data)
				local templateStructure = self:getTemplateStructure()

				local kvTable = {}
				local pos = 1
				for _, kv in ipairs(templateStructure) do
					if kv.key == "" then
						pos = pos + kv.value:len()
					else
						local s, e = data:find(kv.value, pos, true)
						local v    = data:sub(pos, s - 1)
						pos = e + 1
						kvTable[kv.key] = v
					end
				end
				return kvTable
	    	end,

	    	getTemplateStructure = function(self)
	    		return self.preParser:getTemplateStructure(self.template)
	    	end,

	    	preParser = {
	    		structure = {},
	    		ID        = "",
	    		TEXT      = "",
	    		ID_MODE   = false,

	    		getTemplateStructure = function(self, template)
	    			for i = 1, #template do
	    				local c = template:sub(i, i)
	    				self:processChar(c)
	    			end

	    			table.insert(self.structure, { key = self.ID, value = self.TEXT })
	    		
	    			return self.structure
	    		end,

	    		processChar = function(self, c)
	    			if self.ID_MODE then
	    				self:processIDChar(c)
	    			else
	    				self:processTextChar(c)
	    			end
	    		end,

	    		processIDChar = function(self, c)
	    			self.ID = self.ID .. c
	    			if STRING_UTIL:endsWith(self.ID, "}}") then
	    				self.ID = STRING_UTIL:trim(STRING_UTIL:dropSuffix(self.ID, 2))
	    				self.ID_MODE = false
	    			end
	    		end,

	    		processTextChar = function(self, c)
	    			self.TEXT = self.TEXT .. c
    				if STRING_UTIL:endsWith(self.TEXT, "{{") then
    					self.ID_MODE = true
    					self.TEXT = STRING_UTIL:dropSuffix(self.TEXT, 2)
    					table.insert(self.structure, { key = self.ID, value = self.TEXT })
    					self.ID, self.TEXT = "", ""
    				end
	    		end,
	    	},
		}
	end,
}

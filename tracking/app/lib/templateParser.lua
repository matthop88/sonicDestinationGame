local STRING_UTIL = require("game/util/stringUtil")

return {
	create = function(self, templateName, templatePath)
		return {
			template = requireRelative((templatePath or "templates/") .. templateName),

			parse = function(self, data)
				return self.parser:parse(data, self:getTemplateStructure())
			end,

			parser = {
				init = function(self, data)
					self.KV_TABLE = {}
					self.POS      = 1
					self.DATA     = data
				end,

				parse = function(self, data, templateStructure)
					self:init(data)

					for _, kv in ipairs(templateStructure) do
						self:processKeyValue(kv)
					end
					return self.KV_TABLE
				end,

				processKeyValue = function(self, kv)
					if kv.key == "" then
						self.POS = self.POS + kv.value:len()
					else
						local s, e = self.DATA:find(kv.value, self.POS, true)
						local v    = self.DATA:sub(self.POS, s - 1)
						self.POS   = e + 1
						self.KV_TABLE[kv.key] = v
					end
				end,

			},

	    	getTemplateStructure = function(self)
	    		return self.preParser:getTemplateStructure(self.template)
	    	end,

	    	preParser = {
	    		init = function(self)
	    			self.structure = {}
	    			self.ID        = ""
	    			self.TEXT      = ""
	    			self.ID_MODE   = false
	    		end,

	    		getTemplateStructure = function(self, template)
	    			self:init()

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

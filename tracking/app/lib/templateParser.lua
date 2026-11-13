local STRING_UTIL = require("game/util/stringUtil")

return {
	create = function(self, templateName, templatePath)
		return {
			template = require((templatePath or "tracking/app/templates/") .. templateName),

			parse = function(self, data)
				return self.parser:parse(data, self:getTemplateStructure())
			end,

			parser = {
				init = function(self, data)
					self.KV_TABLE = {}
					self.POS      = 1
					self.DATA     = data
					self.ERROR    = nil
				end,

				parse = function(self, data, templateStructure)
					self:init(data)

					for _, kv in ipairs(templateStructure) do
						if   not self.ERROR then self:processKeyValue(kv) 
						else                     break                end
					end

					return self:handleResult()
				end,

				processKeyValue = function(self, kv)
					if kv.key == "" then
						self.POS = self.POS + kv.value:len()
					else
						self:processNonEmptyKeyValue(kv)
					end
				end,

				processNonEmptyKeyValue = function(self, kv)
					local s, e = self.DATA:find(kv.value, self.POS, true)
					if s == nil then
						self.ERROR = "ERROR: Parse error for string \"" .. kv.value .. "\" at pos = " .. self.POS
						return
					end
					local v    = self.DATA:sub(self.POS, s - 1)
					self.POS   = e + 1
					self.KV_TABLE[kv.key] = v
				end,

				handleResult = function(self)
					if self.ERROR then 
						print("\n" .. self.ERROR .. "\n")
						return {}
					else               
						return self.KV_TABLE 
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

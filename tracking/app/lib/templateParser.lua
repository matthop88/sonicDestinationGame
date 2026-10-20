local STRING_UTIL = require("game/util/stringUtil")

return {
	create = function(self, templateName, templatePath)
		return {
			template = requireRelative((templatePath or "templates/") .. templateName),

			parse = function(self, data)
				return {}
	    	end,

	    	getTemplateStructure = function(self)
	    		local structure = {}
	    		local id = ""
	    		local text = ""
	    		local idMode = false
	    		for i = 1, #self.template do
	    			local c = self.template:sub(i, i)
	    			if idMode then
	    				id = id .. c
	    				if STRING_UTIL:endsWith(id, "}}") then
	    					id = STRING_UTIL:trim(STRING_UTIL:dropSuffix(id, 2))
	    					idMode = false
	    				end
	    			else
	    				text = text .. c
	    				if STRING_UTIL:endsWith(text, "{{") then
	    					idMode = true
	    					text = STRING_UTIL:dropSuffix(text, 2)
	    					table.insert(structure, { key = id, value = text })
	    					id, text = "", ""
	    				end
	    			end
	    		end

	    		table.insert(structure, { key = id, value = text })

	    		return structure
	    	end,
		}
	end,
}

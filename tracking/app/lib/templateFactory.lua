return {
	create = function(self, templateName, templatePath)
		return {
			template = requireRelative((templatePath or "templates/") .. templateName),

			render = function(self, data)
				-- Matches anything inside {{ }} and replaces it with the table value
	    
	    		return (self.template:gsub("{{%s*(.-)%s*}}", function(key)
	        		return tostring(data[key] or "")
	    		end))
	    	end,
		}
	end,
}

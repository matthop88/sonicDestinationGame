return {
	create = function(self, templateName, templatePath)
		return {
			template = requireRelative((templatePath or "templates/") .. templateName),

			parse = function(self, data)
				return {}
	    	end,

	    	getTemplateStructure = function(self)
	    		return {}
	    	end,
		}
	end,
}

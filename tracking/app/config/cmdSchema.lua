return {
	VERSION  = 0.1,

	COMMANDS = {
		prefix = {
			shortcut = "p",
			default  = "game",
			description = "The ID prefix of the ticket.",
			values = { "game", "tool", "infr", "plug" },
		},
		type = {
			shortcut    = "t",
			default     = "Feature",
			description = "The type of the ticket.",
			values      = { "Feature", "Bug", "Experiment" },
		},
		status = {
			shortcut    = "s",
			default     = "ONGOING",
			description = "The status of the ticket.",
			values      = { "TODO", "ONGOING", "DONE" },
		},
		priority = {
			shortcut    = "P",
			default     = "Medium",
			description = "The priority of the ticket.",
			values      = { "Low", "Medium", "High" },  
		},
		points   = {
			shortcut    = "#",
			default     = "1",
			description = "The size of the ticket, measured in points.",
			values      = { "1", "2", "3", "5", "8", "13", "21", "34", "55", "89" },
		},
		commentOn = {
			shortcut    = "C",
			description = {
				"Full ticket ID to generate comments on.",
				"If this parameter is set, all other parameters are ignored",
				"and a comment block is generated for the ticket specified.",
				"If the value is set to _, all valid options from the active directory",
				"are displayed.",
			},
		},
		objectName = {
			shortcut    = "n",
			description = {
				"Name of object",
			},
			default     = "<Object Name>",
		},

	},
	
}

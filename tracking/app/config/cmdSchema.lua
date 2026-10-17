return {
	VERSION  = 0.1,

	COMMANDS = {
		prefix = {
			shortcut = "p",
			default  = "game",
			description = "The ID prefix of the ticket.",
			values = { "game", "tool", "infr" },
		},
		title = {
			shortcut = "T",
			default  = "Placeholder Title",
			description = "The title of the ticket. Surround it with quotes to allow spaces.",
		},
		type = {
			shortcut    = "t",
			default     = "Feature | Bug",
			description = "The type of the ticket.",
			values      = { "Feature", "Bug" },
		},
		status = {
			shortcut    = "s",
			default     = "TODO | ONGOING | DONE",
			description = "The status of the ticket.",
			values      = { "TODO", "ONGOING", "DONE" },
		},
		priority = {
			shortcut    = "P",
			default     = "Low | Medium | High",
			description = "The priority of the ticket.",
			values      = { "Low", "Medium", "High" },  
		},
		points   = {
			shortcut    = "#",
			default     = "1 | 2 | 3 | 5 | 8 | 13 | 21 | 34 | 55 | 89",
			description = "The size of the ticket, measured in points.",
			values      = { "1", "2", "3", "5", "8", "13", "21", "34", "55", "89" },
		},

	},
	
}

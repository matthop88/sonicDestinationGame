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

	},
	
}

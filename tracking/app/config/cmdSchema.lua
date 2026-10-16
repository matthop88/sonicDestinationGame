return {
	VERSION  = 0.1,

	COMMANDS = {
		type = {
			shortcut = "t",
			default  = "game",
			description = "The type of the ticket (will be the ticket ID prefix).",
			values = { "game", "tool", "infr" },
		},
		title = {
			shortcut = "T",
			default  = "Placeholder Title",
			description = "The title of the ticket. Surround it with quotes to allow spaces.",
		},

	},
	
}

return {
	VERSION  = 0.1,

	COMMANDS = {
		pluginName = {
			shortcut = "p",
			description = {
				"The name of the plugin to create.",
				"Presence of this argument puts us in plugin generation mode.",
			},
		},
		toolName = {
			shortcut = "t",
			description = {
				"The name of the tool to create.",
				"Presence of this argument puts us in tool generation mode.",
			},
		},
		ticketID = {
			shortcut    = "i",
			description = {
				"The ticket ID to draw from.",
				"Used primarily for comment generation.",
			},
		},
	},
	
}

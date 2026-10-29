return {
	VERSION  = 0.1,

	COMMANDS = {
		imageFile = {
			shortcut = "i",
			required = true,
			description = {
				"The name of the image file to open.",
				"Inside the directory game/resources/images/spriteSheets/sonic1/.",
				"(Choose '_' as the value to print out all options.)",
			},
		},
		verticalGapTolerance = {
			shortcut = "v",
			default  = "10",
			description = {
				"How much of a vertical gap to tolerate between adjacent sprite rects",
				"when merging them into one.",
			},
		},
		widthVarianceTolerance = {
			shortcut = "w",
			default  = "5",
			description = {
				"How much width can vary between lines of a sprite for the sprite line",
				"to be considered a member of the given sprite.",
			},
		},

	},
	
}

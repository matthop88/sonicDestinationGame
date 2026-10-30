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
		backgroundColor = {
			shortcut = "b",
			default  = "{ 0.05, 0.28, 0.03 }",
			description = {
				"A list of R, G, and B values (0.2f) enclosed in curly braces, signifying",
				"the background color which borders each sprite.",
			},
		},
		spriteColor = {
			shortcut = "s",
			default  = "{ 0.26, 0.60, 0.19 }",
			description = {
				"A list of R, G, and B values (0.2f) enclosed in curly braces, signifying",
				"the color used as a background for the sprite rect itself.",
			},
		},

	},
	
}

return {
	VERSION  = 0.1,

	COMMANDS = {
		inFile = {
			shortcut    = "i",
			required    = false,
			description = { 
				"The name of the scribbler file to open, inside the directory tools/scribbler/data/.",
				"(Defaults to an empty file.)",
			},
		},

		outFile = {
			shortcut    = "o",
			required    = false,
			description = "The name of the scribbler file to save, inside the directory tools/scribbler/data/.",
			default     = "myNewScribble",
		},

		captureFile = {
			shortcut    = "c",
			required    = false,
			description = "The name of the captured image, inside the root directory.", 
			default     = "screenShot",
		},

	},
	
}

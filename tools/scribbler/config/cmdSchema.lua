return {
	VERSION  = 0.1,

	COMMANDS = {
		inFile = {
			shortcut    = "i",
			required    = false,
			description = 
		  [[The name of the scribbler file to open, inside the directory tools/scribbler/data/. 
			Defaults to a brand new file.]],
		},

		outFile = {
			shortcut = "o",
			required = false,
			description = 
		  [[The name of the scribbler file to save, inside the directory tools/scribbler/data/. 
			Defaults to "myNewScribble".]],
		},

		captureFile = {
			shortcut = "c",
			required = false,
			description = 
		  [[The name of the captured image, inside the root directory. 
			Defaults to "screenShot".]],
		},

	},
	
}

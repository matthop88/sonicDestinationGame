# Setting up Window Parameters

Every application in the sonicDestinationGame folder has the **option** of setting window title and dimensions independently of the application itself.
This is achieved via a ***window.lua*** file in a config directory at the root level of the application.
Contents of the ***window.lua*** file are as follows:

    return {
      TITLE  = "Placeholder Window Title",
      WIDTH  = 1200,
      HEIGHT =  800,
    }

This data file is read and evaluated by the outer main when selecting your application from the command line.

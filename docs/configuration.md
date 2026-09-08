# Setting up Window Parameters

Every application in the sonicDestinationGame folder has the **option** of setting window title and dimensions independently of the application itself.
This is achieved via a ***window.lua*** file in a config directory at the root level of the application.
Contents of the ***window.lua*** file are as follows:

    return {
      title  = "Placeholder Window Title",
      width  = 1200,
      height =  800,
    }

This data file is read and evaluated by the outer main when selecting your application from the command line.

# Setting up Command Line Parameters

Every application in the sonicDestinationGame folder has the **option** of setting command line parameters to ***automagically*** populate. This is achieved via a ***cmdSchema.lua*** file in the config directory at the root level of the application.
Contents of the ***cmdSchema.lua*** file are as follows:

    return {
      VERSION = 0.1,
    
      COMMANDS = {
        loadMyFile = {
          shortcut = "f",
          required = true,                    -- This is optional!
        },
      },
    }

When accessing the application from the outer main.lua, command line parameters can be entered in the following way:

    love . myApplication --loadMyFile myFile.png

or

    love . myApplication -f myFile.png

If the argument is required, setting the required flag to true causes an error message if the argument is not set.

Command Line Parameters can be accessed in the application via the ***__PARAMS*** table. In the above example, we can check the value of the **loadMyFile** parameter via ***__PARAMS["loadMyFile"]***.


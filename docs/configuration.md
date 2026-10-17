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
          shortcut    = "f",
          required    = true,                          -- Optional
          description = "Name of file to load.", 
          -- Optional, but required for help to work
        },
        mode = {
          shortcut    = "m",
          default     = "transparent",                 -- Optional
          values      = { "transparent", "goWhite", }, -- Optional
          description = {
            "Whether to convert selected pixels to transparent,",
            "or convert them to white."
          },
        }
      },
    }

When accessing the application from the outer main.lua, command line parameters can be entered in the following way:

    love . myApplication --loadMyFile myFile.png

or

    love . myApplication -f myFile.png

If the argument is required, setting the required flag to true causes an error message if the argument is not set.

## Default Parameter Values

Parameters can be assigned default values with the optional "default" attribute. If a parameter has a default value, the "required" attribute will be make no difference, since there will be no way for the parameter to be undefined.

## Enumerated Parameter Values

Parameter values can be restricted to a small list of options via the "values" attribute. Any values entered by the user that do not fall into this list will be rejected with an error message.

Note: It is allowable to have a default value that does not belong to the list of acceptable values (such as "(IMPLEMENT THIS)", etc.)

## Parameter Descriptions and the Help Mode

Parameters can be given descriptions. It is recommended that all parameters be given descriptions so that the command line tool can be run in "help" mode; i.e.,

    love . myApplication --help

or
  
    love . myApplication -h 

This will show the acceptable parameters with a description of each one, list out the default value, whether or not it is required, and any restricted values.

Parameter descriptions are settable with the "description" attribute. A description can either be a single string or a list of strings (in which case each item in the list will be printed on a different line.)

## Accessing Command Line Parameters within the Application

Command Line Parameters can be accessed in the application via the ***__PARAMS*** table. In the above example, we can check the value of the **loadMyFile** parameter via ***__PARAMS["loadMyFile"]***.


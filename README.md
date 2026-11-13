# Sonic Destination
The coolest game in the world. Bar none.

## Running the Game

From within this directory, the game can be executed via:

    love .

or

    love . game

From within the ***game/*** directory, the game can be executed via:

    love .

## Running Unit Tests

From within this directory, Unit Tests can be run via:

    love . test

Specific test groups can be executed in the following way:

    love . test -t {name_of_test_group}

Current names of test groups are:
1. stringUtil
2. commandLineTools

## Executing Tools

Currently, there is only one tool in this project: **colorInspector**.

### Launching the Color Inspector

From within this directory, the Color Inspector can be launched via:

    love . inspector -i {name_of_image_file}

Image file location is currently hardcoded to the **game/resources/images/spriteSheets/sonic1/** directory.

Possible image names include:
1. sonic1

and that's it, really. Man, that was extensive!

### Launching the Scribbler Drawing Application

From within this directory, the Scribbler Drawing Application can be launched via:

    love . scribbler -i {name_of_input_file} -o {name-of-output-file}
The command-line arguments are optional. If an input filename is given, the Scribbler application will start with the specified drawing loaded.
If an output filename is given, the Scribbler application will save the current drawing in a file named accordingly.

Drawing location resides in the tools/scribbler/data/ directory.

Currently available picture names include:
1. sampleScribble
2. sampleScribble2

and... that's about it.

## Creating a New Ticket

Prior to creating a new tool or making changes, you should either update an existing ticket or create a new one.

From within this directory, a new ticket can be created by:

    love . ticket -p {ticket ID prefix} -T {title of ticket}
A template for the new ticket is created and added to the clipboard. It is recommended that you create a new markdown file and add it to tracking/tickets/active under the name {id}.md.

The id is given by the ticket app. For instance, if it says:
    
    Ticket template saved to clipboard (id = tool-0007)
you would create a new file, tracking/tickets/active/tool-0007.md, and paste the contents of the clipboard into this new file.

## Generating Comments from an Existing Ticket

Comments can be generated from an existing ticket which can be pasted in to the source code for a tool.
This can be done with the following command:

    love . ticket -C {ticket ID}

The ticket must be in the tracking/tickets/active directory in order for comments to be generated from it.
Once again, the comments are generated in the clipboard, and can be pasted into the source code file of your choosing.

To show the names of active tickets, you can use the following command:

    love . ticket -C _

## Generating a new Plugin using the Bootstrap Utility

Generic plugins can be generated using the bootstrap command. This creates a directory and a plugin file inside the plugins/modules directory.

    love . bootstrap -p {pluginName} -i {ticketID}

Ticket ID is optional and used for the auto generation of functional specifications in the comments section of the plugin code.

## Generating a new Tool using the Bootstrap Utility

Generic tools can also be generated using the bootstrap command. This creates a directory structure inside the tools directory corresponding with the name of the new tool. A basic config directory is also created with a skeletal window.lua and cmdSchema.lua.

In addition, code for hooking up the new tool to the outer main is copied to the clipboard; this code can be pasted into the code for the outer main.

    love . bootstrap -t {toolName} -i {ticketID}

Ticket ID is optional and used for the auto generation of functional specifications in the comments section of the tool code.

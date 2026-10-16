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

    love . ticket -t {type of ticket} -T {title of ticket}
A template for the new ticket is created and added to the clipboard. It is recommended that you create a new markdown file and add it to tracking/tickets/active under the name {id}.md.

The id is given by the ticket app. For instance, if it says:
    
    Ticket template saved to clipboard (id = tool-0007)
you would create a new file, tracking/tickets/active/tool-0007.md, and paste the contents of the clipboard into this new file.

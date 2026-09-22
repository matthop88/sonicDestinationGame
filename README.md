# Sonic Destination
The coolest game in the world. Bar none.

## Running the Game

From within this directory, the game can be executed via:

    love .

or

    love . game

From within the ***game/*** directory, the game can be executed via:

    love .

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

    love . scribbler -i {name_of_scribbler_file}
The command-line argument is optional. If given, the Scribbler application will start with the specified drawing loaded.

Drawing location resides in the tools/scribbler/data/ directory.

Currently available picture names include:
1. sampleScribble

and... that's about it.

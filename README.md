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

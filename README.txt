Smash TV
========

To build a new rom, you'll need to have CC65 installed.
On linux you should be able to get that from a package manager, on windows you'll want to install Windows Subsystem for Linux:
https://docs.microsoft.com/en-us/windows/wsl/install-win10

And then from a bash terminal, write:
`sudo apt install cc65 make`

Then in the root folder of the project, write:
`make`

And you should get an sfc file that will start the japanese release of Smash TV!

Radare2
=======

If you place the original game in this folder, and name in 'original.sfc', you can run:
`make integritycheck`

To build the game, and then compare it to the original rom and show any changes.

You will need to install radare2 (apt install radare2, for example) for this to work.

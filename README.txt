Smash TV
========

Using WLA-DX for now.

Make sure you're running in a sh prompt, with make installed..

If you're on windows, install WSL (https://docs.microsoft.com/en-us/windows/wsl/install-win10) and from a bash prompt write:
`sudo apt install make`

Then in the root folder of the project, write:
`make`

And you should get an sfc file that will start the japanese release of Smash TV!

Radare2
=======

If you place the original game in this folder, and name in 'original.sfc', you can run:
`make integritycheck`

To build the game, and then compare it to the original rom and show any changes.

You will need to install radare2 (apt install radare2, for example) for this to work.

# BK Electronika (BK0010-01) C example

This was me trying to get something to show up on-screen.
I'm glad to say that i was sucessful in doing so !

This example clears the screen to white.

# Usage

First of all, you must make sure that you have a PDP-11 Cross compiler.
You can compile one easily by following this guide :
[PDP-11 GCC Cross Compiler](https://github.com/hoglet67/PiTubeDirect/wiki/PDP-11-GCC-Cross-Compiler)

GCC 11.2 still supports this architecture.
Once you did that, you can simply compile the test program with :
```
./run.sh
```
This will compile it with the cross compiler and also compile the small utility that adds the header
to the binary. You can now run the app inside of an emulator that supports this binary format.

You can also, from a real PC, load this from tape by converting it to wav with bkbin2wav.py

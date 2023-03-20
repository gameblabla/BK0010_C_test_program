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

# Credits

[C Programming on a bare metal PDP-11](https://www.teckelworks.com/2020/03/c-programming-on-a-bare-metal-pdp-11/)
This was very helpful in helping me understand how to get it working on the PDP-11.
It also helped that the hardcoded values he used were playing nice with the BK-0010's own memory mapping !

[BK0010-01 Programming info](https://git.sr.ht/~adlpr/bk0010-01-programming/tree/main/item/bk0010-01-programming.md)
I used this initially to know about the memory mapping etc...
This was also helpful as well.

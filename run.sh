rm *.bin
pdp11-aout-gcc -Ttext=0x0200 -Tdata=0x0200 -Tbss=0x0200 -Os -fomit-frame-pointer -nostdlib -nostartfiles -ffreestanding -c main.c -o temp.bin -s
#Generate assembly
#pdp11-aout-gcc -Ttext=0x0200 -Tdata=0x0200 -Tbss=0x0200 -Os -fomit-frame-pointer -nostdlib -nostartfiles -ffreestanding -S  main.c
gcc bkbin2bin.c -o bkbin2bin.elf
./bkbin2bin.elf temp.bin main.bin
rm temp.bin *.o

rm *.bin
pdp11-aout-gcc -nostdlib -Ttext 0x200 -m10 -Os -fomit-frame-pointer -ffreestanding -N -e _start crt0.s main.c dzx1.s dzx0.s lzsa3.s -o main
pdp11-aout-objcopy -O binary main temp.bin
gcc bkbin2bin.c -o bkbin2bin.elf
./bkbin2bin.elf temp.bin main.bin
rm t.bin temp.bin

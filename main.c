#include <stddef.h>
#include <stdint.h>
#include "img.h"

#define ZX0 1
//#define LZSA3 1
//#define ZX1 1

#define SIZE 16384
#define DEST_ADDRESS ((volatile void*)040000)
#define SCREEN_MODE ((volatile unsigned char*)000040)

void clear_screen()
{
	uint16_t i;
	uint16_t *dest = (uint16_t *)DEST_ADDRESS;
    for (i = 0; i < SIZE/2; i++) {
        dest[i] = 0xFFFF;
    }
}

static void copy_screen()
{
	uint16_t *src = (uint16_t *)img;
    uint16_t *dest = (uint16_t *)DEST_ADDRESS;
    uint16_t sizeimg = sizeof(img);
    for (size_t i = 0; i < sizeimg>>1; i++) {
        dest[i] = src[i];
    }
}


void main()
{
	*SCREEN_MODE = 1;
	clear_screen();
	
#if defined(LZSA3)
	asm("mov $_img,r1");
	asm("mov $040000,r2");
	asm("jsr pc,_Unpacklzsa3");
#elif defined(ZX0)
	asm("mov $_img,r1");
	asm("mov $040000,r2");
	asm("jsr pc,_dzx0");
#elif defined(ZX1)
	asm("mov $_img,r1");
	asm("mov $040000,r2");
	asm("jsr pc,_dzx1");
#else // Uncompressed
	copy_screen();
#endif

	for(;;) {}
}

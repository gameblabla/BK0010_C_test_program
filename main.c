#include <stddef.h>
#include <stdint.h>

#define SIZE 16384
#define DEST_ADDRESS 040000

static void clear_screen()
{
    uint8_t *dest = (uint8_t *)DEST_ADDRESS;
    for (size_t i = 0; i < SIZE; i++) {
        dest[i] = 0xFF;
    }
}

void _start()
{
	clear_screen();
	for(;;)
	{
	}
	//memcpy(DEST_ADDRESS,BAK, 4096);
    //memset_prog();

}

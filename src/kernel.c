#include <multiboot.h>


void kernel_main(unsigned long magic, unsigned long addr) {
  unsigned short *vram = (unsigned short *)0xb8000;
  char *str = "hello, world!";
  char color = 0x0f;
  while(*str != '\0') {
    *vram++ = (color << 8) | *str++;
  }
}

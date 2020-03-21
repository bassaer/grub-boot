#include <multiboot.h>

#define SCREEN_START 0xb8000
#define HEIGHT       80
#define WIDTH        25

void kernel_main(unsigned long magic, unsigned long addr) {
  unsigned short *vram = (unsigned short *)0xb8000;
  char color = 0x0f;
  int len = HEIGHT * WIDTH;
  while(len > 0) {
    *vram++ = (color << 8) | ' ';
    len--;
  }
  vram = (unsigned short *)0xb8000;
  char *str = "hello, world!";
  while(*str != '\0') {
    *vram++ = (color << 8) | *str++;
  }
}

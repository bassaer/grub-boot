ELF = kernel.elf
IMG = kernel.iso

OBJ = src/boot.o \
      src/kernel.o

all: build

%.o: %.c
	gcc -c -m32 -Wall -Iinclude -fno-pie -fno-builtin -nostdlib -o $@ $^

%.o: %.S
	gcc -c -m32 -Wall -Iinclude -fno-pie -fno-builtin -nostdlib -o $@ $^

kernel.elf: ${OBJ}
	ld $^ -melf_i386  -Ttext=0x100000 --oformat elf32-i386 -o $@

install:
	sudo apt install -y gcc mtools qemu-system-i386 xorriso

build: ${ELF}
	grub-mkrescue -o ${IMG}

run:
	qemu-system-i386 -name HelloOS -localtime -cdrom $(IMG)

clean:
	rm -f src/*.o ${ELF} ${IMG}

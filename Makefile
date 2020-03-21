ELF = kernel.elf
IMG = HelloOS.iso

OBJ = src/boot.o \
      src/kernel.o

.PHONY: install build run clean

all: clean build run

%.o: %.c
	gcc -c -m32 -Wall -Iinclude -fno-pie -fno-builtin -nostdlib -o $@ $^

%.o: %.S
	gcc -c -m32 -Wall -Iinclude -fno-pie -fno-builtin -nostdlib -o $@ $^

kernel.elf: ${OBJ}
	ld $^ -melf_i386  -Ttext=0x100000 --oformat elf32-i386 -o $@

install:
	sudo apt install -y gcc mtools qemu-system-i386 xorriso

build: ${ELF}
	rm -rf dist
	mkdir -p dist/boot/grub
	cp grub.cfg dist/boot/grub/
	cp kernel.elf dist/boot/
	grub-mkrescue -o ${IMG} dist

run:
	qemu-system-i386 -name HelloOS -localtime -boot order=d -cdrom $(IMG) || true

clean:
	rm -rf src/*.o ${ELF} ${IMG} dist

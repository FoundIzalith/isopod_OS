C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
OBJ = ${C_SOURCES:.c=.o}

all: run
	mkdir build

build/kernel.o: kernel/kernel.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

build/kernelEntry.o: kernel/kernelEntry.asm 
	nasm $< -f elf -o $@

build/kernel.bin: build/kernel.o build/kernelEntry.o 
	ld -m elf_i386 -e main -o $@ -Ttext 0x1000 $^ --oformat binary 

build/bootstrap.bin: boot/bootstrap.asm
	nasm $< -f bin -o $@

build/isopod-image: build/bootstrap.bin build/kernel.bin 
	cat $^ > build/isopod-image 

run: build/isopod-image
	qemu-system-x86_64 -fda $< 

clean: 
	rm build/*.o build/*.bin

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
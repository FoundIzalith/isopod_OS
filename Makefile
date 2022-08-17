all: run

kernel.o: kernel.c
	gcc -fno-pie -m32 -ffreestanding -c $< -o $@

kernelEntry.o: kernelEntry.asm 
	nasm $< -f elf -o $@

kernel.bin: kernel.o kernelEntry.o 
	ld -m elf_i386 -e main -o $@ -Ttext 0x1000 $^ --oformat binary 

bootstrap.bin: bootstrap.asm
	nasm $< -f bin -o $@

isopod-image: bootstrap.bin kernel.bin 
	cat $^ > isopod-image 

run: isopod-image
	qemu-system-x86_64 -fda $< 

clean: 
	rm *.o *.bin

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@
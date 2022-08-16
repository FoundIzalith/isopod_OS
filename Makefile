all: run

isopod.bin: 32bit-boot.asm 
	nasm 32bit-boot.asm -o isopod.bin

run: isopod.bin
	qemu-system-x86_64 -fda $< 

clean: 
	rm *.o *.bin *.s
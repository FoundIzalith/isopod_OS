all: run

printString.s: printString.asm
	nasm $< -o $@

gdt.s: gdt.asm
	nasm $< -o $@

32bitString.s: 32bitString.asm
	nasm $< -o $@

32bit-main.s: 32bit-main.asm
	nasm $< -o $@

switchToPM.s: switchToPM.asm
	nasm $< -o $@

isopod.bin: 32bitString.s switchToPM.s printString.s gdt.s 32bit-boot.asm 
	nasm 32bit-boot.asm -o isopod.bin

run: isopod.bin
	qemu-system-x86_64 -fda $< 

clean: 
	rm *.o *.bin *.s
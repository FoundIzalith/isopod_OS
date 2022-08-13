all: run

printString.s:
	nasm printString.asm -o printString.s 

diskLoad.s:
	nasm diskLoad.asm -o diskLoad.s

isopod.bin: bootSector.asm printString.s diskLoad.s
	nasm bootSector.asm -o isopod.bin

run: isopod.bin
	qemu-system-x86_64 -fda $< 

clean: 
	rm *.o *.bin 
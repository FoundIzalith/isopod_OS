all: run

run: isopod.bin
	qemu-system-x86_64 -fda $< 

clean: 
	rm *.o *.bin 
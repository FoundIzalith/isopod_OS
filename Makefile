kernel: loader.s link.ld 
	nasm -f elf32 loader.s
	ld -T link.ld -melf_i386 loader.o -o kernel.elf

iso: kernel.elf stage2_eltorito 
	mkdir -p iso/boot/grub/
	cp stage2_eltorito iso/boot/grub 
	cp kernel.elf iso/boot
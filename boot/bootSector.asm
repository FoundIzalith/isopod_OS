[org 0x7c00]

    mov [BOOT_DRIVE], dl ; store boot drive in DL

    mov bp, 0x8000
    mov sp, bp
    
    mov bx, 0x9000 ; load 5 sectors from boot disk 
    mov dh, 5      
    mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000] 
    call print_hex

    mov dx, [0x9000 + 512]
    call print_hex

    jmp $

%include "diskLoad.asm"
%include "printHex.asm"

BOOT_DRIVE: db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
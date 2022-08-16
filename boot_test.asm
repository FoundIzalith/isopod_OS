mov ah, 0x0e

mov al, 'I'
int 0x10
mov al, 's'
int 0x10
mov al, 'o'
int 0x10
mov al, 'p'
int 0x10
mov al, 'o'
int 0x10
mov al, 'd'
int 0x10

jmp $

times 510-($-$$) db 0

dw 0xaa55
[org 0x7c00]

    mov bp, 0x9000          ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm

    jmp $

%include "printString.asm"
%include "gdt.asm"
%include "32bitString.asm"
%include "switchToPM.asm"

[bits 32]

BEGIN_PM:

    mov ebx, MSG_PROT_MODE
    call print_string_pm

    jmp $

MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE db "Landed in 32-bit Protected Mode", 0

times 510-($-$$) db 0
dw 0xaa55
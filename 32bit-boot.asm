[org 0x7c00]

    mov bp, 0x9000          ; set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string

    call switch_to_pm

    jmp $

%include "print_string.asm"
%include "gdt.asm"
%include "32bitString.asm"
%include "switch_to_pm.asm"

[bits 32]

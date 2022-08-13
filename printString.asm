print:
    pusha

print_string:
    pusha
    mov ah, 0x0e

print_loop:
    mov al, [bx]
    cmp al, 0
    je print_end

    int 0x10
    add bx, 1
    jmp print_loop

print_end:
    popa
    ret
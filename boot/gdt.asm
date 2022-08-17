;GDT file

gdt_start:

gdt_null:   ; mandatory null descriptor 
    dd 0x0
    dd 0x0

gdt_code: 
    dw 0xffff ; Limit of bits 0-15
    dw 0x0    ; base bits 0-15
    db 0x0    ; base bits 16-23
    db 10011010b ; first flags, type flags
    db 11001111b ; second flags, limit 
    db 0x0       ; base bits 24-31

gdt_data:
    dw 0xffff ; Limit of bits 0-15
    dw 0x0    ; base bits 0-15
    db 0x0    ; base bits 16-23
    db 10010010b ; first flags, type flags
    db 11001111b ; second flags, limit 
    db 0x0       ; base bits 24-31

gdt_end: ; used so assembler can calculate size of gdt for descriptor 

gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of gdt
    dd gdt_start    ; start address

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start 
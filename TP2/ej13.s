section .data
    msg db "Mi pid es: ", 0
    intro db 10, 0

section .bss
    buffer resb 10

section .text
    global _start
    extern int_to_string
    extern print_string
    extern exit

_start:
    push msg
    call print_string

    mov eax, 20
    int 0x80

    push buffer
    push eax
    call int_to_string

    push buffer
    call print_string

    push intro
    call print_string

    call exit
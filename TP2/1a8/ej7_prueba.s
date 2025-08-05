EXTERN find_min
EXTERN exit
EXTERN int_to_string
EXTERN print_string

section .data
    array dd 9, 13, 10, 4, -8, 43, 1, 0, -2, 
    len equ ($ - array) / 4 
    msg db "Minimo: ", 0
    msg_end db 10, 0

section .bss
    buffer resb 12

section .text
    global _start


_start:

    mov esi, msg
    call print_string

    mov eax, array
    mov ecx, len
    mov edi, buffer
    call find_min

    mov esi, msg_end
    call print_string

    call exit

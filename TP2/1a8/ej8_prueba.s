EXTERN sort_array
EXTERN exit
EXTERN print_string

section .data
    array dd 9, 7, 4, 1, 2, 5, 7, -3, -19, 0, 5
    len equ ($ - array) / 4 
    msg db "Array ordenado: ", 0
    space db 32, 0
    msg_end db 10, 0

section .bss
    buffer resb 12

section .text
    global _start

_start:

    mov esi, msg
    call print_string

    mov esi, space
    mov eax, array
    mov ecx, len
    mov edi, buffer
    call sort_array

    mov esi, msg_end
    call print_string

    call exit

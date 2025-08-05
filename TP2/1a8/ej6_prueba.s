EXTERN factorial
EXTERN exit
EXTERN int_to_string
EXTERN print_string

section .data
    msg1 db "! = ", 0
    msg_end db 10, 0
section .bss
    buffer resb 256

section .text
    global _start

_start:

    mov eax, 5      ;n
    mov edi, buffer
    call int_to_string
    mov esi, buffer
    call print_string

    mov esi, msg1
    call print_string
    
    mov eax, 5    ;n
    mov edi, buffer
    call factorial
    
    mov esi, msg_end
    call print_string

    call exit

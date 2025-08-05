    EXTERN print_multiples
    EXTERN exit
    EXTERN int_to_string
    EXTERN print_string
section .data
    msg1 db "Los numeros entre 1 y ", 0
    msg2 db " que son multiplos de ", 0
    msg3 db " son: ", 10, 0
    msg_end db 10, 0
section .bss
    buffer resb 256
section .text
    global _start

_start:
    mov esi, msg1
    call print_string

    mov eax, 100      ;k
    mov edi, buffer
    call int_to_string
    mov esi, buffer
    call print_string

    mov esi, msg2
    call print_string

    mov eax, 2
    mov edi, buffer
    call int_to_string
    mov esi, buffer
    call print_string

    mov esi, msg3
    call print_string

    mov eax, 2000          ; n
    mov ebx, 100000         ; k
    mov edi, buffer
    call print_multiples

    mov esi, msg_end
    call print_string

    call exit           ; Salir del programa
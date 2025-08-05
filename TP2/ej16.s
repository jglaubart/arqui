EXTERN exit
EXTERN print_string

EXTERN toupper
section .bss
    buffer resb 16      

section .text
    global _start

_start:
    push ebp
    mov ebp, esp

    mov eax, 3
    mov ebx, 0
    mov ecx, buffer
    mov edx, 255     ;no se la longitud del string, leo el maximo
    int 0x80

    mov byte [buffer + eax], 0    ; Agrego EOF al final del buffer

    push buffer
    call toupper

    push buffer
    call print_string

    mov esp, ebp
    pop ebp
    call exit

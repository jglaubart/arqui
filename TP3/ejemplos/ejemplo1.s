GLOBAL main
EXTERN printf
section .rodata
fmt db "Cantidad de argumentos: %d", 0
intro db 10, 0

section .text
main:
    push ebp
    mov ebp, esp
    mov eax, dword [ebp+8]
    dec eax
    push eax
    push fmt
    call printf
    mov esi, [ebp+12]
    add esi, 4
    mov ebx, [ebp+8]
    dec ebx

.ciclo:
    cmp ebx, 0
    je .fin
    push intro
    call printf
    lodsd
    push eax
    call printf
    dec ebx
    jmp .ciclo
.fin:
    push intro
    call printf
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret
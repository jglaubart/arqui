extern int_to_string
extern print_string
extern exit

section .data
    msg db "Bytes recorridos: ", 0
    intro db 32, 0
section .bss
    buffer resb 10      ; Buffer para almacenar el número de bytes recorridos

section .text
    global _start

_start:
    mov ebp, esp

.argLoop:
    add ebp, 4
    cmp dword [ebp], 0  ; Salteo el null que separa los argumentos de las variables de entorno
    je .varLoop
    jmp .argLoop

.varLoop:
    add ebp, 4
    cmp dword [ebp], 0  ; Salteo el null
    je .end
    jmp .varLoop
.end:
    mov eax, esp
    mov ecx, ebp
    sub ecx, eax
    push buffer
    push ecx
    call int_to_string
    push buffer
    call print_string
    push intro
    call print_string

    call exit
    
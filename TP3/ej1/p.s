global main
extern printf

section .rodata
    fmt db "Cantidad de argumentos: %d", 10, 0
    fmt_arg db "Argumento %d: %s", 10, 0

section .text
main:
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    dec eax
    push eax
    push fmt
    call printf
    add esp, 2*4

    mov edi, [ebp + 8]
    xor esi, esi
    inc esi
    mov ebx, [ebp + 12] ;argv
    add ebx, 4    ;salteo filename

.loop:
    cmp esi, edi 
    je .end
.print:
    mov ecx, [ebx -4 + esi*4]
    push ecx
    push esi
    push fmt_arg
    call printf
    add esp, 3*4
    inc esi
    jmp .loop

.end:
    mov esp, ebp
    pop ebp
    ret
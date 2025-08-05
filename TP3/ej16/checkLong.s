global checkLong
global msg
global len

section .text

checkLong:
    push ebp
    mov ebp, esp
    push ebx

    mov ebx, [ebp + 8]    ;array
    mov ecx, [ebp + 12]   ;len
    xor eax, eax          ;contador
.loop:
    cmp byte[ebx + eax], 0
    je .end
    inc eax
    jmp .loop
.end:
    sub eax, ecx
    pop ebx
    leave
    ret

section .data
    msg db "Hola Mundo", 0
    len db 10


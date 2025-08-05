global fibo
section .text
fibo:
    push ebp
    mov ebp, esp
    push ebx
    
    mov eax, [ebp+8]   ;primer parametro de fibonacci
    cmp eax, 0
    je .fin
    cmp eax, 1
    je .fin
    
    mov ecx, 0
    mov edx, 1
    mov esi, 2

.loop:
    cmp esi, eax
    jg .fin

    mov ebx, edx
    add ebx, ecx
    mov ecx, edx
    mov edx, ebx
    inc esi
    jmp .loop

.fin:
    mov eax, edx
    pop ebx
    mov esp, ebp
    pop ebp
    ret
global _start
global capitalize

section .data
    msg db "hola mundo", 10, 0
    len equ $-msg

section .text
_start:
    push ebp
    mov ebp, esp
    mov ecx, msg
    mov edx, len
    mov ebx, 1
    mov eax, 4
    int 80h

    push ecx
    call capitalize
    add esp, 4
    mov edi, eax   ; eax = #palabras ---> guardo en edi
    mov ebx, 1
    mov eax, 4
    int 80h

    mov esp, ebp
    pop ebp
    mov eax, 1
    mov ebx, 0
    int 80h

capitalize:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8] ; string
    xor esi, esi
    mov edi, 1 ; flag
.loop:
    cmp edi, 0
    je .check_space
    inc esi
    push ebx
    call islower
    add esp, 4
    cmp eax, 0
    je .check_space
    push ebx        ;puntero
    call toupper
    add esp, 4
    xor edi, edi
    jmp .next

.check_space:
    cmp byte[ebx], ' '
    jne .next
    mov edi, 1

.next:
    inc ebx
    cmp byte[ebx], 0
    jne .loop
    mov eax, esi
    leave
    ret


islower:
    push ebp
    mov ebp, esp
    pushad
    xor eax, eax
    mov ebx, [ebp + 8]
    cmp byte[ebx], 'a'
    jl .not
    cmp byte[ebx], 'z'
    jg .not
    mov eax, 1
.not:
    popad
    leave
    ret


toupper:
    push ebp
    mov ebp, esp
    pushad
    mov edx, [ebp + 8]
    add byte[edx], 'A' - 'a'
    popad
    leave
    ret
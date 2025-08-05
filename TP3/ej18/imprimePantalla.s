;int imprime_pantalla(char *encabezado, int tam_enc, char *pie, int tam_pie)
global imprime_pantalla
global buffer_prueba

section .bss
    buffer_prueba resb 480
section .text
imprime_pantalla:
    push ebp
    mov ebp, esp
    push ebx
    mov ebx, [ebp + 16]   ;char *pie
    mov ecx, [ebp + 20]   ;len

.check_len:
    cmp ecx, 1
    jl .out_of_range
    cmp ecx, 80
    jg .out_of_range
    
    push ecx
    push ebx
    call imprimir_pie
    add esp, 2*4
    xor eax, eax
    jmp .fin

.out_of_range:
    mov eax, 1
.fin:
    pop ebx
    leave
    ret

imprimir_pie:
    push ebp
    mov ebp, esp
    mov ebx, [ebp + 8]
    mov ecx, [ebp + 12]
    xor edi, edi 

    ;mov esi, 0xA0000000   ; fila 5 = 5 x 80 = 400    ---> debe ser asi, lo saco para probarlo
    mov esi, buffer_prueba
    add esi, 400
.loop:
    cmp ecx, edi 
    je .fin 
    mov al, byte [ebx + edi]    ;guardo el siguiente caracter en eax
    mov [esi + edi], al         ;pego el caracter en la dir de memoria correspondiente
    inc edi 
    jmp .loop
.fin:
    leave
    ret



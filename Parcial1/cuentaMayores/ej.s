; Implementar una funcion que reciba un arreglo de enteros, su longitud y un umbral 
;y cuente cuantos elementos son mayores estrictos que el umbral

; int cuentaMayores(int *vec, int len, int umbral);

global cuentaMayores
extern printf

section .rodata
    debug db "llega", 10, 0
section .text

cuentaMayores:
    push ebp
    mov ebp, esp
    push ebx    ;necesario cuando se llama a una funcion ASM desde C


    mov ebx, [ebp + 8]   ;vec
    mov ecx, [ebp + 12]  ;len
    mov edx, [ebp + 16]  ;umbral
    xor esi, esi         ;contador vec
    xor edi, edi         ;ans

    cmp ecx, 0
    je .fin

.loop:
    cmp esi, ecx
    je .fin
    mov eax, [ebx + 4*esi] 
    cmp eax, edx
    jle .next
    
    inc edi
.next:
    inc esi
    jmp .loop
.fin:
    pop ebx
    mov eax, edi
    mov esp, ebp
    pop ebp
    ret
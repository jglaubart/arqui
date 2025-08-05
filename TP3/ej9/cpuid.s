global get_cpuid

get_cpuid:
    push ebp
    mov ebp, esp

    push ebx    ;siempre debe preservarse cuando se llama a una funcion asm desde C

    ; EAX = 0: Información del fabricante del procesador.
    ; EAX = 1: Información sobre el procesador (familia, modelo, etc.).
    ; EAX = 4: Información sobre las cachés del procesador.
    
    mov eax, [ebp + 8]
    mov esi, [ebp+12]
    cmp esi, 0
    je .error
    cpuid

    mov [esi], ebx
    mov [esi + 4], edx
    mov [esi + 8], ecx

    pop ebx

    mov esp, ebp
    pop ebp
    ret

    .error:
        ; Imprimir el mensaje de error
        mov eax, 4                  ; Código de sistema para sys_write
        mov ebx, 1                  ; Descriptor de archivo 1 (stdout)
        mov ecx, error_msg          ; Dirección del mensaje de error
        mov edx, error_msg_len      ; Longitud del mensaje (22 caracteres)
        int 0x80            ; Llamada al sistema para escribir

        ; Salir del programa con código de error
        mov eax, 1          ; Código de sistema para sys_exit
        xor ebx, ebx        ; Código de salida (0)
        int 0x80            ; Llamada al sistema para salir

section .data
    error_msg db "Error: Invalid buffer", 10
    error_msg_len equ $ - error_msg

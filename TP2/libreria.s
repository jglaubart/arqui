; Función: print_string

global print_string
print_string:
    push ebp
    mov ebp, esp

    mov eax, 4            ; syscall: write
    mov ebx, 1            ; file descriptor: stdout
    mov ecx, [ebp+8]      ; Dirección de la cadena
    mov edx, 0            ; Inicializar longitud
find_length:
    cmp byte [ecx + edx], 0 ; Buscar el final de la cadena
    je write_string
    inc edx
    jmp find_length
write_string:
    int 0x80              ; Llamada al sistema
    mov esp, ebp
    pop ebp
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Función: exit
; Salir del programa
global exit
exit:
    mov eax, 1            ; syscall: exit
    xor ebx, ebx          ; código de salida 0
    int 0x80              ; Llamada al sistema

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Función: int_to_string
; Convierte un número entero en una cadena terminada en 0

global int_to_string
int_to_string:
; back up de registros
    push ebp
    mov ebp, esp

    push ebx
    push esi
    push edi
    push ecx
    push eax
    push edx  

    mov eax, [ebp+8]      ; Número a convertir (primer parámetro)
    mov edi, [ebp+12]     ; Dirección del buffer (segundo parámetro)

    mov ecx, 10           ; Divisor (base 10)
    xor esi, esi          ; Contador de dígitos (inicializado a 0)

    cmp eax, 0
    jge convert_digit

    neg eax
    mov byte [edi], '-'
    inc edi 

convert_digit:
    xor edx, edx          
    div ecx               
    add dl, '0'           
    push dx               
    inc esi               
    test eax, eax         
    jnz convert_digit     
write_digits:
    pop ax                
    mov byte [edi], al    
    inc edi               
    dec esi               
    jnz write_digits      

    mov byte [edi], 0     

    pop edx
    pop eax
    pop ecx
    pop edi 
    pop esi
    pop ebx

    leave  ; Equivalente a "mov esp, ebp" + "pop ebp"
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Funcion toupper: pasa un string a mayuscula

global toupper
toupper:         ; Pasa un string a mayuscula
    push ebp
    mov ebp, esp

    mov esi, [ebp+8]    ; Dirección del string

.next_char:
    mov al, [esi]
    cmp al, 0
    je .done            ; Fin del string

    cmp al, 'a'
    jb .skip
    cmp al, 'z'
    ja .skip

    sub al, 32
    mov [esi], al

.skip:
    inc esi
    jmp .next_char

.done:
    mov esp, ebp
    pop ebp
    ret

; Función: print_string
; Muestra una cadena terminada en 0 por consola
; Entrada: ESI = dirección de la cadena
global print_string
print_string:
    mov eax, 4            ; syscall: write
    mov ebx, 1            ; file descriptor: stdout
    mov ecx, esi          ; Dirección de la cadena
    mov edx, 0            ; Inicializar longitud
find_length:
    cmp byte [esi + edx], 0 ; Buscar el final de la cadena
    je write_string
    inc edx
    jmp find_length
write_string:
    int 0x80              ; Llamada al sistema
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; Función: to_uppercase
; Convierte una cadena a mayúsculas
; Entrada: ESI = dirección de la cadena de entrada
;          EDI = dirección de la cadena de salida
global to_uppercase
to_uppercase:
    push esi
    push edi
convert_loop:
    mov al, byte [esi]    
    cmp al, 0             
    je convert_done       

    ; Verificar si es una letra minúscula (a-z)
    cmp al, 'a'
    jl not_lowercase
    cmp al, 'z'
    jg not_lowercase

    ; Convertir a mayúscula
    sub al, 32

not_lowercase:
    mov byte [edi], al    
    inc esi              
    inc edi              
    jmp convert_loop

convert_done:
    mov byte [edi], 0     ; Terminar la cadena de salida con 0
    pop edi
    pop esi
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
; Entrada: EAX = número a convertir
;          EDI = dirección de la zona de memoria para el string
global int_to_string
int_to_string:
; back up de registros
    push eax              ; Guardar EAX en la pila
    push edi              ; Guardar EDI en la pila
    push ebx
    push ecx
    push edx

    mov ecx, 10           ; Divisor (base 10)
    xor esi, esi          ; Contador de dígitos (inicializado a 0)

    test eax, eax         ; ¿Es el número negativo?
    jns convert_digit

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
    pop ecx
    pop ebx
    pop edi               ; Restaurar EDI
    pop eax               ; Restaurar EAX
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Dado un número n, imprimir la suma de los primeros n números naturales (No utilizar
; una fórmula). 

global n_sum
n_sum:
    push eax              ; Guardar EAX en la pila

    xor esi, esi


sum:
    
    add esi, eax
    dec eax
    jnz sum

    mov eax, esi          ;int_to_string recibe el int en eax
    call int_to_string

    pop eax
    ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Dado un número n y un valor k, imprimir todos los valores múltiplos de n desde 1 hasta k. 
; EAX = n
; EBX = k
; EDI = dirección del buffer
global print_multiples
print_multiples:
    push ebx              ; Guardar EBX en la pila
    push ecx              ; Guardar ECX en la pila
    push edx              ; Guardar EDX en la pila
    push esi              ; Guardar ESI en la pila
    push edi              ; Guardar EDI en la pila

    mov ecx, eax          ; Guardar n en ECX
    mov esi, ebx          ; Guardar k en ESI
    mov ebx, 1            ; Contador desde 1
    
    loop_multiples:
    mov eax, ecx          ; Copiar n a EAX
    mul ebx               ; EAX = n * contador
    cmp eax, esi          ; ¿n * contador > k?
    jg done_multiples     ; Si es mayor, terminamos

    push ebx              ; Guardar contador en la pila
    push ecx              ; Guardar n en la pila
    push esi              ; Guardar k en la pila
    push edi              ; Guardar dirección del buffer

    call int_to_string    ; Convertir número a string

    mov esi, edi          ; Dirección de la cadena convertida
    call print_string     ; Imprimir el número

    mov esi, newline
    call print_string

    pop edi               ; Restaurar dirección del buffer
    pop esi               ; Restaurar k
    pop ecx               ; Restaurar n
    pop ebx               ; Restaurar contador

    inc ebx               ; Incrementar el contador
    jmp loop_multiples    ; Repetir el ciclo
    
    done_multiples:
    pop edi               ; Restaurar EDI
    pop esi               ; Restaurar ESI
    pop edx               ; Restaurar EDX
    pop ecx               ; Restaurar ECX
    pop ebx               ; Restaurar EBX
    ret
    
    section .data
    newline db 10, 0      ; Salto de línea

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Dado un número n, imprimir su factorial.
; EAX = n
; EDI = dirección del buffer

global factorial
factorial:
    push eax      ;para multiplicar
    push esi      ;contador
    push ebx      ;resultado
    push edi      ;buffer

    mov esi, eax ;contador = n
    mov ebx, 1   ;resultado = 1
    
    loop_factorial:
    cmp esi, 0
    je done_factorial

    mov eax, esi
    mul ebx 
    mov ebx, eax
    dec esi
    jmp loop_factorial
    
    done_factorial:
    mov eax, ebx
    call int_to_string
    mov esi, edi 
    call print_string

    pop edi
    pop ebx
    pop esi
    pop eax
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Función: find_min
; Encuentra el menor valor en un array de enteros
; Entrada: 
;   EAX = dirección del array
;   ECX = cantidad de elementos
;   EDI = direccion de buffer
global find_min
find_min:
   push ecx
   push edx
   push ebx

   test ecx, ecx
   jz done_find_min
   
   mov edx, eax
   mov ebx, eax
   mov eax, [edx]
   add edx, 4
   dec ecx

   loop_min:
   test ecx, ecx
   jz done_find_min
   mov esi, [edx]
   cmp esi, eax
   jge not_min

   mov eax, esi
   mov ebx, edx

   not_min:
   add edx, 4
   dec ecx
   jmp loop_min

   done_find_min:
   mov eax, [ebx]
   push ebx
   call int_to_string
   mov esi, edi
   call print_string
   pop ebx
  
   
   mov eax, ebx

   pop ebx
   pop edx
   pop ecx
   ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; funcion sort_array: ordena un array de enteros
; EAX = direccion del array
; ECX = longitud del array
; EDI = direccion del buffer

global sort_array

sort_array:
    push edx
    push esi
    push ecx

    mov ebx, eax   ;ebx se va moviendo por el array

    loop_sort:
    test ecx, ecx
    jz done_sort

    mov eax, ebx
    push ebx
    push ecx
    call find_min  ;deja la direccion del menor en eax

    pop ecx
    pop ebx
    swap:
    mov esi, [eax] ;guarda el menor en esi
    mov edx, [ebx] 
    mov [ebx], esi ;guarda el menor al principio
    mov [eax], edx

    add ebx, 4
    dec ecx
    jmp loop_sort

    done_sort:
    pop ecx
    pop esi
    pop edx
    ret
    
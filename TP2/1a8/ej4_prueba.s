EXTERN n_sum
EXTERN print_string
EXTERN exit
EXTERN int_to_string

section .data
    msg db "La suma de los primeros ", 0
    msg2 db " numeros naturales es: ", 0
    msg_end db 10, 0

section .bss
    output resb 256       ; Espacio para la cadena convertida

section .text
    global _start

_start:
    ; Mostrar el mensaje inicial
    mov esi, msg          ; Dirección del mensaje "La suma de los primeros "
    call print_string

    ; Mostrar el número n
    mov eax, 92681           ; Número n (por ejemplo, 10)
    mov edi, output       ; Dirección de salida para convertir el número
    call int_to_string    ; Convertir el número a cadena
    mov esi, output       ; Dirección de la cadena convertida
    call print_string     ; Imprimir el número

    ; Mostrar el mensaje intermedio
    mov esi, msg2         ; Dirección del mensaje " numeros naturales es: "
    call print_string

    ; Calcular la suma de los primeros n números naturales
    mov eax, 92681           ; defino número n (92681 maximo que resueve en mi compu)
    call n_sum            ; Llamar a la función nSum

    ; Mostrar el resultado de la suma
    mov esi, output       ; Dirección de la cadena con el resultado
    call print_string     ; Imprimir el resultado

    ; Mostrar un salto de línea
    mov esi, msg_end      ; Dirección
    call print_string     ; Imprimir

    ; Salir del programa
    call exit